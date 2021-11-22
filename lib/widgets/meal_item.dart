import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/screens/meal_details_screen.dart';
import 'package:provider/provider.dart';

class MealItem extends StatelessWidget {

  final String mealId;
  final String mealTitle;
  final String mealImageUrl;
  final int mealDuration;
  final Complexity complexity;
  final Affordability affordability;
  final List<String> mealIngredients;
  final List<String> mealSteps;

  MealItem({
    required this.mealId,
    required this.mealTitle,
    required this.mealImageUrl,
    required this.mealDuration,
    required this.complexity,
    required this.affordability,
    required this.mealIngredients,
    required this.mealSteps,

  });

  String get complexityText{
    switch(complexity){
      case Complexity.Simple:
        return "Simple";
      case Complexity.Challenging:
        return "Challenging";
      case Complexity.Hard:
        return "Hard";
    }
  }

  String get affordabilityText{
    switch(affordability){
      case Affordability.pricey:
        return "Pricy";
      case Affordability.Luxurious:
        return "Luxurious";
      case Affordability.Affordable:
        return "Affordable";
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    var langProvider = Provider.of<LanguageProvider>(context);
    return InkWell(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>MealDetailsScreen(
              mealId: mealId,
              mealTitle: mealTitle,
              mealImageUrl: mealImageUrl,
              mealDuration: mealDuration,
              mealIngredients:mealIngredients,
            mealSteps: mealSteps,
          )));
        },
        child: Card(
            elevation: 15,
            shadowColor: Colors.red,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Stack(
                    children: [
                      Container(
                        child: ClipRRect(
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                            child: Hero(
                                tag: mealId,
                                child: InteractiveViewer(

                                    child: FadeInImage(
                                      placeholder: const AssetImage('assets/images/placeHolder.jpg'),
                                      image: NetworkImage(mealImageUrl),
                                      fit: BoxFit.fill,
                                      height: double.infinity,
                                      width: double.infinity,

                                    )))),
                      ),

                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          height: 70,
                          width: 200,
                          color: Colors.black.withOpacity(0.5),
                          child:Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(langProvider.getText(mealTitle),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),overflow: TextOverflow.ellipsis,maxLines: 2,),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

                Expanded(
                  child: FittedBox(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          TextButton.icon(onPressed: (){}, icon: Icon(Icons.timer,color: Theme.of(context).primaryColor,), label: Text("$mealDuration min")),
                          TextButton.icon(onPressed: (){}, icon: Icon(Icons.work,color: Theme.of(context).primaryColor,), label: Text(complexityText)),
                          TextButton.icon(onPressed: (){}, icon: Icon(Icons.attach_money,color: Theme.of(context).primaryColor,), label: Text(affordabilityText)),
                        ],
                      ),
                  ),
                ),

              ],
            ),
          ),
      );
  }
}
