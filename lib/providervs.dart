import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Providervs extends StatelessWidget {
  const Providervs({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Provider vs ChangeNotifierProvider'),
            foregroundColor: Colors.white,
            backgroundColor: Colors.blue,
            centerTitle: true,
            elevation: 4.0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.0),
              ),
            ),
          ),
          body: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => Pro1(),
              ),
              ChangeNotifierProvider(
                create: (context) => Pro2(),
              ),
            ],
            child: ListView(
              children: [
                Consumer<Pro1>(builder: (context, pro1, child) {
                  return ListTile(
                    title: const Text('ChangeNotifier Example 1'),
                    subtitle: const Text(
                        'This is a simple example of ChangeNotifier in Flutter.'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        pro1.changeText1();
                        print("Button pressed");
                      },
                      child: const Text('Press Me'),
                    ),
                  );
                }),
                const SizedBox(height: 20),
                Consumer<Pro2>(builder: (context, pro, child) {
                  return ListTile(
                    title: const Text('ChangeNotifier Example 1'),
                    subtitle: const Text(
                        'This is a simple example of ChangeNotifier in Flutter.'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        pro.changeText2();
                        print("Button pressed");
                      },
                      child: const Text('Press Me'),
                    ),
                  );
                }),
                const SizedBox(height: 20),
                Consumer<Pro1>(builder: (context, pro1, child) {
                  return Text(
                    pro1.text1,
                    style: const TextStyle(fontSize: 24, color: Colors.blue),
                  );
                }),
                const SizedBox(height: 20),
                Consumer<Pro2>(builder: (context, pro2, child) {
                  return Text(
                    pro2.text2,
                    style: const TextStyle(fontSize: 24, color: Colors.blue),
                  );
                })
              ],
            ),
          )),
    );
  }
}

class Pro1 extends ChangeNotifier {
  String text1 = "Hello,Dev!";
  void changeText1() {
    text1 = "Hardware Development";
    notifyListeners();
  }
}

class Pro2 extends ChangeNotifier {
  String text2 = "Hello,Muslim!";
  void changeText2() {
    text2 = "Faithful Muslim";
    notifyListeners();
  }
}
