import 'package:app_color/screens/home_screen.dart';
import 'package:app_color/score_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScoreScreen extends StatefulWidget {
  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  
  static bool isUserRegistered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: ScoreController.isUserRegistered(),
        builder: (context, snapshot) {
          // Mientras se está obteniendo el resultado, se puede mostrar un indicador de carga
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          // Si hay un error, mostrar un mensaje de error
          else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          // Si la operación asíncrona se completó con éxito, mostrar los datos
          else {
            isUserRegistered = snapshot.data ?? false;
            return scoreScreen(context);
          }
        },
      ),
    );
  }


  Widget scoreScreen(BuildContext context) {

    if (!isUserRegistered) {
      return registerScreen(context);
    }

    return scoreTableScreen(context);
  }


  String usernameInput = "";
  String registerMessage = 'Ingresar nombre';  
  Widget registerScreen(BuildContext context) {
    return SafeArea(
         child: Scaffold(
          appBar: AppBar(
        title: Text('Registro'),
        elevation: 0,
        ),
        
         body: Column(
          children: [
            Spacer(),
                Text(registerMessage),
          Spacer(),

          TextField(
          decoration: 
            InputDecoration(border: OutlineInputBorder(),labelText: "nombre"),
          onChanged: (value) { usernameInput = value; } ,
          ),
          
          Spacer(),

          ElevatedButton(
          child: const Text('Registrar'),
          onPressed: () async {
            await ScoreController.createUser(usernameInput);
            isUserRegistered = await ScoreController.isUserRegistered();
            if (isUserRegistered) {
              await ScoreController.saveScore();
              Navigator.pop(context,
                MaterialPageRoute(builder: (context)=> Homescreen())
              );

              Navigator.push(context,
                MaterialPageRoute(builder: (context)=> ScoreScreen())
              );
            }
            else {
              registerMessage = "Error al registrarse";
            }

          }
          ),

          Spacer(),

        ]
      )
      )
    );
  }
  


  Widget scoreTableScreen(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>> (
        future: ScoreController.getScores(),
        builder: (context, snapshot) {
          // Mientras se está obteniendo el resultado, se puede mostrar un indicador de carga
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          // Si hay un error, mostrar un mensaje de error
          else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          // Si la operación asíncrona se completó con éxito, mostrar los datos
          else {
            return scoreTableWidget(context, snapshot.data);
          }
        },
      ),
    );
  }

  Widget scoreTableWidget(BuildContext context, List<Map<String, dynamic>>? scores) {

    // no scores
    if (scores == null) {
      return Center(
        child: Text("No scores"),
      );
    }

    TableRow createRow(String usuario, int puntaje) {
      return TableRow(
            children: <Widget> [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(usuario),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(puntaje.toString()),
              )
            ]
      );
    }

    List<TableRow> tableRows = [];
    for (var score in scores) {
      TableRow row = createRow(score["usuario"], score["puntaje"]);
      tableRows.add(row);
    }

    // no scores
    if (tableRows.isEmpty) {
      return Center(
        child: Text("No scores"),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Tabla de puntos"),
      ),
      body: Center(
        child: Table(
          border: TableBorder.all(),
          defaultColumnWidth: const FixedColumnWidth(200.0),
          children: tableRows,
        ),
      ),
      
    );
  }

 
}






