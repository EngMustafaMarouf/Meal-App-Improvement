import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';

import 'favorite_screen.dart';

class MealDetailsScreen extends StatelessWidget {

  final String mealId;
  final String mealTitle;
  final String mealImageUrl;
  final int mealDuration;
  final List<String> mealIngredients;
  final List<String> mealSteps;

  const MealDetailsScreen({
    required this.mealId,
    required this.mealTitle,
    required this.mealImageUrl,
    required this.mealDuration,
    required this.mealIngredients,
    required this.mealSteps,

  });




  @override
  Widget build(BuildContext context) {

    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    var langProvider = Provider.of<LanguageProvider>(context);

    return Directionality(
      textDirection: langProvider.isEn?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: deviceHeight*(0.4),
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(langProvider.getText(mealTitle)),
                background: Hero(
                    tag: mealId,
                    child: InteractiveViewer(

                        child: FadeInImage(
                          placeholder: const AssetImage('assets/images/placeHolder.jpg'),
                          image: NetworkImage(mealImageUrl),
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: double.infinity,
                        ))),
              ),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 5,),
                  Text(langProvider.getText("Ingredients"),style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor),textAlign: TextAlign.center,),
                  const SizedBox(height: 5,),
                  Container(
                    height: deviceHeight*(0.26),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children:mealIngredients.map((item) => Container(
                          width: double.infinity,
                          child: Card(
                            color: Colors.orange,
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                              child: Text(item,style: const TextStyle(color: Colors.black),),
                            ),
                          ),
                        )).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Text(langProvider.getText("Steps"),style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor),textAlign: TextAlign.center,),
                  const SizedBox(height: 5,),
                  Container(
                    height: deviceHeight*(0.26),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white
                    ),
                    child: ListView.builder(
                        itemCount: mealSteps.length,
                        itemBuilder:(ctx,index)=> ListTile(
                          leading: CircleAvatar(
                            child: Text("# ${index+1}"),
                          ),
                          title: Text(mealSteps[index],style: TextStyle(fontSize: 15,fontWeight: FontWeight.normal),),
                        )),
                  ),
                  const SizedBox(height: 80,),
                ]),

            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            if(Provider.of<MealProvider>(context,listen: false).isFavorite(mealId)){
              Provider.of<MealProvider>(context,listen: false).deleteFavoriteMeal(mealId);
            }else{
              Provider.of<MealProvider>(context,listen: false).addFavoriteMeal(mealId);
            }

          },
          child:Provider.of<MealProvider>(context).isFavorite(mealId)?
          const Icon(Icons.favorite,color: Colors.red,): const Icon(Icons.favorite,),
        ),
      ),
    );
  }
}
