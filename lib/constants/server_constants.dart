class ServerConstants {
  static const String _serverUrl = 'http://localhost:8800';

  static const String signupUrl = '$_serverUrl/api/auth/create-user';
  static const String signinUrl = '$_serverUrl/api/auth/log-in';
  static const String addFriendUrl = '$_serverUrl/api/friends/add-friend';
  static const String getFriendsUrl = '$_serverUrl/api/friends/get-friends';
  static const String addExpenseNormalUrl =
      '$_serverUrl/api/expenses/create-expense-normal';
  static const String addExpenseUrl = '$_serverUrl/api/expenses/add-expense';

  static const String getExpensesUrl = '$_serverUrl/api/expenses/get-expenses';
  static const String deleteExpenseUrl =
      '$_serverUrl/api/expenses/delete-expense';
  static const String editExpenseUrl = '$_serverUrl/api/expenses/edit-expense';
  static const String createGroupUrl = '$_serverUrl/api/groups/create-group';

  static const String getAllGroupsUrl = '$_serverUrl/api/groups/get-groups';
  static const String getGroupUrl = '$_serverUrl/api/groups/get-group';
}
