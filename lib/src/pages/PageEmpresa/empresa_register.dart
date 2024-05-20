import 'package:flutter/material.dart';
import 'package:app/src/widgets/WidgetsEmpresa/register_empresa.dart';

class EmpresaRegister extends StatefulWidget {
  const EmpresaRegister({super.key});

  @override
  State<EmpresaRegister> createState() => _EmpresaRegisterState();
}

class _EmpresaRegisterState extends State<EmpresaRegister> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color.fromARGB(255, 6, 215, 230),
              Color.fromARGB(255, 205, 216, 204),
            ],
            begin: Alignment.topCenter,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 100),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Registro de Empresa',
                  style: TextStyle(fontSize: 30.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RegisterEmpresa(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
