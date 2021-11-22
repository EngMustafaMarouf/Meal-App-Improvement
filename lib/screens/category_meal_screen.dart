import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/widgets/meal_item.dart';
import 'package:provider/provider.dart';

class CategoryMealScreen extends StatefulWidget {

  final String catId;
  final String catTitle;

  CategoryMealScreen(this.catId,this.catTitle);

  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {


  @override
  Widget build(BuildContext context) {

    List<Meal> meals = Provider.of<MealProvider>(context).availableMeals.where((meal){
      return meal.categories.contains(widget.catId);
    }).toList();

    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    var deviceWidth = MediaQuery.of(context).size.width;
    var lanProvider = Provider.of<LanguageProvider>(context);

    return Directionality(
      textDirection: lanProvider.isEn?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text(lanProvider.getText(widget.catTitle)),),
        body: GridView.builder(
          itemCount: meals.length,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: deviceWidth <= 350 ? 350 : 400,
              childAspectRatio: isLandScape?deviceWidth/(deviceWidth*0.71):deviceWidth/(deviceWidth*0.715),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (ctx,index){
              return MealItem(
                mealId: meals[index].id,
                mealTitle: meals[index].title,
                mealImageUrl: meals[index].imageUrl,
                mealDuration: meals[index].duration,
                complexity: meals[index].complexity,
                affordability: meals[index].affordability,
                mealIngredients: meals[index].ingredients,
                mealSteps: meals[index].steps,
              );
            }),

      ),
    );
  }
}
