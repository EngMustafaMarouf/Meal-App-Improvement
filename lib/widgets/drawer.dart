import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/favorite_screen.dart';
import 'package:meal_app/screens/settings.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'package:meal_app/screens/your_themes_screen.dart';
import 'package:provider/provider.dart';


class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var lanProvider = Provider.of<LanguageProvider>(context);

    return Directionality(
        textDirection: lanProvider.isEn? TextDirection.ltr:TextDirection.rtl,
        child: Drawer(

          child: Column(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.orange,
                child: Center(child: Text(lanProvider.getText("Cooking Up!"),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Theme.of(context).primaryColor),)),
              ),
              ListTile(
                onTap: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=> TabsScreen()));
                },
                tileColor: Colors.yellow.withOpacity(0.3),
                leading: const Icon(Icons.restaurant,color: Colors.red,size: 30,),
                title: Text(lanProvider.getText("Categories"),style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20,fontWeight: FontWeight.bold),),
                subtitle: Text(lanProvider.getText("many categories of food"),style: const TextStyle(color: Colors.red),),
              ),
              ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> SettingsScreen()));
                },
                tileColor: Colors.yellow.withOpacity(0.3),
                leading: const Icon(Icons.settings,color: Colors.red,size: 30,),
                title: Text(lanProvider.getText("Settings"),style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20,fontWeight: FontWeight.bold)),
                subtitle: Text(lanProvider.getText("your filters"),style: const TextStyle(color: Colors.red),),
              ),
              ListTile(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> ThemesScreen()));
                },
                tileColor: Colors.yellow.withOpacity(0.3),
                leading: const Icon(Icons.color_lens,color: Colors.red,size: 30,),
                title: Text(lanProvider.getText("Theme"),style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 20,fontWeight: FontWeight.bold)),
                subtitle: Text(lanProvider.getText("Choose your theme"),style: const TextStyle(color: Colors.red),),
              ),
              Container(
                color: Colors.yellow.withOpacity(0.3),
                child: Column(
                  children: [
                    Divider(color: Theme.of(context).primaryColor,thickness: 2,),
                    FittedBox(child: Text(lanProvider.getText("Choose your preferred language"),style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.center,)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(lanProvider.getText("Arabic"),style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 20),),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Switch(
                              activeColor: Colors.green,
                              inactiveTrackColor: Colors.grey,
                              inactiveThumbColor: Colors.red,
                              value: Provider.of<LanguageProvider>(context).isEn,
                              onChanged: (newVal){
                                Provider.of<LanguageProvider>(context,listen: false).changeLanguage(newVal);
                                Navigator.pop(context);
                              }),
                        ),
                        Text(lanProvider.getText("English"),style: TextStyle(color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold,fontSize: 20),),
                      ],
                    ),
                    Divider(color: Theme.of(context).primaryColor,thickness: 2,),
                  ],
                ),
              ),


            ],
          ),
        ),

    );
  }
}
