import 'dart:math';
import 'package:app_prueba/screens/point_screen.dart';
import 'package:flutter/material.dart';


class Homescreen extends StatefulWidget {

  @override
  State<Homescreen> createState() => _HomescreenState();
}



class _HomescreenState extends State<Homescreen> {

  double calcularDistanciaColor(Color color1, Color color2) {
    double dis = sqrt(
      pow((color1.red - color2.red), 2) +
      pow((color1.blue - color2.blue), 2) +
      pow((color1.green - color2.green), 2)
    );

    return dis;
  }

  Color getUserColor() => Color.fromARGB(255,
      (sliderRedValue*255).toInt(),
      (sliderGreenValue*255).toInt(), 
      (sliderBlueValue*255).toInt()
  );
  
  // input del usuario
  double sliderRedValue = 1;
  double sliderGreenValue = 1;
  double sliderBlueValue = 1;

  // color a adivinar
  Color ejemploColor = Colors.black;

  // distancia de acertado (cuanta menor distancia mas cerca del color)
  double distanciaColor = 100;

  // si el jugador ha acertado
  bool colorAcertado = false;
  // cantidad aciertos
  int aciertos = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //* AppBar
      appBar: AppBar(
        title: Text('Aciertos $aciertos'),
        elevation: 0,
      ),
      body: Column(children:
      

      [  
        // titulo
        Spacer(),
        Text(colorAcertado ? "Adivinaste!" : "Intenta mezclar este color"),

        // caja de color a adivinar
        Spacer(),
        Container(
          color: ejemploColor,
          width: 100,
          height: 100,
        ),

        // caja de color ingresado
        Spacer(),
        Container(
          color: getUserColor(),
          width: 100,
          height: 100,
        ),

        // sliders de cada tono para mezclar
        Spacer(),
        Column(children: [
          Slider(value: sliderRedValue, activeColor: Colors.red,
           onChanged: (double value) { setState(() { sliderRedValue = value; }); } ),
          
          Slider(value: sliderGreenValue, activeColor: Colors.green,
            onChanged: (double value) { setState(() { sliderGreenValue = value; }); }),
         
          Slider(value: sliderBlueValue, activeColor: Colors.blue,
            onChanged: (double value) { setState(() { sliderBlueValue = value; }); },)
        ]),
        Spacer(),

      ]),

      //* Tabs
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        
        onTap: (index) {

          
          // boton reset 
          if (index == 0)
          {
            // resetear los valores
            colorAcertado = false;
            distanciaColor = 100;

            sliderRedValue = 1;
            sliderGreenValue = 1;
            sliderBlueValue = 1;

            // generar un nuevo color para adivinar
            var rand = Random();
            ejemploColor = Color.fromARGB(255, rand.nextInt(255), rand.nextInt(255), rand.nextInt(255));
          }

          // boton check 
          if (index == 1)
          {
            // calcular la distancia del color
            distanciaColor = calcularDistanciaColor(getUserColor(), ejemploColor);

            // si la distancia es poca se ha acertado
            if (distanciaColor <= 50 && !colorAcertado) {
              colorAcertado = true;
              aciertos++;
            }
          }
          
          if (index == 2){
            Navigator.push
            (context, MaterialPageRoute(builder: (context)=> point_screen()
             )
            );
          }

          // actualizar la pantalla
          setState(() {});
        },

        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.replay_rounded),
            label: "reset"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: "check"
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "puntuaciones"
          ),
        ],
      ),
    );
  } 
}
