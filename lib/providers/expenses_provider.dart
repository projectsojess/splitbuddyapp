import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:splitbuddy/dtos/create_expense_response.dart';
import 'package:splitbuddy/dtos/expense_data.dart';

class ExpensesProvider extends ChangeNotifier {
  List<CreateExpenseResponse> _expensesFriends = [];

  List<CreateExpenseResponse> _expensesGroups = [];

  List<CreateExpenseResponse> get expensesFriends => _expensesFriends;

  List<CreateExpenseResponse> get expensesGroups => _expensesGroups;

  List<ExpenseData> _expenses = [];

  List<ExpenseData> get expenses => _expenses;

  void addAllExpenses(String response) {
    List<ExpenseData> expenseResponse = List<ExpenseData>.from(
        jsonDecode(response)['expenses']
            .map((model) => ExpenseData.fromJson(model)));
    _expenses = expenseResponse;
    notifyListeners();
  }

  void addExpense(String expense) {
    List<ExpenseData> expenseResponse = List<ExpenseData>.from(
        jsonDecode(expense)['expenses']
            .map((model) => ExpenseData.fromJson(model)));
    _expenses.insert(0, expenseResponse[0]);
    notifyListeners();
  }

  void removeExepnse(int expenseId) {
    _expenses.removeWhere((expense) => expense.expenseId == expenseId);
    notifyListeners();
  }
}
