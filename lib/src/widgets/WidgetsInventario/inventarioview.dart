import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:app/src/pages/PageInventario/pagedatosinventario.dart'; // Asegúrate de que esta ruta es correcta

class InventarioView extends StatefulWidget {
  final String ingresoinventarioId;
  final String token;

  const InventarioView(
      {Key? key, required this.ingresoinventarioId, required this.token})
      : super(key: key);

  @override
  _InventarioViewState createState() => _InventarioViewState();
}

class Inventario {
  final String id;
  final String nombreempresa;
  final String etiqueta;
  final String descripcion;
  final String marca;
  final String modelo;
  final String numeroserie;
  final String color;
  final String material;
  final String medidas;
  final String estado;
  final String area;
  final String observaciones;
  final String estado2;

  Inventario({
    required this.id,
    required this.nombreempresa,
    required this.etiqueta,
    required this.descripcion,
    required this.marca,
    required this.modelo,
    required this.numeroserie,
    required this.color,
    required this.material,
    required this.medidas,
    required this.estado,
    required this.area,
    required this.observaciones,
    required this.estado2,
  });

  factory Inventario.fromJson(Map<String, dynamic> json) {
    return Inventario(
      id: json['_id'],
      nombreempresa: json['nombreempresa'],
      etiqueta: json['etiqueta'],
      descripcion: json['descripcion'],
      marca: json['marca'],
      modelo: json['modelo'],
      numeroserie: json['numeroserie'],
      color: json['color'],
      material: json['material'],
      medidas: json['medidas'],
      estado: json['estado'],
      area: json['area'],
      observaciones: json['observaciones'],
      estado2: json['estado2'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nombreempresa': nombreempresa,
      'etiqueta': etiqueta,
      'descripcion': descripcion,
      'marca': marca,
      'modelo': modelo,
      'numeroserie': numeroserie,
      'color': color,
      'material': material,
      'medidas': medidas,
      'estado': estado,
      'area': area,
      'observaciones': observaciones,
      'estado2': estado2,
    };
  }
}

Future<List<Inventario>> fetchInventarios(
    String ingresoinventarioId, String token) async {
  final response = await http.get(
    Uri.parse(
        'http://192.168.0.15:3900/api/inventario/ingreso/$ingresoinventarioId/inventarios'),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    var responseData = json.decode(response.body);
    if (responseData is Map<String, dynamic> &&
        responseData.containsKey('data')) {
      List<dynamic> inventariosJson = responseData['data'];
      return inventariosJson.map((json) => Inventario.fromJson(json)).toList();
    } else {
      throw Exception('Unexpected JSON format: ${response.body}');
    }
  } else {
    throw Exception('Failed to load inventarios: ${response.body}');
  }
}

class _InventarioViewState extends State<InventarioView> {
  late Future<List<Inventario>> futureInventarios;

  @override
  void initState() {
    super.initState();
    futureInventarios =
        fetchInventarios(widget.ingresoinventarioId, widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Inventario>>(
      future: futureInventarios,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Inventario inventario = snapshot.data![index];
              return ListTile(
                title: Text(inventario.descripcion),
                subtitle: Text("Modelo: ${inventario.modelo}"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          InventarioDetalle(inventario: inventario.toJson()),
                    ),
                  );
                },
              );
            },
          );
        } else {
          return Center(child: Text("No hay inventarios registrados"));
        }
      },
    );
  }
}
