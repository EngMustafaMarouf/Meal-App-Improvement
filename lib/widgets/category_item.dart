import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/screens/category_meal_screen.dart';
import 'package:provider/provider.dart';


class CategoryItem extends StatelessWidget {


  final String catId;
  final String catTitle;
  final Color catColor;

  const CategoryItem({
    required this.catId,
    required this.catTitle,
    required this.catColor});


  @override
  Widget build(BuildContext context) {
    var lanProvider = Provider.of<LanguageProvider>(context);
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>CategoryMealScreen(catId,catTitle)));
      },
      child: Card(
          color: catColor,
          child: Center(
            child: Text(lanProvider.getText(catTitle),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Theme.of(context).primaryColor),),
          )
      ),
    );
  }
}
