import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importar para usar la vibración

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        // BOTON 0
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Inicio',
        ),
        // BOTON 1
        BottomNavigationBarItem(
          icon: Icon(Icons.add_business),
          label: 'Registrar Empresa',
        ),
        // BOTON 2
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Configuracion',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.tealAccent[700],
      unselectedItemColor:
          Colors.grey[600], // Cambio de color para ítems no seleccionados
      onTap: (index) {
        HapticFeedback.lightImpact(); // Feedback táctil al cambiar de ítem
        onItemTapped(index);
        animateToPage(index, context);
      },
    );
  }

  void animateToPage(int index, BuildContext context) {
    // Aquí determinamos qué acción ejecutar según el índice del botón seleccionado
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, 'home_user');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, 'empresa_register');
        break;
    }
  }
}
