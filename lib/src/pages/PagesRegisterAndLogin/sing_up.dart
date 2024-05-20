import 'package:app/src/widgets/WidgetsRegisterAndLogin/logout_form.dart';
import 'package:flutter/material.dart';

class SingUp extends StatefulWidget {
  const SingUp({Key? key}) : super(key: key);

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
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
              Color.fromARGB(255, 205, 216, 204)
            ],
            begin: Alignment.topCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 30),
              Text(
                'Crea tu Cuenta',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              LogoutForm(),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Términos y Condiciones"),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text(
                                  "Aquí van los términos y condiciones detallados..."),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Aceptar'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text('Términos y condiciones',
                    style: TextStyle(decoration: TextDecoration.underline)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
