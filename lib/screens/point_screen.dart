import 'package:app_color/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class point_screen extends StatelessWidget {
  
  static bool registered = false;
  int aciertos = 114;
  @override
  Widget build(BuildContext context) {
  
    TableRow _tableRow = const TableRow(
      children: <Widget> [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text("ejemplo"),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text("ejemplo"),
        )
      ]
    );


    if (registered){
      return pantallaTabla();
    }
    return register(context);
  }
  String namesubmitted = "";  
  Widget register(BuildContext context){
    return SafeArea(
         child: Scaffold(
          appBar: AppBar(
        title: Text('Ingresar nombre'),
        elevation: 0,
        ),
        
         body: Column(
          children: [
            Spacer(),
          TextField(
          decoration: 
            InputDecoration(border: OutlineInputBorder(),labelText: "nombre"),
          onSubmitted: (value) {
          },
          ),
          
          Spacer(),

          ElevatedButton(
          child: const Text('registrar'),
          onPressed: () {
             //await initializeUser(value);
           Navigator.pop
            (context, MaterialPageRoute(builder: (context)=> Homescreen()
             )
            );
            Navigator.push
            (context, MaterialPageRoute(builder: (context)=> point_screen()
             )
            );
            registered = true;
          }
          ),

          Spacer(),

        ]
      )
      )
    );
  }
  Widget pantallaTabla(){

    TableRow _tableRow = const TableRow(
      children: <Widget> [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text("nombre"),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text("puntos"),
        )
      ]
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("TABLA DE PUNTOS"),
      ),
      body: Center(
        child: Table(
          border: TableBorder.all(),
          defaultColumnWidth: const FixedColumnWidth(200.0),
          children: <TableRow> [
            _tableRow,
            _tableRow,
            _tableRow,
            _tableRow
          ],
        ),
      ),
      
    );
  }
}






