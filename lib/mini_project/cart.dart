import 'package:flutter/material.dart';
import 'package:training/mini_project/item.dart';

class Cart with ChangeNotifier {
  final List<Item> _items = [];
  double _totalPrice = 0.0;
  void addItem(Item item) {
    _items.add(item);
    _totalPrice += item.price;
    notifyListeners();
  }

  void remItem(Item item) {
    _items.remove(item);
    _totalPrice -= item.price;
    notifyListeners();
  }

  double get get_totalPrice => _totalPrice;
  int get get_items => _items.length;
  List<Item> get get_prod => _items;
}
