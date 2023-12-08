// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'items.g.dart';

@JsonSerializable(includeIfNull: false)
class Item {
  final int? expenseId;
  final int? itemId;
  int quantity;
  String name;
  double amount;
  List<int?>? usersInvolved;
  String shareType;
  Map<int, double>? shareValues;
  double? totalShares;

  Item(
      {required this.name,
      required this.amount,
      required this.quantity,
      required this.usersInvolved,
      required this.shareType,
      this.shareValues,
      this.totalShares,
      this.expenseId,
      this.itemId});

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}
