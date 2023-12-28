// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/common/common.dart';
import 'package:http/http.dart' as http;
import 'package:splitbuddy/constants/constants.dart';
import 'package:splitbuddy/dtos/expense_data.dart';
import 'package:splitbuddy/dtos/expenses.dart';
import 'package:splitbuddy/dtos/expenses_adv.dart';
import 'package:splitbuddy/dtos/group_data.dart';
import 'package:splitbuddy/dtos/items.dart';
import 'package:splitbuddy/dtos/payer_payee.dart';
import 'package:splitbuddy/providers/expenses_provider.dart';
import 'package:splitbuddy/providers/group_provider.dart';
import 'package:splitbuddy/services/friends_service.dart';
import 'package:splitbuddy/services/group_service.dart';
import 'package:splitbuddy/services/shared_preference_service.dart';

class ExpenseService {
  FriendsService _friendsService = FriendsService();
  GroupService _groupService = GroupService();
  void createExpenseNormal({
    required BuildContext context,
    required int payerId,
    required int payeeId,
    required String type,
    required String date,
    required String description,
    required int userToFriendId,
    Map<int, double>? shareDistribution,
    int? totalShares,
    double? tax,
    double? serviceCharge,
    double? untaxedAmount,
    double? totalAmount,
  }) async {
    var expenseProvider = Provider.of<ExpensesProvider>(context, listen: false);
    try {
      String token =
          await SharedPreferenceService.getString(RequestHeaders.JWT_HEADER);
      double shareAmount = 0;
      double shareValue = 0;
      if (type == 'E') {
        shareAmount = totalAmount! / 2;
      } else if (type == 'P') {
        if (shareDistribution != null) {
          shareValue = shareDistribution[payeeId]!;
          shareAmount = (totalAmount! * shareValue) / 100;
        }
      } else if (type == 'S') {
        if (shareDistribution != null) {
          shareValue = shareDistribution[payeeId]!;
          shareAmount = (totalAmount! * shareValue) / totalShares!;
        }
      }
      PayerPayee payee = PayerPayee(
          id: payeeId,
          type: "P",
          shareType: type,
          shareValue: double.parse(shareValue.toStringAsFixed(2)),
          totalShares: totalShares,
          share: shareAmount);

      PayerPayee payer = PayerPayee(
          id: payerId,
          type: "PA",
          shareType: type,
          shareValue: shareValue,
          totalShares: totalShares,
          payedAmount: totalAmount!,
          share: totalAmount - shareAmount);
      List<PayerPayee> payerPayee = [payer, payee];
      Expense expenseRequest = Expense(
        userToFriendId: userToFriendId,
        payerPayees: payerPayee,
        date: date,
        description: description,
        tax: tax,
        serviceCharge: serviceCharge,
        untaxedAmount: untaxedAmount,
        totalAmount: totalAmount,
      );

      http.Response response = await http.post(
          Uri.parse(ServerConstants.addExpenseNormalUrl),
          body: expenseRequest.toJson(),
          headers: RequestHeaders.getAuthenticatedHeaders(token: token));

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () async {
            expenseProvider.addExpense(response.body);
            Navigator.pop(context);
            _friendsService.getFriends(context: context);
          });
    } catch (e) {
      throw e;
      // showSnackbar(context, e.toString());
    }
  }

  void getAllExpenses({required context}) async {
    try {
      String token =
          await SharedPreferenceService.getString(RequestHeaders.JWT_HEADER);
      var expenseProvider =
          Provider.of<ExpensesProvider>(context, listen: false);

      http.Response response = await http.get(
        Uri.parse(ServerConstants.getExpensesUrl),
        headers: RequestHeaders.getAuthenticatedHeaders(token: token),
      );

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () async {
            expenseProvider.addAllExpenses(response.body);
          });
    } catch (e) {}
  }

  void addExpenseAdvanced({
    required BuildContext context,
    required int payerId,
    required String date,
    required String description,
    required String fromScreen,
    int? userToFriendId,
    int? groupId,
    required List<Item> items,
    int? totalShares,
    double? tax,
    double? serviceCharge,
    double? untaxedAmount,
    double? totalAmount,
  }) async {
    var expenseProvider = Provider.of<ExpensesProvider>(context, listen: false);
    var groupProvider = Provider.of<GroupProvider>(context, listen: false);
    String token =
        await SharedPreferenceService.getString(RequestHeaders.JWT_HEADER);
    ExpensesAdv expensesAdv = ExpensesAdv(
      payerId: payerId,
      date: date,
      description: description,
      type: fromScreen,
      userToFriendId: userToFriendId,
      groupId: groupId,
      tax: tax,
      serviceCharge: serviceCharge,
      untaxedAmount: untaxedAmount,
      totalAmount: totalAmount,
      items: items,
    );

    http.Response response = await http.post(
        Uri.parse(ServerConstants.addExpenseUrl),
        body: jsonEncode(expensesAdv),
        headers: RequestHeaders.getAuthenticatedHeaders(token: token));

    httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          if (fromScreen == 'FBA' || fromScreen == 'GBA') {
            ExpenseData expenseData =
                ExpenseData.fromJson(jsonDecode(response.body));
            GroupData groupData = groupProvider.groups
                .firstWhere((group) => group.groupId == groupId);

            expenseProvider.addExpense(response.body);

            Navigator.pop(context);
            Navigator.pop(context);
          }
        });
  }

  void deleteExpense(
      {required int expenseId,
      required BuildContext context,
      int? groupId,
      int? userToFriendId}) async {
    var expenseProvider = Provider.of<ExpensesProvider>(context, listen: false);
    try {
      String token =
          await SharedPreferenceService.getString(RequestHeaders.JWT_HEADER);
      http.Response response = await http.delete(
        Uri.parse(
            '${ServerConstants.deleteExpenseUrl}?expenseId=${expenseId.toString()}${groupId != null ? '&groupId=$groupId' : ''} ${userToFriendId != null ? '&userToFriendId=$userToFriendId' : ''}'),
        headers: RequestHeaders.getAuthenticatedHeaders(token: token),
      );

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () async {
            expenseProvider.removeExepnse(expenseId);
          });
    } catch (e) {}
  }

  void editExpense({
    required BuildContext context,
    required int payerId,
    required String date,
    required String description,
    required String fromScreen,
    int? userToFriendId,
    int? groupId,
    required List<Item> items,
    int? totalShares,
    double? tax,
    double? serviceCharge,
    double? untaxedAmount,
    double? totalAmount,
    required int expenseId,
    required int createdById,
  }) async {
    var expenseProvider = Provider.of<ExpensesProvider>(context, listen: false);
    var groupProvider = Provider.of<GroupProvider>(context, listen: false);
    ExpensesAdv expensesAdv = ExpensesAdv(
      createdById: createdById,
      expenseId: expenseId,
      payerId: payerId,
      date: date,
      description: description,
      type: fromScreen,
      userToFriendId: userToFriendId,
      groupId: groupId,
      tax: tax,
      serviceCharge: serviceCharge,
      untaxedAmount: untaxedAmount,
      totalAmount: totalAmount,
      items: items,
    );
    String token =
        await SharedPreferenceService.getString(RequestHeaders.JWT_HEADER);
    http.Response response = await http.put(
        Uri.parse(ServerConstants.editExpenseUrl),
        body: jsonEncode(expensesAdv),
        headers: RequestHeaders.getAuthenticatedHeaders(token: token));

    httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          expenseProvider.editExpense(response.body);
          Navigator.pop(context);
          Navigator.pop(context);
        });
  }
}
