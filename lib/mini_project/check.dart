import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training/mini_project/cart.dart';

class Check extends StatefulWidget {
  const Check({super.key});

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, "home");
            },
            icon: const Icon(Icons.exit_to_app)),
        title: const Text('Check Page'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.orangeAccent,
      ),
      body: Consumer<Cart>(builder: (context, value, child) {
        return ListView.builder(
            itemCount: value.get_prod.length,
            itemBuilder: (context, i) {
              return Card(
                child: ListTile(
                  title: Text(value.get_prod[i].name),
                  leading: IconButton(
                      onPressed: () {
                        value.remItem(value.get_prod[i]);
                      },
                      icon: const Icon(CupertinoIcons.minus_circle)),
                ),
              );
            });
      }),
    );
  }
}
