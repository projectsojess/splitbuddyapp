import 'package:flutter/material.dart';
import 'package:splitbuddy/common/common.dart';
import 'package:http/http.dart' as http;
import 'package:splitbuddy/constants/constants.dart';
import 'package:splitbuddy/dtos/expenses.dart';
import 'package:splitbuddy/services/shared_preference_service.dart';

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
      String token =
          SharedPreferenceService.getString(RequestHeaders.JWT_HEADER);
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
          headers: RequestHeaders.getAuthenticatedHeaders(token: token));
      httpErrorHandle(
          response: response, context: context, onSuccess: () => {});
    } catch (e) {
      throw e;
      // showSnackbar(context, e.toString());
    }
  }
}
