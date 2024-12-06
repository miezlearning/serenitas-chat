import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serenitas/controller/account.dart';
import 'package:serenitas/controller/navigation.dart';
import 'package:serenitas/controller/predict.dart';
import 'package:serenitas/pages/appearance_page.dart';
import 'package:serenitas/pages/home_page.dart';
import 'package:serenitas/pages/login_page.dart';
import 'package:serenitas/pages/profile_page.dart';
import 'package:serenitas/pages/register_page.dart';
import 'package:serenitas/pages/setting_page.dart';
import 'controller/theme_controller.dart';
import 'controller/chat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => ThemeModeData()..setInitialTheme()),
        ChangeNotifierProvider(create: (BuildContext context) => NavigationProvider()),
        ChangeNotifierProvider(create: (BuildContext context) => AccountData()),
        ChangeNotifierProvider(create: (BuildContext context) => ChatController()),
        ChangeNotifierProvider(create: (BuildContext context) => PredictionProvider()),
      ],
      child: Consumer<ThemeModeData>(
        builder: (context, themeModeData, child) {
          return MaterialApp(
            title: 'Serenitas',
            themeMode: themeModeData.themeMode,
            theme: ThemeData.light(useMaterial3: true),
            darkTheme: ThemeData.dark(useMaterial3: true),
            home: MyHomePage(),
            initialRoute: '/',
            routes: {
              '/profile': (context) => ProfilePage(),
              '/appearance': (context) => AppearancePage(),
              '/home': (context) => MyHomePage(),
              '/setting': (context) => MySettingsPage(),
              '/login': (context) => MyLoginPage(),
              '/register': (context) => MySignUpPage(),
            },
          );
        },
      ),
    );
  }
}
