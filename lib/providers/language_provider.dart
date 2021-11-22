import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LanguageProvider extends ChangeNotifier{

  bool isEn = true;

//    '':'',
  Map<String,Object> textEn = {
    'Cooking Up!':'Cooking Up!',
    'Categories':'Categories',
    'many categories of food':'many categories of food',
    'Settings':'Settings',
    'your filters':'your filters',
    'Theme':'Theme',
    'Choose your theme':'Choose your theme',
    'Choose your preferred language':'Choose your preferred language',
    'English':'English',
    'Arabic':'Arabic',
    'MyHome':'MyHome',
    'MyFavorites':'MyFavorites',
    'My Favorite Meals':'My Favorite Meals',
    'Quick & Easy':'Quick & Easy',
    'Italian':'Italian',
    'German':'German',
    'Hamburgers':'Hamburgers',
    'Summer':'Summer',
    'Light & Lovely':'Light & Lovely',
    'Breakfast':'Breakfast',
    'Exotic':'Exotic',
    'French':'French',
    'Asian':'Asian',
    'Spaghetti with Tomato Sauce':'Spaghetti with Tomato Sauce',
    'Toast Hawaii':'Toast Hawaii',
    'Classic Hamburger':'Classic Hamburger',
    'Wiener Schnitzel':'Wiener Schnitzel',
    'Salad with Smoked Salmon':'Salad with Smoked Salmon',
    'Delicious Orange Mousse':'Delicious Orange Mousse',
    'Pancakes':'Pancakes',
    'Creamy Indian Chicken Curry':'Creamy Indian Chicken Curry',
    'Chocolate Souffle':'Chocolate Souffle',
    'Asparagus Salad with Cherry Tomatoes':'Asparagus Salad with Cherry Tomatoes',
    'Ingredients':'Ingredients',
    'Steps':'Steps',
    'Adjust Your Meal Selection':'Adjust Your Meal Selection',
    'Gluten_Free':'Gluten_Free',
    'Only include gluten free meals':'Only include gluten free meals',
    'Lactose_Free':'Lactose_Free',
    'Only include lactose meals':'Only include lactose meals',
    'Vegetarian':'Vegetarian',
    'Only include vegetarian meals':'Only include vegetarian meals',
    'Vegan':'Vegan',
    'Only include vegan meals':'Only include vegan meals',
    'Save your Filters':'Save your Filters'
  };

  Map<String,Object> textAr = {
    'Cooking Up!':'عالم الطبخ',
    'Categories':'الاصناف',
    'many categories of food':'العديد من الاطعمه',
    'Settings':'الاعدادات',
    'your filters':'فلتر',
    'Theme':'سمه',
    'Choose your theme':'اختار السمه الخاصه بك',
    'Choose your preferred language':'اختار لغتك المفضله',
    'English':'اللغه الانجليزيه',
    'Arabic':'اللغه العربيه',
    'MyHome':'الشاشه الرايسيه',
    'MyFavorites':'مفضلتي',
    'My Favorite Meals':'وجباتي المفضله',
    'Quick & Easy':'سهل/سريع',
    'Italian':'ايطالي',
    'German':'الماني',
    'Hamburgers':'هامبرغر',
    'Summer':'صيفي',
    'Light & Lovely':'سريع وجميل',
    'Breakfast':'فطار',
    'Exotic':'استوائي',
    'French':'فرنسي',
    'Asian':'اسيوي',
    'Spaghetti with Tomato Sauce':'معكرونة مع صلصة الطماطم',
    'Toast Hawaii':'توست هاواي',
    'Classic Hamburger':'كلاسيك هامبرغر',
    'Wiener Schnitzel':'وينر شنيتزل',
    'Salad with Smoked Salmon':'سلطة مع سلمون مدخن',
    'Delicious Orange Mousse':'موس البرتقال اللذيذ',
    'Pancakes':'الفطائر',
    'Creamy Indian Chicken Curry':'دجاج بالكاري الهندي',
    'Chocolate Souffle':'سوفلي الشوكولاته',
    'Asparagus Salad with Cherry Tomatoes':'سلطة الهليون مع الطماطم الكرزية',
    'Ingredients':'المكونات',
    'Steps':'الخطوات',
    'Adjust Your Meal Selection':'اضبط اختيارك لوجبتك',
    'Gluten_Free':'خالي من الغلوتين',
    'Only include gluten free meals':'تشمل فقط وجبات خالية من الغلوتين',
    'Lactose_Free':'خالي من اللاكتوز',
    'Only include lactose meals':'تشمل وجبات اللاكتوز فقط',
    'Vegetarian':'نباتي 1',
    'Only include vegetarian meals':'تشمل فقط وجبات نباتية',
    'Vegan':'نباتي 2',
    'Only include vegan meals':'تشمل فقط وجبات نباتية',
    'Save your Filters':'احفظ الفلاتر',

  };


  void changeLanguage(bool lang) async{
    isEn = lang;
    SharedPreferences prefs = await  SharedPreferences.getInstance();
    prefs.setBool('isEn', isEn);
    notifyListeners();
  }


  void getLanguage() async{
    SharedPreferences prefs = await  SharedPreferences.getInstance();
    isEn = prefs.getBool('isEn')?? true;
    print(isEn);
    notifyListeners();
  }


  dynamic getText(String txt){
    return isEn?textEn[txt]:textAr[txt];
  }


}