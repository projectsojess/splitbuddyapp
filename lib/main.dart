import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:splitbuddy/dtos/expense_data.dart';
import 'package:splitbuddy/dtos/expense_payee.dart';
import 'package:splitbuddy/dtos/expense_payer.dart';
import 'package:splitbuddy/dtos/friend_response.dart';
import 'package:splitbuddy/dtos/group_data.dart';
import 'package:splitbuddy/dtos/items.dart';
import 'package:splitbuddy/dtos/login_response.dart';
import 'package:splitbuddy/dtos/user_to_member_data.dart';
import 'package:splitbuddy/feature/splash_screen.dart';
import 'package:splitbuddy/providers/country_provider.dart';
import 'package:splitbuddy/providers/expenses_provider.dart';
import 'package:splitbuddy/providers/friends_provider.dart';
import 'package:splitbuddy/providers/group_provider.dart';
import 'package:splitbuddy/providers/user_provider.dart';
import 'package:splitbuddy/themes/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDoccumentDir =
      await path_provider.getApplicationDocumentsDirectory();

  Hive.init(appDoccumentDir.path);
  Hive.registerAdapter(ExpenseDataAdapter());
  Hive.registerAdapter(ExpensePayeeAdapter());
  Hive.registerAdapter(ExpensePayerAdapter());
  Hive.registerAdapter(ItemAdapter());
  Hive.registerAdapter(LoginResponseAdapter());
  Hive.registerAdapter(GroupDataAdapter());
  Hive.registerAdapter(UserToMemberDataAdapter());
  Hive.registerAdapter(FriendResponseAdapter());

  Hive.openBox<ExpenseData>("expenses");
  Hive.openBox<LoginResponse>("user");
  Hive.openBox<GroupData>("groups");
  Hive.openBox<FriendResponse>("friends");

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => FriendsProvider()),
      ChangeNotifierProvider(create: (_) => ExpensesProvider()),
      ChangeNotifierProvider(create: (_) => GroupProvider()),
      ChangeNotifierProvider(create: (_) => CountryProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splitbuddies',
      theme: AppTheme.theme,
      home: const SplashScreen(),
    );
  }
}
