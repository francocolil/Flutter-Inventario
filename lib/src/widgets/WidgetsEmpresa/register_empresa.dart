import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterEmpresa extends StatefulWidget {
  const RegisterEmpresa({super.key});

  @override
  State<RegisterEmpresa> createState() => _RegisterEmpresaState();
}

class _RegisterEmpresaState extends State<RegisterEmpresa> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name = '';
  String _address = '';
  bool _isRegistering = false;

  Future<void> empresaRegister(BuildContext context, String token) async {
    setState(() {
      _isRegistering = true;
    });

    final url =
        Uri.parse('http://192.168.0.15:3900/api/empresa/registerEmpresa');
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: {
          'name': _name,
          'address': _address,
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Empresa Registrada: $responseData');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Registro Exitoso'),
              content: Text('Empresa Registrada Correctamente'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacementNamed(context, 'home_user',
                        arguments: {
                          'username': 'NombreDeUsuario',
                          'token': token
                        });
                  },
                  child: Text('Aceptar'),
                ),
              ],
            );
          },
        );
      } else {
        throw Exception(
            'Failed to register empresa. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en la Solicitud: $e');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error en la red. Intente nuevamente.')));
    } finally {
      setState(() {
        _isRegistering = false;
      });
    }
  }

  Future<String> obtenerTokenDeAlgunaParte() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Nombre de la Empresa",
                border: OutlineInputBorder(),
              ),
              onChanged: (data) => setState(() => _name = data),
              validator: (data) => data == null || data.isEmpty
                  ? 'Ingrese el Nombre de la Empresa'
                  : null,
            ),
            SizedBox(
              //SEPARACION ENTRE LOS DOS FORMULARIOS
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Direccion de la Empresa",
                border: OutlineInputBorder(),
              ),
              onChanged: (data) => setState(() => _address = data),
              validator: (data) => data == null || data.isEmpty
                  ? 'Ingrese la direccion de la Empresa'
                  : null,
            ),
            SizedBox(height: 20),
            _isRegistering
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _isRegistering
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              String userToken =
                                  await obtenerTokenDeAlgunaParte();
                              empresaRegister(context, userToken);
                            }
                          },
                    child: Text(_isRegistering
                        ? 'Registrando...'
                        : 'Registrar Empresa'),
                  )
          ],
        ),
      ),
    );
  }
}
