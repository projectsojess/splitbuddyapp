import 'package:flutter/material.dart';
import 'package:splitbuddy/dtos/create_expense_response.dart';

class ExpensesProvider extends ChangeNotifier {
  List<CreateExpenseResponse> _expenses = [];

  List<CreateExpenseResponse> get expenses => _expenses;

  void addExpense(String expense) {
    _expenses.add(CreateExpenseResponse.fromJson(expense));
  }

  void addAllExpenses(String jsonString) {
    List<CreateExpenseResponse> expenseResponseList =
        CreateExpenseResponse.createExpenseResponseListFromJson(jsonString);

    if (_expenses.isNotEmpty) {
      if (expenseResponseList.isNotEmpty) {
        expenseResponseList.forEach((expense) {
          bool found = _expenses
              .any((element) => element.expenseId == expense.expenseId);
          if (!found) {
            _expenses.add(expense);
          }
        });
      }
    } else {
      _expenses.addAll(expenseResponseList);
    }
  }
}
