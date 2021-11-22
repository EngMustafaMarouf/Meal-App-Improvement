import 'package:flutter/material.dart';
import 'package:meal_app/providers/language_provider.dart';
import 'package:meal_app/screens/settings.dart';
import 'package:meal_app/screens/tabs_screen.dart';
import 'package:meal_app/screens/your_themes_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';





class PageViewScreen extends StatefulWidget {
  const PageViewScreen({Key? key}) : super(key: key);

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {

  final pageController = PageController(initialPage: 0);
  int currentIndex = 0;


  @override
  Widget build(BuildContext context) {


    var langProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            children: [
              Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: ExactAssetImage('assets/images/2.jpg'),
                      fit: BoxFit.fill,

                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 250,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                            child: Text(langProvider.getText("Cooking Up!"),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                          ),
                        ),
                      ),
                      Container(
                        width: 350,
                        height: 100,

                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: FittedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(langProvider.getText("Choose your preferred language"),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),textAlign: TextAlign.center,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(langProvider.getText("Arabic"),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Switch(
                                        activeColor: Colors.green,
                                        inactiveTrackColor: Colors.grey,
                                        inactiveThumbColor: Colors.red,
                                        value: Provider.of<LanguageProvider>(context).isEn,
                                        onChanged: (newVal){
                                          Provider.of<LanguageProvider>(context,listen: false).changeLanguage(newVal);
                                        }),
                                  ),
                                  Text(langProvider.getText("English"),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
              ),
              ThemesScreen(fromPageView: true,),
              SettingsScreen(fromPageView: true,),

            ],

            onPageChanged: (newVal){
              setState(() {
                currentIndex = newVal;
              });
            },
          ),
          const Align(
            alignment: Alignment.centerRight,
            child: Icon(Icons.arrow_forward_ios,size: 30,color: Colors.orange,)
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Indicator(currentIndex)),
          Align(
            alignment: Alignment(0,0.85),
            child: MaterialButton(
              color: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              onPressed: () async{
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>TabsScreen()));
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool("watched", true);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: langProvider.isEn?7:0,horizontal: langProvider.isEn?50:85),
                child: Text(langProvider.isEn?"Get Started":"ابداالان",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
              ),
                ),
          ),
        ],
      ),
    );
  }
}


class Indicator extends StatelessWidget{

  final int index;

  Indicator(this.index);


  @override
  Widget build(BuildContext context) {

    return Container(
        width: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildCircle(0),
            buildCircle(1),
            buildCircle(2),
          ],
        ),
      );
  }


  Widget buildCircle(int ind){
    return ind == index?Icon(Icons.star,size: 35,color: Colors.orange,):CircleAvatar(
      radius: 8,
      backgroundColor: Colors.red,
    );
  }


}



