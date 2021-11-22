import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/meal_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {

  final bool fromPageView ;

  SettingsScreen({this.fromPageView = false});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {


  bool glutenFree =false;
  bool lactoseFree =false;
  bool vegetarian=false;
  bool vegan =false;


  @override
  initState(){
    var providerObj = Provider.of<MealProvider>(context,listen: false);
    glutenFree = providerObj.glutenFree;
    lactoseFree = providerObj.lactoseFree;
    vegetarian= providerObj.vegetarian;
    vegan = providerObj.vegan;
    super.initState();
  }



//title == "Gluten_Free"?glutenFree:(title == "Lactose_Free"?lactoseFree:(title == "Vegetarian"?vegetarian:vegan)
  Widget buildListTile(String title,String sub,control){
    return ListTile(
      title: Text(title,style: Theme.of(context).textTheme.headline6,),
      subtitle: Text(sub,style: TextStyle(color: Theme.of(context).primaryColor),),
      trailing: Switch(
        value: control,
        inactiveTrackColor: Colors.black,
        onChanged: (val){
          setState(() {
            if(title == "Gluten_Free" || title == "خالي من الغلوتين") {
              glutenFree  = val;
            }
            if(title == "Lactose_Free" || title == "خالي من اللاكتوز"){
              lactoseFree = val;
            }
            if(title == "Vegetarian" || title == "نباتي 1") {
              vegetarian = val;
            }
            if(title == "Vegan" || title == "نباتي 2"){
              vegan = val;
            }

          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    var providerObj = Provider.of<MealProvider>(context,listen: false);
    var lanProvider = Provider.of<LanguageProvider>(context);
    return Directionality(
      textDirection: lanProvider.isEn?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        appBar: widget.fromPageView?AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).canvasColor,
        ):AppBar(title: Text(lanProvider.getText("Settings"),style: TextStyle(color: Theme.of(context).primaryColor),),),
        body: ListView(
          children: [
            SizedBox(height: widget.fromPageView?5:20,),
            Text(lanProvider.getText("Adjust Your Meal Selection"),style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor),textAlign: TextAlign.center,),
            const SizedBox(height: 10,),
            buildListTile(lanProvider.getText("Gluten_Free"), lanProvider.getText("Only include gluten free meals"),glutenFree),
            buildListTile(lanProvider.getText("Lactose_Free"), lanProvider.getText("Only include lactose meals"),lactoseFree),
            buildListTile(lanProvider.getText("Vegetarian"), lanProvider.getText("Only include vegetarian meals"),vegetarian),
            buildListTile(lanProvider.getText("Vegan"), lanProvider.getText("Only include vegan meals"),vegan),
            const SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: MaterialButton(
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                onPressed: (){
                  Provider.of<MealProvider>(context,listen: false).filterMeals(glutenFree, lactoseFree, vegetarian, vegan);
                  ScaffoldMessenger.of(context).showSnackBar(
                       SnackBar(
                        backgroundColor: Colors.orange.withOpacity(0.5),
                        content: Text(lanProvider.isEn?"Filters Updated":"تم تعديل الفلاتر بنجاح")),
                  );
                },
                color: Colors.deepPurple,
                child: Text(lanProvider.getText("Save your Filters"),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),
              ),
            ),
            SizedBox(height: widget.fromPageView?100:null,),
          ],
        ),
      ),
    );
  }
}
