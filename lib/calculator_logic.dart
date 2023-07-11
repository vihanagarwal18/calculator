import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'homepage.dart';

class CalculatorLogic with ChangeNotifier {
  String _expression = '';

  String get expression => _expression;

  void addToExpression(String value) {
    _expression += value;
    notifyListeners();
  }

  void clearExpression() {
    _expression = '';
    notifyListeners();
  }

  void evaluateExpression() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(_expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      _expression = eval.toString();
    } catch (e) {
      _expression = 'Error';
    }
    notifyListeners();
  }
}


// void evaluateExpression() {
  //   try {
  //     // Evaluate the expression using Dart's built-in math library
  //     final result = math.ExpressionEvaluator().eval(_expression);
  //     _expression = result.toString();
  //   } catch (e) {
  //     _expression = 'Error';
  //   }
  //   notifyListeners();
  // }

