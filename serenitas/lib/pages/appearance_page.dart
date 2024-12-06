import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/theme_controller.dart';

class AppearancePage extends StatelessWidget {
  const AppearancePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen to the current theme mode state
    final themeModeData = Provider.of<ThemeModeData>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Appearance'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(
              themeModeData.isDarkModeActive ? Icons.dark_mode : Icons.light_mode,
            ),
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: themeModeData.isDarkModeActive, // Reflect current dark mode state
              onChanged: (bool value) {
                themeModeData.changeTheme(
                  value ? ThemeMode.dark : ThemeMode.light, // Toggle theme on switch change
                );
              },
            ),
            onTap: () {
              themeModeData.changeTheme(
                themeModeData.isDarkModeActive ? ThemeMode.light : ThemeMode.dark, // Toggle theme on tap
              );
            },
          ),
        ],
      ),
    );
  }
}
