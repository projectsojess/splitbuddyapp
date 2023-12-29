import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:splitbuddy/dtos/dtos.dart';

class GroupProvider extends ChangeNotifier {
  Box<GroupData> _groupsBox = Hive.box<GroupData>('groups');

  List<GroupData> get groups => _groupsBox.values.toList()
    ..sort((a, b) => b.createdDate.compareTo(a.createdDate));

  void init() {
    _groupsBox.watch().listen((event) {
      notifyListeners();
    });
  }

  void addGroup(String group) {
    GroupData groupData = GroupData.fromJson(jsonDecode(group));

    _groupsBox.put(groupData.groupId, groupData);
    notifyListeners();
  }

  void addAllGroups(String groups) {
    List<GroupData> groupResponses = List<GroupData>.from(
        jsonDecode(groups)['groups'].map((model) => GroupData.fromJson(model)));
    groupResponses.forEach((group) => _groupsBox.put(group.groupId, group));
    notifyListeners();
  }

  void updateGroupData(GroupData groupData) {
    _groupsBox.put(groupData.groupId, groupData);
    notifyListeners();
  }

  void updateGroup(String group) {
    GroupData groupResponse = GroupData.fromJson(jsonDecode(group));
    _groupsBox.put(groupResponse.groupId, groupResponse);
    notifyListeners();
  }
}
