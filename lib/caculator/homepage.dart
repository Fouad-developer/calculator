import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training/caculator/cart_P.dart';
import 'package:training/caculator/tab.dart';

class HomePage_P extends StatefulWidget {
  const HomePage_P({super.key});

  @override
  State<HomePage_P> createState() => _Homepage_PState();
}

class _Homepage_PState extends State<HomePage_P> {
  @override
  bool new_operation = false;
  bool dont_press_equ = false;
  @override
  Widget build(BuildContext context) {
    List<String> input = [];
    String result = "";
//⌫ Backspace
    List<Tabs> tabs = [
      Tabs(charac: "C", color: const Color(0xFFFF6B6B)), // Coral Red
      Tabs(charac: "⌫", color: const Color(0xFF4A5568)), // Cool Gray
      Tabs(charac: "%", color: const Color(0xFF4A5568)), // Cool Gray
      Tabs(charac: "/", color: const Color(0xFF667EEA)), // Indigo Blue
      Tabs(charac: "7", color: const Color(0xFF2D3748)), // Dark Slate
      Tabs(charac: "8", color: const Color(0xFF2D3748)),
      Tabs(charac: "9", color: const Color(0xFF2D3748)),
      Tabs(charac: "*", color: const Color(0xFF667EEA)), // Indigo Blue
      Tabs(charac: "4", color: const Color(0xFF2D3748)),
      Tabs(charac: "5", color: const Color(0xFF2D3748)),
      Tabs(charac: "6", color: const Color(0xFF2D3748)),
      Tabs(charac: "-", color: const Color(0xFF667EEA)), // Indigo Blue
      Tabs(charac: "1", color: const Color(0xFF2D3748)),
      Tabs(charac: "2", color: const Color(0xFF2D3748)),
      Tabs(charac: "3", color: const Color(0xFF2D3748)),
      Tabs(charac: "+", color: const Color(0xFF667EEA)), // Indigo Blue
      Tabs(charac: "0", color: const Color(0xFF2D3748)),
      Tabs(charac: "00", color: const Color(0xFF2D3748)),
      Tabs(charac: ".", color: const Color(0xFF2D3748)),
      Tabs(charac: "=", color: const Color(0xFF48BB78)), // Success Green
    ];
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Calculator',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFF1A202C),
          elevation: 0,
        ),
        backgroundColor: const Color(0xFF1A202C),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Consumer<Cart_P>(
              builder: (context, prov, child) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF2D3748),
                            Color(0xFF1A202C),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                        border: Border.all(
                          color: const Color(0xFF4A5568).withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      width: double.infinity,
                      height: 180,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 15,
                          ),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    //input 
                                    text: input.join(''),
                                    style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white70,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  TextSpan(
                                    text: result.isNotEmpty ? '\n$result' : '',
                                    style: const TextStyle(
                                      fontSize: 48,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                          ),
                          itemCount: tabs.length,
                          itemBuilder: (context, i) {
                            return Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    tabs[i].color ?? const Color(0xFF2D3748),
                                    (tabs[i].color ?? const Color(0xFF2D3748))
                                        .withOpacity(0.85),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.1),
                                  width: 1,
                                ),
                              ),
                              height: 70,
                              child: Center(
                                child: MaterialButton(
                                  onPressed: () {
                                    if ((tabs[i].charac == "1" ||
                                        tabs[i].charac == "2" ||
                                        tabs[i].charac == "3" ||
                                        tabs[i].charac == "4" ||
                                        tabs[i].charac == "5" ||
                                        tabs[i].charac == "6" ||
                                        tabs[i].charac == "7" ||
                                        tabs[i].charac == "8" ||
                                        tabs[i].charac == "9" ||
                                        tabs[i].charac == "0" ||
                                        tabs[i].charac == "00" ||
                                        tabs[i].charac == ".")) {
                                      if (tabs[i].charac == "." &&
                                              (input.last == "+" ||
                                                  input.last == "-" ||
                                                  input.last == "*" ||
                                                  input.last == "/" ||
                                                  input.last == "%" ) ||
                                          tabs[i].charac == "." &&
                                              new_operation == true) {
                                        prov.addz(input);
                                        print(input);
                                      }
                                      if (new_operation == false) {
                                        prov.addchar(input, tabs[i].charac);
                                        dont_press_equ = false;
                                        print(input);
                                      } else {
                                        result = prov.clear_str(result);
                                        prov.addchar(input, tabs[i].charac);
                                        new_operation = false;
                                        dont_press_equ = false;
                                        print(input);
                                      }
                                    } else if (tabs[i].charac == "⌫") {
                                      prov.delete(input);
                                    } else if (tabs[i].charac == "C") {
                                      prov.clear_list(input);
                                    } else if (tabs[i].charac == "=") {
                                      if (dont_press_equ == false) {
                                        result = prov
                                            .evaluateExpression(input.join())
                                            .toString();
                                        prov.clear_list(input);
                                        new_operation = true;
                                        print(input);
                                        print(result);
                                      } else {
                                        prov.clear_list(input);
                                        result = prov.error_text(result);
                                        new_operation = true;
                                        print("this is error");
                                        print(input);
                                      }
                                    } else if (tabs[i].charac == "+" ||
                                    tabs[i].charac == "%" ||
                                        tabs[i].charac == "-" ||
                                        tabs[i].charac == "*" ||
                                        tabs[i].charac == "/") {
                                      if (new_operation == true ||
                                          result == "Error") {
                                        if (result == "Error") {
                                          result = prov.clear_str(result);
                                        }
                                        prov.St_in_List(result, input);
                                        result = prov.clear_str(result);
                                        prov.addchar(input, tabs[i].charac);
                                        new_operation = false;
                                        dont_press_equ = true;
                                        print(input);
                                      } else {
                                        prov.addchar(input, tabs[i].charac);
                                        new_operation = false;
                                        dont_press_equ = true;
                                        print(input);
                                      }
                                    }
                                  },
                                  child: Text(
                                    tabs[i].charac,
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                );
              },
            )));
  }
}
