import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeProvider extends ChangeNotifier{


  ThemeMode tm = ThemeMode.system;



  void ThemeModeChange(newThemeVal) async{
    tm = newThemeVal;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(tm == ThemeMode.system) {
      prefs.setString('tm', "system");

    } else if(tm == ThemeMode.light) {
      prefs.setString('tm', "light");
    } else {
      prefs.setString('tm', "dark");
    }
    notifyListeners();
  }


  Future<void> getThemeData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String str = prefs.getString('tm')??"";
    if(str == 'system'){
      tm = ThemeMode.system;
    }else if(str == 'light'){
      tm = ThemeMode.light;
    }else if(str == 'dark'){
      tm = ThemeMode.dark;
    }
    notifyListeners();
  }




}