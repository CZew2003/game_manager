import 'package:flutter/material.dart';
import 'package:game_manager/screens/home_screen.dart';
import 'package:game_manager/screens/login_screen.dart';
import 'package:mysql1/mysql1.dart';
import 'services/sql_queries.dart';
import 'services/connector.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),
      routes: {
        LoginScreen.route: (context) => const LoginScreen(),
        HomeScreen.route: (context) => const HomeScreen(),
      },
      initialRoute: LoginScreen.route,
    );
  }
}
