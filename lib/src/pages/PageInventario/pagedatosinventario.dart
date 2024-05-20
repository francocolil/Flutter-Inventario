import 'package:flutter/material.dart';

class InventarioDetalle extends StatelessWidget {
  final Map<String, dynamic> inventario;

  const InventarioDetalle({Key? key, required this.inventario})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalle del Inventario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            inventario['imageUrl'] != null
                ? Image.network(
                    inventario['imageUrl'],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : Text('No image available'),
            ListTile(
              title: Text('Nombre Empresa'),
              subtitle: Text(inventario['nombreempresa'] ?? 'N/A'),
            ),
            ListTile(
              title: Text('Etiqueta'),
              subtitle: Text(inventario['etiqueta'] ?? 'N/A'),
            ),
            ListTile(
              title: Text('Descripción'),
              subtitle: Text(inventario['descripcion'] ?? 'N/A'),
            ),
            ListTile(
              title: Text('Marca'),
              subtitle: Text(inventario['marca'] ?? 'N/A'),
            ),
            ListTile(
              title: Text('Modelo'),
              subtitle: Text(inventario['modelo'] ?? 'N/A'),
            ),
            ListTile(
              title: Text('Número de Serie'),
              subtitle: Text(inventario['numeroserie'] ?? 'N/A'),
            ),
            ListTile(
              title: Text('Color'),
              subtitle: Text(inventario['color'] ?? 'N/A'),
            ),
            ListTile(
              title: Text('Material'),
              subtitle: Text(inventario['material'] ?? 'N/A'),
            ),
            ListTile(
              title: Text('Medidas'),
              subtitle: Text(inventario['medidas'] ?? 'N/A'),
            ),
            ListTile(
              title: Text('Estado'),
              subtitle: Text(inventario['estado'] ?? 'N/A'),
            ),
            ListTile(
              title: Text('Área'),
              subtitle: Text(inventario['area'] ?? 'N/A'),
            ),
            ListTile(
              title: Text('Observaciones'),
              subtitle: Text(inventario['observaciones'] ?? 'N/A'),
            ),
            ListTile(
              title: Text('Estado 2'),
              subtitle: Text(inventario['estado2'] ?? 'N/A'),
            ),
          ],
        ),
      ),
    );
  }
}
