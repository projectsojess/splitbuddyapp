import 'package:flutter/material.dart';
import 'package:splitbuddy/common/common.dart';
import 'package:http/http.dart' as http;
import 'package:splitbuddy/constants/constants.dart';
import 'package:splitbuddy/constants/server_constants.dart';
import 'package:splitbuddy/dtos/expenses.dart';

class ExpenseService {
  void createExpenseNormal({
    required BuildContext context,
    required int paidBy,
    required int payee,
    required String type,
    required DateTime date,
    required String description,
    Map<int, double>? shareDistribution,
    int? totalShares,
    double? tax,
    double? serviceCharge,
    double? untaxedAmount,
    double? totalAmount,
  }) async {
    try {
      double shareAmount = 0;
      if (type == 'E') {
        shareAmount = totalAmount! / 2;
      } else if (type == 'P') {
        double shareP = shareDistribution![payee]!;
        shareAmount = (totalAmount! * shareP) / 100;
      } else if (type == 'S') {
        double shareS = shareDistribution![payee]!;
        shareAmount = (totalAmount! * shareS) / totalShares!;
      }
      Map<int, double> shares = {
        paidBy: totalAmount! - shareAmount,
        payee: shareAmount
      };
      List<int> payees = [payee];
      Expense expenseRequest = Expense(
        paidBy: paidBy,
        payee: payees,
        type: type,
        date: date,
        description: description,
        shares: shares,
        shareDistribution: shareDistribution,
        totalShares: totalShares,
        tax: tax,
        serviceCharge: serviceCharge,
        untaxedAmount: untaxedAmount,
        totalAmount: totalAmount,
      );

      http.Response response = await http.post(
          Uri.parse(ServerConstants.addExpenseNormal),
          body: expenseRequest.toJson(),
          headers: RequestHeaders.getAuthenticatedHeaders());
      httpErrorHandle(
          response: response, context: context, onSuccess: () => {});
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
