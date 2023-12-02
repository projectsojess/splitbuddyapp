// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/common/common.dart';
import 'package:http/http.dart' as http;
import 'package:splitbuddy/constants/constants.dart';
import 'package:splitbuddy/dtos/expenses.dart';
import 'package:splitbuddy/dtos/payee.dart';
import 'package:splitbuddy/providers/expenses_provider.dart';
import 'package:splitbuddy/services/shared_preference_service.dart';

class ExpenseService {
  String token = SharedPreferenceService.getString(RequestHeaders.JWT_HEADER);

  void createExpenseNormal({
    required BuildContext context,
    required int paidBy,
    required int payee,
    required String type,
    required String date,
    required String description,
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
      if (type == 'E') {
        shareAmount = totalAmount! / 2;
      } else if (type == 'P') {
        if (shareDistribution != null) {
          double shareP = shareDistribution[payee]!;
          shareAmount = (totalAmount! * shareP) / 100;
        }
      } else if (type == 'S') {
        if (shareDistribution != null) {
          double shareS = shareDistribution[payee]!;
          shareAmount = (totalAmount! * shareS) / totalShares!;
        }
      }
      Payee payeeU = Payee(
          payeeId: payee,
          shareType: type,
          totalShares: totalShares,
          payeeShare: shareAmount);
      Payee payeeF = Payee(
          payeeId: paidBy,
          shareType: type,
          totalShares: totalShares,
          payeeShare: totalAmount! - shareAmount);

      List<Payee> payees = [payeeU, payeeF];
      Expense expenseRequest = Expense(
        paidBy: paidBy,
        payees: payees,
        date: date,
        description: description,
        tax: tax,
        serviceCharge: serviceCharge,
        untaxedAmount: untaxedAmount,
        totalAmount: totalAmount,
      );

      http.Response response = await http.post(
          Uri.parse(ServerConstants.addExpenseNormal),
          body: expenseRequest.toJson(),
          headers: RequestHeaders.getAuthenticatedHeaders(token: token));

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () async {
            expenseProvider.addExpense(response.body);
            Navigator.pop(context);
          });
    } catch (e) {
      throw e;
      // showSnackbar(context, e.toString());
    }
  }
}
