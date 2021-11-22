import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'categories_screen.dart';
import 'favorite_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {

  int currentIndex = 0;
  late List<Map<String,dynamic>> pages;
  @override

  void didChangeDependencies() {
    var lanProvider = Provider.of<LanguageProvider>(context);

    pages = [
      {
        'page': CategoriesScreen(),
        'title':lanProvider.getText("Categories"),
      },
      {
        'page': FavoriteScreen(),
        'title':lanProvider.getText("My Favorite Meals"),
      }
    ];
    super.didChangeDependencies();
  }


  void selectedPage(int value){
    setState(() {
      currentIndex = value;
    });
  }


  @override
  Widget build(BuildContext context) {
    var lanProvider = Provider.of<LanguageProvider>(context);
    return Directionality(
      textDirection: lanProvider.isEn?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text(pages[currentIndex]['title'],style: TextStyle(color: Theme.of(context).primaryColor),)),
        body: pages[currentIndex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          onTap: selectedPage,
          backgroundColor: Colors.black.withOpacity(0.8),
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 15,
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: lanProvider.getText("MyHome"),
            ),
            BottomNavigationBarItem(
              icon:const Icon( Icons.favorite),
              label: lanProvider.getText("MyFavorites"),
            ),
          ],
        ),
        drawer: MyDrawer(),
      ),
    );
  }
}
