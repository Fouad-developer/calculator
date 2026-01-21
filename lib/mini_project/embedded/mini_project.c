#include "msp.h"
#include "driverlib.h"
#include "dht22.h"
#include "lcd_4bit.h"
#include "keypad.h"
#include "aes256.h"
#include <stdio.h>
#include <string.h>


// Measurement intervalthat DHT22 must respect (s). Default = 10s
volatile uint32_t measurement_interval = 10;
 
//FSM trigger flag: When true → the system leaves IDLE and goes to READ_DHT22
volatile bool do_measurement = true;

// AES-256 key (32 bytes = 256-bit key) for the encryption
uint8_t aes_key[32] = {
    0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,
    0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F,
    0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17,
    0x18,0x19,0x1A,0x1B,0x1C,0x1D,0x1E,0x1F
};

uint8_t plaintext[16];     // Data before encryption
uint8_t ciphertext[16];    // Data after encryption

// CLOCK INITIALIZATION
void init_clocks(void) {
    CS_setDCOFrequency(CS_DCO_FREQUENCY_12); 
    CS_initClockSignal(CS_MCLK, CS_DCOCLK_SELECT, CS_CLOCK_DIVIDER_1);//The main clock
    CS_initClockSignal(CS_SMCLK, CS_DCOCLK_SELECT, CS_CLOCK_DIVIDER_1);//Used for UART 
    CS_initClockSignal(CS_HSMCLK,CS_DCOCLK_SELECT, CS_CLOCK_DIVIDER_1);//Used for Timer_A
}

// UART INITIALIZATION (115200Baudrate)
void init_uart_115200(void) {
    const eUSCI_UART_ConfigV1 uartConfig = {
        EUSCI_A_UART_CLOCKSOURCE_SMCLK,
        6,  
        8,  
        0,  
        EUSCI_A_UART_NO_PARITY,
        EUSCI_A_UART_LSB_FIRST,
        EUSCI_A_UART_ONE_STOP_BIT,
        EUSCI_A_UART_MODE,
        EUSCI_A_UART_OVERSAMPLING_BAUDRATE_GENERATION
    };

    // P1.2 = RX, P1.3 = TX
    GPIO_setAsPeripheralModuleFunctionInputPin(
        GPIO_PORT_P1,
        GPIO_PIN2 | GPIO_PIN3,
        GPIO_PRIMARY_MODULE_FUNCTION
    );//just to configure pin 2 and 3 of port 1 as UART pins

    UART_initModule(EUSCI_A0_BASE, &uartConfig);
    UART_enableModule(EUSCI_A0_BASE);
}


// SEND_UART state (encrypted block)
void send_encrypted(void) {
    uint8_t i;
    for(i = 0; i < 16; i++) {
        UART_transmitData(EUSCI_A0_BASE, ciphertext[i]);
    }
}

// Timer_A0 interrupt → triggers the FSM to leave IDLE
// This is the START SIGNAL for the next cycle
void TA0_0_IRQHandler(void) {
    Timer_A_clearCaptureCompareInterrupt(
        TIMER_A0_BASE,//address of Timer A0 module
        TIMER_A_CAPTURECOMPARE_REGISTER_0//CCR0 register that generated the interrupt
    );
    do_measurement = true;    //ready for next measurement
}

int main(void) {

    // SYSTEM INITIALIZATION
    // IDLE starts here, waiting for Timer or first measurement
    WDT_A_holdTimer();
    init_clocks();
    init_uart_115200();
    LCD_init();
    Keypad_init();
    DHT22_init();

    LCD_clear();
    LCD_write_string("DHT22 Logger");
    LCD_set_cursor(1, 0);//where the text will start to be written
    LCD_write_string("Init OK...");

    // TIMER CONFIGURATION → defines measurement interval
    // Timer interrupt = leave IDLE state
    // ------------------------------------------------------------
    Timer_A_UpModeConfig timerConfig = {
        TIMER_A_CLOCKSOURCE_SMCLK,
        TIMER_A_CLOCKSOURCE_DIVIDER_64,
        187500 * measurement_interval, // default 10 sec
        TIMER_A_TAIE_INTERRUPT_DISABLE,
        TIMER_A_CCIE_CCR0_INTERRUPT_ENABLE,
        TIMER_A_DO_CLEAR
    };

    Timer_A_configureUpMode(TIMER_A0_BASE, &timerConfig);
    Timer_A_startCounter(TIMER_A0_BASE, TIMER_A_UP_MODE);
    Interrupt_enableInterrupt(INT_TA0_0);
    Interrupt_enableMaster();

    float temp = 0.0f, hum = 0.0f;
    char buf[20];

    // MAIN LOOP → the FSM runs inside this while(1)
    while(1) {

        // KEYPAD HANDLER (not part of FSM, runs anytime)
        // Allows changing measurement interval
        char key = Keypad_getkey();
        if(key >= '0' && key <= '9') {

            measurement_interval = key - '0';
            if(measurement_interval == 0) measurement_interval = 10;//means 10s

            // Update Timer with new interval
            uint32_t ticks = 187500UL * measurement_interval;
            Timer_A_setCompareValue(
                TIMER_A0_BASE,
                TIMER_A_CAPTURECOMPARE_REGISTER_0,
                ticks
            );

            // Show interval on LCD
            sprintf(buf, "Int:%2lu s ", measurement_interval);
            LCD_set_cursor(1, 0);
            LCD_write_string(buf);

            // Small delay for display
            __delay_cycles(12000000);
        }

        // IDLE STATE
        // Waiting for Timer to set do_measurement = true
        if(do_measurement) {
            do_measurement = false;

            // READ_DHT22 STATE
            if(DHT22_read(&temp, &hum)) {
                // UPDATE_LCD STATE
                // Display the new readings
                sprintf(buf, "T:%5.1f C", temp);
                LCD_set_cursor(0, 0);
                LCD_write_string(buf);

                sprintf(buf, "H:%5.1f %% ", hum);
                LCD_set_cursor(1, 0);
                LCD_write_string(buf);

                // PREPARE_DATA STATE
                // Format exactly 16 bytes for AES block
                sprintf((char*)plaintext,
                        "%05.1f%05.1f",
                        temp, hum);

                // AES256_ENCRYPT STATE
                // Hardware AES accelerator encrypts 16 bytes
                AES256_setCipherKey(
                    AES256_BASE,
                    aes_key,
                    AES256_KEYLENGTH_256BIT
                );

                AES256_encryptData(
                    AES256_BASE,
                    plaintext,
                    ciphertext
                );

                // SEND_UART STATE
                // Send encrypted 16-byte block to PC
                send_encrypted();

                // FSM now automatically returns to IDLE
            }
            else {
                // READ_DHT22 failed → stay in IDLE
                LCD_set_cursor(1, 0);
                LCD_write_string("DHT22 Error! ");
            }
        }
    }
}
