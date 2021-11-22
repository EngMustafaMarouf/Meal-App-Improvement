import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/providers/theme_provider.dart';
import 'package:meal_app/widgets/drawer.dart';
import 'package:provider/provider.dart';

class ThemesScreen extends StatelessWidget {

  final bool fromPageView ;

  ThemesScreen({this.fromPageView = false});


  Widget buildRadioListTile(ThemeMode themeVal,String title,IconData? icon,BuildContext ctx){
    return RadioListTile(

        value: themeVal,
        secondary: Icon(icon,color: Theme.of(ctx).primaryColor,),
        groupValue: Provider.of<ThemeProvider>(ctx).tm,
        onChanged: (newThemeVal){
          Provider.of<ThemeProvider>(ctx,listen: false).ThemeModeChange(newThemeVal);
        },
        title: Text(title,style:TextStyle(color: Theme.of(ctx).primaryColor,fontWeight: FontWeight.normal),),
    );
  }







  @override
  Widget build(BuildContext context) {
    var lanProvider = Provider.of<LanguageProvider>(context);
    return Directionality(
      textDirection: lanProvider.isEn?TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        appBar: fromPageView?AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).canvasColor,
        ):AppBar(title: Text(lanProvider.isEn?"Your Themes":"السمات الخاصه بك",style: TextStyle(color: Theme.of(context).primaryColor),),),
        body: ListView(
          children: [
            const SizedBox(height: 20,),
            Text(lanProvider.isEn?"Adjust Your Themes Selection":"ضبط اختيار السمات الخاصة بك",style: TextStyle(color:Theme.of(context).primaryColor,fontSize: 23,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            const SizedBox(height: 40,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(lanProvider.isEn?"Choose your theme mode":"اختر وضع المظهر الخاص بك",style: TextStyle(color:Theme.of(context).primaryColor,fontSize: 23)),
            ),
            buildRadioListTile(ThemeMode.system, lanProvider.isEn?"System default theme":"موضوع النظام الافتراضي", null, context),
            buildRadioListTile(ThemeMode.light, lanProvider.isEn?"Light theme":"الوضع المضيئ", Icons.light, context),
            buildRadioListTile(ThemeMode.dark, lanProvider.isEn?"Dark theme":"الوضع المظلم", Icons.dark_mode, context),
            SizedBox(height: fromPageView?100:null,),

          ],
        ),
        drawer: fromPageView?null:MyDrawer(),
      ),
    );
  }
}
