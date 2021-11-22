import 'package:flutter/material.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/screens/splash_screen.dart';
import 'package:meal_app/widgets/category_item.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    List<Category> availableCategories = Provider.of<MealProvider>(context).availableCategories;


    return Scaffold(
      body: availableCategories.isEmpty?SplashScreen():
          GridView.builder(
          itemCount: availableCategories.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3/2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
          ),
          itemBuilder: (ctx,index){

            return CategoryItem(
                catId:availableCategories[index].id,
                catTitle: availableCategories[index].title,
                catColor:availableCategories[index].color);
          }),

    );
  }
}
