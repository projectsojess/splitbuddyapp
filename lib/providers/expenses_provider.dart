import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:splitbuddy/dtos/expense_data.dart';

class ExpensesProvider extends ChangeNotifier {
  Box<ExpenseData> _expenseBox = Hive.box<ExpenseData>('expenses');

  void init() {
    _expenseBox.watch().listen((event) {
      notifyListeners();
    });
  }

  List<ExpenseData> get expenses =>
      _expenseBox.values.toList()..sort((a, b) => b.date.compareTo(a.date));

  void addAllExpenses(String response) {
    List<ExpenseData> expenseResponse = List<ExpenseData>.from(
        jsonDecode(response)['expenses']
            .map((model) => ExpenseData.fromJson(model)));
    expenseResponse
        .forEach((expense) => _expenseBox.put(expense.expenseId, expense));
    notifyListeners();
  }

  void addExpense(String expense) {
    ExpenseData expenseResponse = ExpenseData.fromJson(jsonDecode(expense));
    _expenseBox.put(expenseResponse.expenseId, expenseResponse);
    notifyListeners();
  }

  void removeExepnse(int expenseId) {
    _expenseBox.delete(expenseId);
  }

  void editExpense(String expense) {
    ExpenseData expenseResponse = ExpenseData.fromJson(jsonDecode(expense));
    _expenseBox.put(expenseResponse.expenseId, expenseResponse);
    notifyListeners();
  }
}
