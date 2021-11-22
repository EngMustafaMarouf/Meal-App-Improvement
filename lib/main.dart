import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/page_view_screen.dart';
import 'package:meal_app/screens/splash_screen.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late bool isWatched;
Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  isWatched = prefs.getBool("watched")??false;



  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx)=> MealProvider()),
        ChangeNotifierProvider(create: (ctx)=> ThemeProvider()),
        ChangeNotifierProvider(create: (ctx)=>LanguageProvider()),
      ],
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    Provider.of<MealProvider>(context,listen: false).getData();
    Provider.of<ThemeProvider>(context,listen: false).getThemeData();
    Provider.of<LanguageProvider>(context,listen: false).getLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: Provider.of<ThemeProvider>(context).tm,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        canvasColor: Colors.white,
        primaryColor: Colors.black,
        unselectedWidgetColor: Colors.black,
        textTheme: ThemeData.dark().textTheme.copyWith(
          subtitle1: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
          headline6: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blueGrey,
        canvasColor: const Color.fromRGBO(14,22,33, 1),
        cardColor: const Color.fromRGBO(35, 34, 39, 1),
        primaryColor: Colors.white70,
        unselectedWidgetColor: Colors.white70,
        textTheme: ThemeData.dark().textTheme.copyWith(
          subtitle1: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
          headline6: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white70),
        ),
      ),
      home: isWatched?TabsScreen():PageViewScreen(),
    );
  }
}


