import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:training/mini_project/cart.dart';
import 'package:training/mini_project/item.dart';

class HomeP extends StatelessWidget {
  const HomeP({super.key});

  @override
  Widget build(BuildContext context) {
    List<Item> items = [
      Item(name: 'IPhone 13', price: 2000.0),
      Item(name: 'IPhone 14', price: 4000.0),
    ];
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          foregroundColor: Colors.white,
          backgroundColor: Colors.orangeAccent,
          actions: [
            Consumer<Cart>(builder: (context, value, child) {
              return Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add_shopping_cart),
                    tooltip: 'Open shopping cart',
                    onPressed: () {
                      Navigator.pushNamed(context, 'check');
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Text(
                      value.get_totalPrice.toString(),
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  )
                ],
              );
            })
          ],
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, i) {
            return Consumer<Cart>(builder: (context, value, child) {
              return Card(
                child: ListTile(
                  title: Text(items[i].name),
                  subtitle: Text("Price: ${items[i].price}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      value.addItem(items[i]);
                    },
                  ),
                ),
              );
            });
          },
        ));
  }
}
