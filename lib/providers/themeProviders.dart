import 'package:crypto_app/models/localStorage.dart';
import 'package:flutter/material.dart';

class ThemeModeProvider with ChangeNotifier {
  late ThemeMode themeMode;

  ThemeModeProvider(String theme) {
    if (theme == "dark") {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.light;
    }
  }

  void toggleTheme() async {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
      await LocalStorage.saveTheme('dark');
    } else {
      themeMode = ThemeMode.light;
      await LocalStorage.saveTheme('light'); 
    }

    notifyListeners();
  }
}
