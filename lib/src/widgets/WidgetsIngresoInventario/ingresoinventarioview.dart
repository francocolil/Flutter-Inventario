import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart'; // Importa intl para formatear fechas

class IngresoInventarioView extends StatefulWidget {
  final String empresaId;
  final String token;

  const IngresoInventarioView(
      {Key? key, required this.empresaId, required this.token})
      : super(key: key);

  @override
  _IngresoInventarioViewState createState() => _IngresoInventarioViewState();
}

class IngresoInventario {
  final String id;
  final String descripcion;
  final DateTime fechaIngreso;
  final String empresaName;

  IngresoInventario({
    required this.id,
    required this.descripcion,
    required this.fechaIngreso,
    required this.empresaName,
  });

  factory IngresoInventario.fromJson(Map<String, dynamic> json) {
    return IngresoInventario(
      id: json['_id'],
      descripcion: json['descripcion'],
      fechaIngreso: DateTime.parse(json['fechaingreso']),
      empresaName: json['empresa']['name'],
    );
  }
}

Future<List<IngresoInventario>> fetchIngresosInventario(
    String empresaId, String token) async {
  final response = await http.get(
    Uri.parse(
        'http://192.168.0.15:3900/api/ingresoinventario/empresa/$empresaId/ingresos'),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    var responseData = json.decode(response.body);
    if (responseData is Map<String, dynamic> &&
        responseData.containsKey('data')) {
      List<dynamic> ingresosJson = responseData['data'];
      return ingresosJson
          .map((json) => IngresoInventario.fromJson(json))
          .toList();
    } else {
      throw Exception('Unexpected JSON format: ${response.body}');
    }
  } else {
    throw Exception('Failed to load ingresos de inventario: ${response.body}');
  }
}

class _IngresoInventarioViewState extends State<IngresoInventarioView> {
  late Future<List<IngresoInventario>> futureIngresos;

  @override
  void initState() {
    super.initState();
    futureIngresos = fetchIngresosInventario(widget.empresaId, widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<IngresoInventario>>(
      future: futureIngresos,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              IngresoInventario ingreso = snapshot.data![index];
              return ListTile(
                title: Text(ingreso.descripcion),
                subtitle: Text(
                    "Fecha de ingreso: ${DateFormat('dd/MM/yyyy').format(ingreso.fechaIngreso.toLocal())}\nEmpresa: ${ingreso.empresaName}"),
                onTap: () {
                  print(
                      "Navigating to register inventario with ID: ${ingreso.id}");
                  Navigator.pushNamed(
                    context,
                    'page_register_inventario',
                    arguments: {
                      'ingresoinventarioId': ingreso.id,
                      'token': widget.token,
                    },
                  );
                },
              );
            },
          );
        } else {
          return Center(
              child: Text("No hay ingresos de inventario registrados"));
        }
      },
    );
  }
}
