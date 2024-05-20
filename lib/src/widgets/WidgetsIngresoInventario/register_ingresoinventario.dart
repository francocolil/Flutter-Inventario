import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart'; // Para las conversiones de fechas
import 'package:app/src/pages/PagesIngresoInventario/viewingresinventario.dart';

class RegisterIngresoInventarioForm extends StatefulWidget {
  final String empresaId; // ID de la empresa
  final String token; // Token JWT para la autenticación

  const RegisterIngresoInventarioForm(
      {Key? key, required this.empresaId, required this.token})
      : super(key: key);

  @override
  _RegisterIngresoInventarioFormState createState() =>
      _RegisterIngresoInventarioFormState();
}

class _RegisterIngresoInventarioFormState
    extends State<RegisterIngresoInventarioForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _descripcion = '';
  DateTime? _fechaIngreso;
  final TextEditingController _dateController = TextEditingController();

  Future<void> _registerIngresoInventario() async {
    final empresaId = widget.empresaId;
    final url = Uri.parse(
        'http://192.168.0.15:3900/api/ingresoinventario/empresa/$empresaId/registroIngresoInventario');
    String formattedDate = _fechaIngreso != null
        ? DateFormat('dd/MM/yyyy').format(_fechaIngreso!)
        : '';

    var body = jsonEncode({
      'empresa': empresaId,
      'descripcion': _descripcion,
      'fechaIngreso': formattedDate,
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${widget.token}'
        },
        body: body,
      );

      if (response.statusCode == 201) {
        var responseData = json.decode(response.body);
        print('Ingreso de inventario registrado correctamente');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Registro exitoso"),
              content: Text(
                  "El ingreso de inventario fue registrado correctamente. Descripción: ${responseData['descripcion']}"),
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
      } else {
        print(
            'Failed to register inventory entry. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Error al registrar el ingreso de inventario.")));
      }
    } catch (e) {
      print('Error making the HTTP request: $e');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error de red. Intente nuevamente.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Descripción'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor introduzca una descripción';
                }
                return null;
              },
              onChanged: (value) => _descripcion = value,
            ),
            TextFormField(
              controller: _dateController,
              decoration: InputDecoration(
                labelText: 'Fecha de Ingreso (DD/MM/YYYY)',
                suffixIcon: Icon(Icons.calendar_today),
              ),
              onTap: () async {
                FocusScope.of(context).requestFocus(
                    new FocusNode()); // To prevent opening default keyboard
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(() {
                    _fechaIngreso = pickedDate;
                    _dateController.text =
                        DateFormat('dd/MM/yyyy').format(pickedDate);
                  });
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _registerIngresoInventario();
                }
              },
              child: Text('Registrar Ingreso de Inventario'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VieIngresoInventario(
                      empresaId: widget.empresaId,
                      token: widget.token,
                    ),
                  ),
                );
              },
              child: Text('Ver los Ingresos de Inventario'),
            )
          ],
        ),
      ),
    );
  }
}
