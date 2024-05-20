// ----------------------------------------------- Esta es la Vista del usuario al momento de entrar en el LOGIN ----------------------------------------------------------------
import 'package:app/src/widgets/WidgetsRegisterAndLogin/login_form.dart';
import 'package:flutter/material.dart';

class SingIn extends StatefulWidget {
  const SingIn({Key? key}) : super(key: key);

  @override
  State<SingIn> createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 6, 215, 230),
              Color.fromARGB(255, 205, 216, 204),
            ],
            begin: Alignment.topCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            // El largo de los FORMULARIOS
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.pets, size: 100, color: Colors.white70),
                Text(
                  'Inicio de Sesión',
                  style: TextStyle(fontSize: 30.0, color: Colors.black),
                ),
                SizedBox(
                  //SEPARACION ENTRE LOS DOS FORMULARIOS
                  height: 20,
                ),
                LoginForm(), // Asegúrate de que LoginForm tenga un buen diseño y validación
              ],
            ),
          ),
        ),
      ),
    );
  }
}
