import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Providercont extends StatelessWidget {
  const Providercont({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Change(),
      child: const MaterialApp(
        home: Scaffold(
          body: Helper(),
        ),
      ),
    );
  }
}

class Helper extends StatelessWidget {
  const Helper({super.key});

  @override
  Widget build(BuildContext context) {
    //var change = Provider.of<Change>(context, listen: false);
    return ListView(
      children: [
        ListTile(
          title: const Text('ChangeNotifier Example'),
          subtitle:
              const Text('This is a simple example of ChangeNotifier in Flutter.'),
          trailing: ElevatedButton(
            onPressed: () {
              context.read<Change>().changeText();
              print("Button pressed");
            },
            child: const Text('Press Me'),
          ),
        ),
        const SizedBox(height: 20),
        Text(context.watch<Change>().text,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class Change extends ChangeNotifier {
  String text = "Hello, ChangeNotifier!";
  void changeText() {
    text = "Text Changed!";
    notifyListeners();
  }
}
