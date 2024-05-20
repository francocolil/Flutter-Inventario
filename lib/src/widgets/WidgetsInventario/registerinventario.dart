import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class RegisterInventarioForm extends StatefulWidget {
  final String ingresoinventarioId; // ID del ingreso de inventario
  final String token; // Token JWT para la autenticación

  const RegisterInventarioForm(
      {Key? key, required this.ingresoinventarioId, required this.token})
      : super(key: key);

  @override
  State<RegisterInventarioForm> createState() => _RegisterInventarioFormState();
}

class _RegisterInventarioFormState extends State<RegisterInventarioForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _nombreempresa = '';
  String _etiqueta = '';
  String _descripcion = '';
  String _marca = '';
  String _modelo = '';
  String _numeroserie = '';
  String _color = '';
  String _material = '';
  String _medidas = '';
  String _estado = '';
  String _area = '';
  String _observaciones = '';
  String _estado2 = '';
  String _conclusion = '';
  bool _isRegistering = false;
  File? _image;

  Future<void> registrarInventario(BuildContext context) async {
    setState(() {
      _isRegistering = true;
    });

    final url = Uri.parse(
        'http://192.168.0.15:3900/api/inventario/inventario/registerInventario/${widget.ingresoinventarioId}');
    try {
      var request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = 'Bearer ${widget.token}';

      request.fields['nombreempresa'] = _nombreempresa;
      request.fields['etiqueta'] = _etiqueta;
      request.fields['descripcion'] = _descripcion;
      request.fields['marca'] = _marca;
      request.fields['modelo'] = _modelo;
      request.fields['numeroserie'] = _numeroserie;
      request.fields['color'] = _color;
      request.fields['material'] = _material;
      request.fields['medidas'] = _medidas;
      request.fields['estado'] = _estado;
      request.fields['area'] = _area;
      request.fields['observaciones'] = _observaciones;
      request.fields['estado2'] = _estado2;
      request.fields['conclusion'] = _conclusion;

      if (_image != null) {
        request.files
            .add(await http.MultipartFile.fromPath('image', _image!.path));
      }

      final response = await request.send();

      if (response.statusCode == 201) {
        final responseData = await http.Response.fromStream(response);
        print('Inventario registrado: ${responseData.body}');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Registro Exitoso'),
              content: Text('Inventario registrado correctamente'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacementNamed(context, 'home_user',
                        arguments: {
                          'username': 'NombreDeUsuario',
                          'token': widget.token
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
            'Failed to register inventario. Status code: ${response.statusCode}');
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

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
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
              onChanged: (data) => setState(() => _nombreempresa = data),
              validator: (data) => data == null || data.isEmpty
                  ? 'Ingrese el Nombre de la Empresa'
                  : null,
            ),
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Etiqueta",
                border: OutlineInputBorder(),
              ),
              onChanged: (data) => setState(() => _etiqueta = data),
            ),
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Descripcion",
                border: OutlineInputBorder(),
              ),
              onChanged: (data) => setState(() => _descripcion = data),
            ),
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Marca",
                border: OutlineInputBorder(),
              ),
              onChanged: (data) => setState(() => _marca = data),
            ),
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Modelo",
                border: OutlineInputBorder(),
              ),
              onChanged: (data) => setState(() => _modelo = data),
            ),
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Numero de Serie",
                border: OutlineInputBorder(),
              ),
              onChanged: (data) => setState(() => _numeroserie = data),
            ),
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Color",
                border: OutlineInputBorder(),
              ),
              onChanged: (data) => setState(() => _color = data),
            ),
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Material",
                border: OutlineInputBorder(),
              ),
              onChanged: (data) => setState(() => _material = data),
            ),
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Medidas",
                border: OutlineInputBorder(),
              ),
              onChanged: (data) => setState(() => _medidas = data),
            ),
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Estado",
                border: OutlineInputBorder(),
              ),
              onChanged: (data) => setState(() => _estado = data),
            ),
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Area",
                border: OutlineInputBorder(),
              ),
              onChanged: (data) => setState(() => _area = data),
            ),
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Observaciones",
                border: OutlineInputBorder(),
              ),
              onChanged: (data) => setState(() => _observaciones = data),
            ),
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Estado 2",
                border: OutlineInputBorder(),
              ),
              onChanged: (data) => setState(() => _estado2 = data),
            ),
            SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Conclusion",
                border: OutlineInputBorder(),
              ),
              onChanged: (data) => setState(() => _conclusion = data),
            ),
            SizedBox(height: 20),
            _image == null
                ? Text("No hay imagen seleccionada")
                : Image.file(_image!),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text("Seleccionar Imagen"),
            ),
            SizedBox(height: 20),
            _isRegistering
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _isRegistering
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              registrarInventario(context);
                            }
                          },
                    child: Text(_isRegistering
                        ? 'Registrando...'
                        : 'Registrar Inventario'),
                  ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  'view_inventario',
                  arguments: {
                    'ingresoinventarioId': widget.ingresoinventarioId,
                    'token': widget.token,
                  },
                );
              },
              child: Text('Ver Inventarios Registrados'),
            )
          ],
        ),
      ),
    );
  }
}
