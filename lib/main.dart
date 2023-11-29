import 'package:app_color/screens/home_screen.dart';
import 'package:app_color/screens/score_screen.dart';
import 'package:app_color/score_controller.dart';
import 'package:flutter/material.dart';

void  main() async {
  runApp(MyApp());

  // iniciar los servicios firebase
  ScoreController.initializeServices();
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Material App',
      initialRoute: "home",
      routes: {
        "home": (_) => Homescreen(),
        "score_screen": (_) => ScoreScreen()
      },
    ); 
  }
}



class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

