import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Cart_P with ChangeNotifier {
  List<String> charsp = [];
  String? expressionString;
//Add a char in the string

  void addchar(List<String> a, String n) {
    a.add(n);
    notifyListeners();
  }
//Clearing the whole string

  String clear_str(String str) {
    str = "";
    notifyListeners();
    return str;
  }

//Clearing the list
  void clear_list(List<String> charList) {
    charList.clear();
    notifyListeners();
  }

//Calculations
  double evaluateExpression(String expression) {
    try {
      Parser p = Parser();
      double d;
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      d = exp.evaluate(EvaluationType.REAL, cm);
      expression = "";
      notifyListeners();
      return d;
    } catch (e) {
      print('Error evaluating expression: $e');
      return 0;
    }
  }

//Error Handling
  String error_text(String resultError) {
    resultError = "Error";

    notifyListeners();
    return resultError;
  }

//Adding string in a list
  void St_in_List(String str, List list) {
    list.add(str);
    notifyListeners();
  }

  //Delete one char
  void delete(List list) {
    if (list.isNotEmpty) {
      list.removeLast();
    }
    notifyListeners();
  }

  // void addbracket(List list) {
  //   if(list.isEmpty){list.add("(");}
  //   else if(list.last=="0"||list.last=="0"||list.last=="0"||list.last=="0"||list.last=="0"||list.last=="0"||list.last=="0"||list.last=="0"||list.last=="0"||list.last=="0"||list.last=="0"||list.last=="0"||)
  // }
  void addz(List list) {
    list.add("0");
    notifyListeners();
  }
}
