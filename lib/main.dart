import 'package:app_color/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_color/screens/point_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

var db;


Future<List<Map<String, dynamic>>> getScores() async {
  var query = await db.collection("puntuaciones")
              .orderBy("puntaje", descending: true)
              .limit(10)
              .get();

  List<Map<String, dynamic>> scores = [];
  for (var doc in query.docs) {
    scores.add(doc.data());
  }
  return scores;
}


Future<String> getUserID() async {
  final prefs = await SharedPreferences.getInstance();
  final userID = prefs.getString('userID') ?? "";

  if (userID == "") {
    print("Cannot get user id");
    return "";
  }

  return userID;
}

Future<void> saveScore(int score) async {

  // obtener el id de usuario almacenado en el dispositivo
  String userID = await getUserID();
  if (userID == "") {
    return;
  }

  // Create a new score doc
  final scoreDoc = <String, dynamic> {
    "usuario": "pepe",
    "puntaje": score
  };

  // Update the document
  await db.collection("puntuaciones").doc(userID).set(scoreDoc);
}

Future<String> initializeUser(nickname) async {

  // verificar si el usuario ya esta registrado
  String userID = await getUserID();
  if (userID != "") {
    return userID;
  }

  // Create a new doc
  final scoreDoc = <String, dynamic> {
    "nickname": nickname,
    "puntaje": 0
  };

  // Add a new document with a generated ID
  DocumentReference doc = await db.collection("puntuaciones").add(scoreDoc);
  userID = doc.id;

  print('New user added with ID: ${userID}');

  // guardar la id de usuario en el dispositivo
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userID', userID);

  return userID;
}

void  main() async {
  runApp(MyApp());

  // iniciar servicio firebase
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );

  // iniciar la base de datos
  db = FirebaseFirestore.instance;

  await initializeUser("pepe");
  await saveScore(15);

  await getScores();


}

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

