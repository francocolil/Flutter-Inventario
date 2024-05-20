// ------------------------------------------------ Este es el FORMULARIO de REGISTRO del USUARIO ----------------------------------------------------------------
import 'package:flutter/material.dart';
// Conectando mi backend de nodejs para que haga las consultas https
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class LogoutForm extends StatefulWidget {
  const LogoutForm({super.key});

  @override
  State<LogoutForm> createState() => _LogoutFormState();
}

class _LogoutFormState extends State<LogoutForm> {
  String _name = '';
  String _surname = '';
  String _email = '';
  String _password = '';
  bool passToggle = true;

  // Función para enviar los datos del formulario al backend + Notificacion de que el Usuario se registro correctamente
  Future<void> registerUser(BuildContext context) async {
    final url =
        Uri.parse('http://192.168.0.15:3900/api/user/registerUserInventario');

    try {
      final response = await http.post(
        url,
        body: {
          'name': _name,
          'surname': _surname,
          'email': _email,
          'password': _password,
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Usuario registrado: $responseData');

        // Mostrar una alerta de éxito
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Registro exitoso'),
              content: Text(
                  '¡Felicidades, ya tiene una cuenta en nuestra aplicacion!'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushNamed(context, 'sing_in');
                  },
                  child: Text('Aceptar'),
                ),
              ],
            );
          },
        );
      } else {
        print('Error en el registro: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en la solicitud: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Nombre",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.face),
            ),
            onChanged: (data) => _name = data,
            validator: (data) => data == null || data.isEmpty
                ? 'Porfavor ingrese su Nombre'
                : null,
          ),
          // Llamos al WIDGET "login_form" el cual se encuentra en la carpeta WIDGETS - este es nuestro estilo para el formulario
          SizedBox(
            height: 20,
          ),
          TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Apellido",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.face_6),
            ),
            onChanged: (data) => _surname = data,
            validator: (data) => data == null || data.isEmpty
                ? 'Porfavor ingrese su Apellido'
                : null,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Correo Electronico",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
            onChanged: (data) => _email = data,
            validator: (data) => data == null || data.isEmpty
                ? 'Porfavor ingrese su Correo Electronico'
                : null,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            obscureText: passToggle,
            decoration: InputDecoration(
              labelText: "Contraseña",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock),
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    passToggle = !passToggle;
                  });
                },
                child:
                    Icon(passToggle ? Icons.visibility : Icons.visibility_off),
              ),
            ),
            onChanged: (data) => _password = data,
            validator: (data) => data == null || data.isEmpty
                ? 'Porfavor ingrese su Contraseña'
                : null,
          ),
          SizedBox(
            height: 20,
          ),
          // BOTON DE REGISTRO DE USUARIO
          TextButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all<Size>(
                    Size(200, 50)), // Cambiar el tamaño mínimo
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered))
                      return Colors.blue.withOpacity(0.04);
                    if (states.contains(MaterialState.focused) ||
                        states.contains(MaterialState.pressed))
                      return Colors.blue.withOpacity(0.12);
                    return null; // Defer to the widget's default.
                  },
                ),
              ),
              // Indicamos que al momento de precionar el boton tiene que enviarnos a una pagina que indicamos en la ruta, en este caso SingIn
              onPressed: () async {
                registerUser(context);
              },
              child: Text(
                'Registrarse',
                style:
                    TextStyle(fontSize: 18), // Ajusta el tamaño del texto aquí
              )),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Si tiene una cuenta aprete',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              ButtonTheme(
                minWidth: 200, // Ajusta el ancho mínimo según sea necesario
                height: 50, // Ajusta la altura según sea necesario
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'sing_in');
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18, // Ajusta el tamaño del texto aquí
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
