import 'package:app_prueba/screens/home_screen.dart';
import 'package:flutter/material.dart';


void main() => runApp(MyApp());

//texto ejemplo para ver si funciona git
class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Homescreen()
    ); 
  }

}


