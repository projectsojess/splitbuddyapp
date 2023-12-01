class ServerConstants {
  static const String _serverUrl = 'http://localhost:8800';

  static const String signupUrl = '$_serverUrl/api/users/create-user';
  static const String signinUrl = '$_serverUrl/api/users//log-in';
  static const String addFriendUrl = '$_serverUrl/api/friends/add-friend';
  static const String getFriendsUrl = '$_serverUrl/api/friends/get-friends';
  static const String addExpenseNormal =
      '$_serverUrl/api/expenses/add-expense-normal';
}
