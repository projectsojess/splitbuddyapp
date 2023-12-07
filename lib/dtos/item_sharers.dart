// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ItemSharer {
  final int? itemId;
  final int? itemSharerId;
  final double share;
  final double? shareValue;
  final String shareType;
  final int? totalShares;
  final int sharerId;

  ItemSharer({
    required this.share,
    this.itemSharerId,
    this.shareValue,
    this.totalShares,
    required this.shareType,
    required this.sharerId,
    this.itemId,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'share': share,
      'shareValue': shareValue,
      'shareType': shareType,
      'totalShares': totalShares,
      'sharerId': sharerId,
    };

    if (itemId != 0) {
      map['itemId'] = itemId;
    }
    if (itemSharerId != 0) {
      map['itemSharerId'] = itemSharerId;
    }
    return map;
  }

  factory ItemSharer.fromMap(Map<String, dynamic> map) {
    return ItemSharer(
      itemSharerId: map['itemId'] != null ? map['itemId'] as int : null,
      itemId: map['itemId'] != null ? map['itemId'] as int : null,
      share: map['share'] as double,
      shareValue:
          map['shareValue'] != null ? map['shareValue'] as double : null,
      shareType: map['shareType'] as String,
      totalShares:
          map['totalShares'] != null ? map['totalShares'] as int : null,
      sharerId: map['sharerId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemSharer.fromJson(String source) =>
      ItemSharer.fromMap(json.decode(source) as Map<String, dynamic>);
}
