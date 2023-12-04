import 'dart:math';

import 'package:flutter/material.dart';
import 'package:splitbuddy/dtos/create_expense_response.dart';

class ExpensesProvider extends ChangeNotifier {
  List<CreateExpenseResponse> _expensesFriends = [];

  List<CreateExpenseResponse> _expensesGroups = [];

  List<CreateExpenseResponse> get expensesFriends => _expensesFriends;

  List<CreateExpenseResponse> get expensesGroups => _expensesGroups;

  void addExpense(String expense) {
    CreateExpenseResponse expenseResponse =
        CreateExpenseResponse.fromJson(expense);
    if (expenseResponse.userToFriendId != 0) {
      _expensesFriends.add(expenseResponse);
    } else {
      _expensesGroups.add(expenseResponse);
    }
  }

  void addAllExpenses(String jsonString) {
    List<CreateExpenseResponse> expenseResponseListF =
        CreateExpenseResponse.expensesFriendsListFromJson(jsonString);

    List<CreateExpenseResponse> expenseResponseListG =
        CreateExpenseResponse.expensesGroupsListFromJson(jsonString);

    if (_expensesFriends.isNotEmpty) {
      if (expenseResponseListF.isNotEmpty) {
        expenseResponseListF.forEach((expense) {
          bool found = _expensesFriends
              .any((element) => element.expenseId == expense.expenseId);
          if (!found) {
            if (expense.userToFriendId != 0) {
              _expensesFriends.add(expense);
            }
          }
        });
      }
    } else {
      expenseResponseListF.forEach((element) {
        if (element.userToFriendId != 0) {
          _expensesFriends.add(element);
        }
      });
    }
  }
}
