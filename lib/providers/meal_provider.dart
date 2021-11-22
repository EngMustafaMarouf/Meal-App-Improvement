import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/models/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MealProvider extends ChangeNotifier{


  List<Meal> availableMeals = DUMMY_MEALS;
  List<Meal> favoriteMeals = [];
  List<Category> availableCategories = [];
  List<String> prefsFavoriteMeals = [];  // to save favorite meals in shared
  bool load = false;

  bool glutenFree = false;
  bool lactoseFree= false;
  bool vegetarian= false;
  bool vegan= false;





  bool isFavorite(String id){
    int  res = favoriteMeals.indexWhere((meal) => meal.id == id);
    return (res >= 0);
  }

  Future<void> deleteFavoriteMeal(String id) async{
    int  res = favoriteMeals.indexWhere((meal) => meal.id == id);
    if(res >= 0) favoriteMeals.removeAt(res);
    prefsFavoriteMeals.remove(id);
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('prefsFavoriteMeals', prefsFavoriteMeals);
  }




  Future<void> addFavoriteMeal(String id) async{
    final res = availableMeals.indexWhere((meal) => meal.id == id);


    if(res >= 0){
      favoriteMeals.add(availableMeals.elementAt(res));
      prefsFavoriteMeals.add(id);
      //////////////////////////////////////////////////////////////////
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList('prefsFavoriteMeals', prefsFavoriteMeals);
    }

    notifyListeners();

  }



  void filterMeals(bool gluten,bool lactose,bool veg,bool vega) async{
    availableMeals = DUMMY_MEALS;
    if(gluten){
      availableMeals = DUMMY_MEALS.where((meal) => !(meal.isGlutenFree == gluten)).toList();
    }

    if(lactose){
      availableMeals = availableMeals.where((meal) => !(meal.isLactoseFree == lactose)).toList();
    }

    if(veg){
      availableMeals = availableMeals.where((meal) => !(meal.isVegetarian == veg)).toList();
    }

    if(vega){
      availableMeals = availableMeals.where((meal) => !(meal.isVegan == vega)).toList();
    }

    glutenFree  = gluten;
    lactoseFree = lactose;
    vegetarian = veg;
    vegan = vega;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('gluten', gluten);
    prefs.setBool('lactose', lactose);
    prefs.setBool('vegetarian', veg);
    prefs.setBool('vegan', vega);
    //////////////////////////////////////////////////////////////////////////////////
    List<Category> tempAc = [];
    availableMeals.forEach((meal) {
      meal.categories.forEach((catId) {
        DUMMY_CATEGORIES.forEach((cat) {
          if(catId == cat.id){
            if(!tempAc.any((category) => category.id == catId )) {
              tempAc.add(cat);
            }
          }
        });
      });
    });
    availableCategories = tempAc;
    ////////////////////////////////////////////////

    List<Meal> fm = [];
    favoriteMeals.forEach((meal) {
      if(availableMeals.any((item) => item.id == meal.id)){
        fm.add(meal);
      }
    });

    favoriteMeals = fm;

    notifyListeners();
  }



  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    glutenFree = prefs.getBool('gluten')??false;
    lactoseFree = prefs.getBool('lactose')??false;
    vegetarian = prefs.getBool('vegetarian')??false;
    vegan = prefs.getBool('vegan')??false;
    filterMeals(glutenFree, lactoseFree, vegetarian,vegan);
    ////////////////////////////////////////////////////////getting favorite meals

    prefsFavoriteMeals = prefs.getStringList('prefsFavoriteMeals')??[];
    for(var mealId in prefsFavoriteMeals){
      final existIndex = favoriteMeals.indexWhere((meal) => meal.id == mealId);
      if(existIndex < 0){
        favoriteMeals.add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      }
    }


    notifyListeners();
  }



}