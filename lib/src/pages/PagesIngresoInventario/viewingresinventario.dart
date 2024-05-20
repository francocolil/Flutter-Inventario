import 'package:flutter/material.dart';
import 'package:app/src/widgets/WidgetsIngresoInventario/ingresoinventarioview.dart';

class VieIngresoInventario extends StatefulWidget {
  final String empresaId; // Agregar el ID de la empresa
  final String token; // Agregar el token JWT

  const VieIngresoInventario(
      {Key? key, required this.empresaId, required this.token})
      : super(key: key);

  @override
  State<VieIngresoInventario> createState() => _VieIngresoInventarioState();
}

class _VieIngresoInventarioState extends State<VieIngresoInventario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ingreso del Inventario"),
      ),
      body: IngresoInventarioView(
          empresaId: widget.empresaId, token: widget.token),
    );
  }
}
