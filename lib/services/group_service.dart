import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitbuddy/common/utils.dart';
import 'package:splitbuddy/constants/constants.dart';
import 'package:splitbuddy/constants/request_headers.dart';
import 'package:splitbuddy/dtos/create_group.dart';
import 'package:splitbuddy/providers/group_provider.dart';
import 'package:splitbuddy/services/shared_preference_service.dart';
import 'package:http/http.dart' as http;

class GroupService {
  String token = SharedPreferenceService.getString(RequestHeaders.JWT_HEADER);

  void createGroup({required context, required CreateGroup createGroup}) async {
    try {
      var groupProvider = Provider.of<GroupProvider>(context, listen: false);

      http.Response response = await http.post(
        Uri.parse(ServerConstants.createGroupUrl),
        body: jsonEncode(createGroup),
        headers: RequestHeaders.getAuthenticatedHeaders(token: token),
      );

      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            groupProvider.addGroup(response.body);
            Navigator.pop(context);
          });
    } catch (e) {}
  }

  void getAllGroups({required context}) async {
    var groupProvider = Provider.of<GroupProvider>(context, listen: false);

    http.Response response = await http.get(
      Uri.parse(ServerConstants.getAllGroupsUrl),
      headers: RequestHeaders.getAuthenticatedHeaders(token: token),
    );

    httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          groupProvider.addAllGroups(response.body);
        });
  }

  void getGroup({required context, required int groupId}) async {
    var groupProvider = Provider.of<GroupProvider>(context, listen: false);

    http.Response response = await http.get(
      Uri.parse('${ServerConstants.getGroupUrl}/${groupId}'),
      headers: RequestHeaders.getAuthenticatedHeaders(token: token),
    );

    httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          groupProvider.updateGroup(response.body);
        });
  }
}
