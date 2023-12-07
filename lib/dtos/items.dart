class Item {
  String name;
  double amount;
  List<int?>? usersInvolved;
  String shareType;
  Map<int, double>? shareValue;

  Item(
      {required this.name,
      required this.amount,
      required this.usersInvolved,
      required this.shareType,
      required this.shareValue});
}
