import 'package:app_prueba/screens/home_screen.dart';
import 'package:app_prueba/screens/point_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void  main() async {


  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


//texto ejemplo para ver si funciona git
// cabeza de termo
class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Material App',
      initialRoute: "home",
      routes: {
        "home": ( _ )=> Homescreen(),
        "pont_screen":( _ ) => point_screen()
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

