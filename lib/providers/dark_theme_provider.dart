import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkThemeProvider with ChangeNotifier {
  bool isDark = false;

  switchMode() {
    isDark = !isDark;
    saveModeToSharedPref();
    notifyListeners();
  }

  setMode() {
    getModeFromSharedPref();
  }

  saveModeToSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', isDark);
  }

  getModeFromSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDark = prefs.getBool('isDark') ?? false;
    notifyListeners();
  }
}
