// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'items.g.dart';

@JsonSerializable(includeIfNull: false)
@HiveType(typeId: 2)
class Item extends HiveObject {
  @HiveField(0)
  final int? expenseId;

  @HiveField(1)
  final int? itemId;

  @HiveField(2)
  int quantity;

  @HiveField(3)
  String name;

  @HiveField(4)
  double amount;

  @HiveField(5)
  List<int?>? usersInvolved;

  @HiveField(6)
  String shareType;

  @HiveField(7)
  Map<int, double>? shareValues;

  @HiveField(8)
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
