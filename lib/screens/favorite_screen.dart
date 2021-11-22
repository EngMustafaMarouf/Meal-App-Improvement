import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:meal_app/widgets/meal_item.dart';
import 'package:provider/provider.dart';


class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    List<Meal> favoriteMeals = Provider.of<MealProvider>(context).favoriteMeals;
    bool isLandScape = MediaQuery.of(context).orientation == Orientation.landscape;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Provider.of<MealProvider>(context).favoriteMeals.isEmpty? Center(
      child: Text("No Favorites Added yet!",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor),),
    ):GridView.builder(
        itemCount: favoriteMeals.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: deviceWidth<=350?350:400,
            childAspectRatio: isLandScape?deviceWidth/(deviceWidth*0.71):deviceWidth/(deviceWidth*0.715),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (ctx,index){
            return MealItem(
              mealId: favoriteMeals[index].id,
              mealTitle: favoriteMeals[index].title,
              mealImageUrl: favoriteMeals[index].imageUrl,
              mealDuration: favoriteMeals[index].duration,
              complexity: favoriteMeals[index].complexity,
              affordability: favoriteMeals[index].affordability,
              mealIngredients: favoriteMeals[index].ingredients,
              mealSteps: favoriteMeals[index].steps,
            );
      }),
    );
  }
}
