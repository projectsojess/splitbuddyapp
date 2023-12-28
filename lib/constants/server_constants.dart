class ServerConstants {
  static const String _serverUrl = 'http://localhost:8800';

  //user management service urls
  static const String _userManagementUrl = 'http://localhost:8700';

  static const String signupUrl = '$_userManagementUrl/api/auth/create-user';
  static const String signinUrl = '$_userManagementUrl/api/auth/log-in';
  static const String getAllCountriesUrl =
      '$_userManagementUrl/api/auth/get-all-countries';

  static const String checkUserExistsUrl =
      '$_userManagementUrl/api/auth/user-exists';

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
