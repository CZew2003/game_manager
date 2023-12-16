import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:game_manager/models/client_model.dart';
import 'package:game_manager/screens/Loot.dart';
import 'package:game_manager/screens/champion_info_screen.dart';
import 'package:game_manager/screens/champions_screen.dart';
import 'package:game_manager/screens/home_screen.dart';
import 'package:game_manager/screens/login_screen.dart';
import 'package:game_manager/screens/match_history_screen.dart';
import 'package:game_manager/screens/registration_screen.dart';
import 'package:game_manager/screens/store_screen.dart';
import 'package:game_manager/widgets/page_route_widget.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  //await windowManager.setFullScreen(true);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ClientModel()),
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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case LoginScreen.route:
            return MaterialPageRoute(builder: (context) => const LoginScreen());
          case RegistrationScreen.route:
            return PageRouteWidget(screen: const RegistrationScreen());
          case HomeScreen.route:
            return PageRouteWidget(screen: const HomeScreen());
          case ChampionsScreen.route:
            return PageRouteWidget(screen: const ChampionsScreen());
          case MatchHistoryScreen.route:
            return PageRouteWidget(screen: const MatchHistoryScreen());
          case StoreScreen.route:
            return PageRouteWidget(screen: const StoreScreen());
          case LootScreen.route:
            return PageRouteWidget(screen: const LootScreen());
          case ChampionInfoScreen.route:
            {
              final champion = settings.arguments as String;
              return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return ChampionInfoScreen(championName: champion);
                },
                transitionsBuilder: (
                  BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                  Widget child,
                ) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              );
            }
          default:
            return null;
        }
      },
      initialRoute: LoginScreen.route,
    );
  }
}
