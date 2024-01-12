import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'models/client_model.dart';
import 'models/match_preview_model.dart';
import 'screens/admin_home_screen.dart';
import 'screens/champion_info_screen.dart';
import 'screens/champions_screen.dart';
import 'screens/home_screen.dart';
import 'screens/items_screen.dart';
import 'screens/login_screen.dart';
import 'screens/loot.dart';
import 'screens/match_history_screen.dart';
import 'screens/match_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/store_screen.dart';
import 'screens/super_admin_home_screen.dart';
import 'screens/super_admin_panel.dart';
import 'widgets/page_route_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  //await windowManager.setFullScreen(true);
  runApp(MultiProvider(
    providers: <SingleChildWidget>[
      ChangeNotifierProvider<ClientModel>(create: (_) => ClientModel()),
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
      scrollBehavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case LoginScreen.route:
            return MaterialPageRoute<dynamic>(builder: (BuildContext context) => const LoginScreen());
          case RegistrationScreen.route:
            return PageRouteWidget(screen: const RegistrationScreen());
          case HomeScreen.route:
            return PageRouteWidget(screen: const HomeScreen());
          case ChampionsScreen.route:
            return PageRouteWidget(screen: const ChampionsScreen());
          case ItemsScreen.route:
            return PageRouteWidget(screen: const ItemsScreen());
          case MatchHistoryScreen.route:
            return PageRouteWidget(screen: const MatchHistoryScreen());
          case StoreScreen.route:
            return PageRouteWidget(screen: const StoreScreen());
          case LootScreen.route:
            return PageRouteWidget(screen: const LootScreen());
          case AdminHomeScreen.route:
            return PageRouteWidget(screen: const AdminHomeScreen());
          case SuperAdminHomeScreen.route:
            return PageRouteWidget(screen: const SuperAdminHomeScreen());
          case SuperAdminPanel.route:
            return PageRouteWidget(screen: SuperAdminPanel());
          case MatchScreen.route:
            {
              final MatchPreviewModel matchPreviewModel = settings.arguments! as MatchPreviewModel;
              return PageRouteBuilder<dynamic>(
                pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                  return MatchScreen(matchPreviewModel: matchPreviewModel);
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
          case ChampionInfoScreen.route:
            {
              final String champion = settings.arguments! as String;
              return PageRouteBuilder<dynamic>(
                pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
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
