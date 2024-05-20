import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/src/pages/PagesIngresoInventario/ingresoinventario.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  List<dynamic> empresas = [];

  @override
  void initState() {
    super.initState();
    fetchEmpresas();
  }

  Future<void> fetchEmpresas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    final response = await http.get(
      Uri.parse('http://192.168.0.15:3900/api/empresa/showEmpresa'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      setState(() {
        empresas = jsonDecode(response.body)['empresas'];
      });
    } else {
      print('Failed to load empresas');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Empresas'),
      ),
      body: ListView.builder(
        itemCount: empresas.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(empresas[index]['name']),
              subtitle: Text(empresas[index]['address']),
              onTap: () {
                print(
                    "Tapping on ${empresas[index]['name']} with ID ${empresas[index]['_id']}");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        IngresoInventario(empresaId: empresas[index]['_id']),
                  ),
                );
              });
        },
      ),
    );
  }
}
