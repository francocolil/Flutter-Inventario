// -------------------------------------------------- Esta es la PRIMERA VISTA del usuario al abrir la APLICACION ----------------------------------------------------------------
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Aplicación Veterinaria',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
              Divider(height: 20.0),
              _buildButton(context, 'Login', 'sing_in'),
              SizedBox(height: 10),
              _buildButton(context, 'Registrarse', 'sing_up'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, String routeName) {
    return TextButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all<Size>(Size(200, 50)),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered))
              return Colors.blue.withOpacity(0.04);
            if (states.contains(MaterialState.focused) ||
                states.contains(MaterialState.pressed))
              return Colors.blue.withOpacity(0.12);
            return null;
          },
        ),
      ),
      onPressed: () => Navigator.pushNamed(context, routeName),
      child: Text(
        text,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
