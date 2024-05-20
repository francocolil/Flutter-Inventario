// ------------------------------------------------ Es la creacion del FORMULARIO del LOGIN ----------------------------------------------------------------
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app/src/pages/UsuarioInicio/home_user.dart';
// Recibir el TOKEN del usuario para que quede guardado
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> _formKey = GlobalKey();
  String _email = "";
  String _password = "";
  bool passToggle = true;

  void _submit() {
    if (_formKey.currentState != null) {
      final isLogin = _formKey.currentState!.validate();
      print('IsLogin Form $isLogin');
      if (isLogin) {
        // Realizar la lógica de inicio de sesión aquí
        loginUser(_email, _password);
      }
    }
  }

  Future<void> loginUser(String email, String password) async {
    final url =
        Uri.parse('http://192.168.0.15:3900/api/user/loginUserInventario');
    try {
      final response = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
        },
      );
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Guarda el token y navega a HomeUser
        await getToken(responseData['token']);
        Navigator.of(context).pushReplacementNamed('home_user', arguments: {
          'username': email,
          'token': responseData['token'],
        });
      } else {
        // Maneja diferentes errores basados en el código de estado o la respuesta del servidor
        String errorMessage = 'Error desconocido, intenta de nuevo.';
        if (response.statusCode == 401) {
          errorMessage = 'Credenciales incorrectas. Inténtalo de nuevo.';
        } else if (response.statusCode == 500) {
          errorMessage = 'Problemas en el servidor, intenta más tarde.';
        }
        _showDialog('Error de autenticación', errorMessage);
      }
    } catch (e) {
      _showDialog('Error de conexión',
          'No se pudo conectar al servidor. Verifica tu conexión e inténtalo de nuevo.');
    }
  }

  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  // Devolver el TOKEN del usuario para que quede guardado
  Future<void> getToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  // --------------------------------------- Vista del Usuario al Iniciar Sesion ------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
            onChanged: (data) {
              _email = data;
            },
            validator: (data) {
              if (data == null || data.isEmpty) {
                return 'Por favor, ingrese su correo electrónico';
              } else if (!RegExp(r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b')
                  .hasMatch(data)) {
                return 'Ingrese un correo electrónico válido';
              }
              return null;
            },
          ),
          // Llamos al WIDGET "login_form" el cual se encuentra en la carpeta WIDGETS - este es nuestro estilo para el formulario
          SizedBox(
            //SEPARACION ENTRE LOS DOS FORMULARIOS
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
            onChanged: (data) {
              _password = data;
            },
            validator: (data) {
              if (data == null || data.isEmpty) {
                return 'Porfavor ingrese una contraseña';
              }
              return null;
            },
          ),

          // BOTON DE LOGIN
          SizedBox(
            //SEPARACION ENTRE LOS DOS FORMULARIOS
            height: 20,
          ),
          ButtonTheme(
            minWidth: 200, // Ajusta el ancho mínimo según sea necesario
            height: 50, // Ajusta la altura según sea necesario
            child: TextButton(
              onPressed:
                  _submit, // Llama a la función _submit para iniciar sesión
              child: Text(
                'Login', // Cambia el texto del botón a 'Login'
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18, // Ajusta el tamaño del texto aquí
                ),
              ),
            ),
          ),
          // Mini boton si es que no tiene una cuenta y que se pueda registrar
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Si no tiene una cuenta,',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              ButtonTheme(
                minWidth: 200, // Ajusta el ancho mínimo según sea necesario
                height: 50, // Ajusta la altura según sea necesario
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'sing_up');
                  },
                  child: Text(
                    'Registrate',
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
