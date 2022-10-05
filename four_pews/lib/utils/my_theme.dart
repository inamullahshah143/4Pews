import 'package:flutter/material.dart';

import 'pref_data.dart';

class MyTheme with ChangeNotifier {
  static bool _isDark = false;

  ThemeMode currentTheme() {
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void switchTheme() async {
    _isDark = await PrefData.getNightTheme();
    notifyListeners();
  }
}
