// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/common/common.dart';
import 'package:http/http.dart' as http;
import 'package:splitbuddy/constants/constants.dart';
import 'package:splitbuddy/dtos/expenses.dart';
import 'package:splitbuddy/dtos/payer_payee.dart';
import 'package:splitbuddy/providers/expenses_provider.dart';
import 'package:splitbuddy/services/friends_service.dart';
import 'package:splitbuddy/services/shared_preference_service.dart';

class ExpenseService {
  String token = SharedPreferenceService.getString(RequestHeaders.JWT_HEADER);
  FriendsService friendsService = FriendsService();
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
            friendsService.getFriends(context: context);
          });
    } catch (e) {
      throw e;
      // showSnackbar(context, e.toString());
    }
  }

  void getAllExpenses({required context}) async {
    try {
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
}
