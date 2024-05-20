import 'package:flutter/material.dart';
import 'package:app/src/widgets/WidgetsInventario/inventarioview.dart';

class ViewInventario extends StatefulWidget {
  final String ingresoinventarioId; // Cambiado a ingresoinventarioId
  final String token; // Agregar el token JWT

  const ViewInventario(
      {Key? key, required this.ingresoinventarioId, required this.token})
      : super(key: key);

  @override
  State<ViewInventario> createState() => _ViewInventarioState();
}

class _ViewInventarioState extends State<ViewInventario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventario"),
      ),
      body: InventarioView(
        ingresoinventarioId: widget.ingresoinventarioId,
        token: widget.token,
      ),
    );
  }
}
