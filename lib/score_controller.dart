import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

class ScoreController {

  static int score = 0;

  static Future initializeServices() async {
    // iniciar servicio firebase
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
    );
  }


  static Future<String> createUser(nickname) async {
    // obtener la instancia de la base de datos
    var db = FirebaseFirestore.instance;

    // verificar si el usuario ya esta registrado
    String userID = await getUserID();
    if (userID != "") {
      return userID;
    }

    // Create a new doc
    final scoreDoc = <String, dynamic> {
      "usuario": nickname,
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

  static Future<String> getUserID() async {
    final prefs = await SharedPreferences.getInstance();
    final userID = prefs.getString('userID') ?? "";

    if (userID == "") {
      print("Cannot get user id");
      return "";
    }

    return userID;
  }

  static Future<bool> isUserRegistered() async {
    return await ScoreController.getUserID() != "";
  }


  static Future<void> saveScore() async {
    // obtener la instancia de la base de datos
    var db = FirebaseFirestore.instance;

    // obtener el id de usuario almacenado en el dispositivo
    String userID = await getUserID();
    if (userID == "") {
      return;
    }

    var userScore = await getUserScore();
    if (userScore >= score){
      return;
    }

    // Create a new score doc
    final newScoreDoc = <String, dynamic> {
      "puntaje": score
    };

    // Update the document
    await db.collection("puntuaciones").doc(userID).set(newScoreDoc, SetOptions(merge: true));
  }

  static Future<int> getUserScore() async {
    // obtener la instancia de la base de datos
    var db = FirebaseFirestore.instance;

    String userID = await getUserID();
    if (userID == "") {
      return 0;
    }

    var scoreDoc = await db.collection("puntuaciones").doc(userID).get();
    var _score = scoreDoc.data()?["puntaje"];

    return _score ?? 0;
  }

  static Future<List<Map<String, dynamic>>> getScores() async {
    // obtener la instancia de la base de datos
    var db = FirebaseFirestore.instance;

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

}