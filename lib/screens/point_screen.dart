import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class point_screen extends StatelessWidget {

  int aciertos = 114;
  @override
  Widget build(BuildContext context) {
    bool registered = false;
    if (registered){
      return Table();
    }
    return register();
  }
  String namesubmitted = "";  
  Widget register(){
    return SafeArea(
         child: Scaffold(
         body: Column(
          children: [ 
          TextField(
          decoration: 
            InputDecoration(border: OutlineInputBorder(),labelText: "nombre"),
          onSubmitted: (value) {},
          ),
          Text("$namesubmitted")
        ]
      )
      )
    );
  }
  Widget Table(){
    return Scaffold(
      body: Text('TABLA'),
    );
  }
}




