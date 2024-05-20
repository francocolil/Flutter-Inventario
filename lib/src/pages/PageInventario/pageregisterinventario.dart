import 'package:flutter/material.dart';
import 'package:app/src/widgets/WidgetsInventario/registerinventario.dart';

class PageRegisterInventario extends StatefulWidget {
  final String ingresoinventarioId; // ID del ingreso de inventario
  final String token; // Token JWT para la autenticación

  const PageRegisterInventario(
      {Key? key, required this.ingresoinventarioId, required this.token})
      : super(key: key);

  @override
  State<PageRegisterInventario> createState() => _PageRegisterInventario();
}

class _PageRegisterInventario extends State<PageRegisterInventario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro de Inventario"),
      ),
      body: RegisterInventarioForm(
        ingresoinventarioId: widget.ingresoinventarioId,
        token: widget.token,
      ),
    );
  }
}
