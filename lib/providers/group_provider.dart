import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:splitbuddy/dtos/dtos.dart';

class GroupProvider extends ChangeNotifier {
  List<GroupData> _groups = [];

  List<GroupData> get groups => _groups;

  void addGroup(String group) {
    _groups.add(GroupData.fromJson(jsonDecode(group)));
    notifyListeners();
  }

  void addAllGroups(String groups) {
    List<GroupData> groupResponses = List<GroupData>.from(
        jsonDecode(groups)['groups'].map((model) => GroupData.fromJson(model)));
    _groups = groupResponses;
    notifyListeners();
  }

  void updateGroupData(GroupData groupData) {
    int index =
        _groups.indexWhere((element) => element.groupId == groupData.groupId);
    _groups[index] = groupData;
    notifyListeners();
  }

  void updateGroup(String group) {
    GroupData groupResponse = GroupData.fromJson(jsonDecode(group));
    int index = _groups
        .indexWhere((element) => element.groupId == groupResponse.groupId);
    _groups[index] = groupResponse;
    notifyListeners();
  }
}
