import 'package:flutter/material.dart';
import 'package:training/caculator/homepage.dart';
import 'package:training/selector.dart';
import 'package:provider/provider.dart';
import './mini_project/check.dart';
import './caculator/cart_P.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Cart_P(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const HomePage_P(),
          routes: {
            'home': (context) => const HomePage(),
            'check': (context) => const Check(),
          },
        ));
  }
}
