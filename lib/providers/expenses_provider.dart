import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:splitbuddy/dtos/create_expense_response.dart';
import 'package:splitbuddy/dtos/expense_data.dart';

class ExpensesProvider extends ChangeNotifier {
  List<CreateExpenseResponse> _expensesFriends = [];

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
    ExpenseData expenseResponse = ExpenseData.fromJson(jsonDecode(expense));
    _expenses.insert(0, expenseResponse);
    notifyListeners();
  }

  void removeExepnse(int expenseId) {
    _expenses.removeWhere((expense) => expense.expenseId == expenseId);
    notifyListeners();
  }

  void editExpense(String expense) {
    ExpenseData expenseResponse = ExpenseData.fromJson(jsonDecode(expense));
    int index = _expenses.indexWhere(
        (expense) => expense.expenseId == expenseResponse.expenseId);
    _expenses[index] = expenseResponse;
    notifyListeners();
  }
}
