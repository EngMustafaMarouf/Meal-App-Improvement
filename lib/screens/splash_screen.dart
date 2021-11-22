import 'package:flutter/material.dart';
import 'package:meal_app/screens/tabs_screen.dart';

import 'categories_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                Text(
                  "Loading...",
                  style: TextStyle(),
                )
              ],
            ),
          ),
        ));
  }
}
