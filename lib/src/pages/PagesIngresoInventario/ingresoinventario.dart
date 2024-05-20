import 'package:flutter/material.dart';
import 'package:app/src/widgets/WidgetsIngresoInventario/register_ingresoinventario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IngresoInventario extends StatefulWidget {
  final String empresaId;

  const IngresoInventario({Key? key, required this.empresaId})
      : super(key: key);

  @override
  _IngresoInventarioState createState() => _IngresoInventarioState();
}

class _IngresoInventarioState extends State<IngresoInventario> {
  String? token; // Changed from late String to nullable String
  bool isLoading = true; // Added to track token loading state

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      isLoading = false; // Update loading state
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de Ingreso de Inventario"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : (token == null
              ? Center(child: Text("Failed to load token"))
              : RegisterIngresoInventarioForm(
                  empresaId: widget.empresaId,
                  token: token!,
                )),
    );
  }
}
