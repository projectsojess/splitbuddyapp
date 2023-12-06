class ServerConstants {
  static const String _serverUrl = 'http://localhost:8800';

  static const String signupUrl = '$_serverUrl/api/auth/create-user';
  static const String signinUrl = '$_serverUrl/api/auth/log-in';
  static const String addFriendUrl = '$_serverUrl/api/friends/add-friend';
  static const String getFriendsUrl = '$_serverUrl/api/friends/get-friends';
  static const String addExpenseNormalUrl =
      '$_serverUrl/api/expenses/create-expense-normal';

  static const String getExpensesUrl = '$_serverUrl/api/expenses/get-expenses';
}
