import 'package:flutter/material.dart';
import 'package:app/src/widgets/InicioUsuario/user_home.dart'; // Asegúrate de que la ruta es correcta
import 'package:app/src/pages/PageEmpresa/empresa_register.dart'; // Asegúrate de que la ruta es correcta

class HomeUser extends StatefulWidget {
  final String username;
  final String token;

  const HomeUser({Key? key, required this.username, required this.token})
      : super(key: key);

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Empresas'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Bienvenido, ${widget.username}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navega a UserHome
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserHome(),
                  ),
                );
              },
              child: Text('Ver Empresas'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navega a EmpresaRegister
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmpresaRegister(),
                  ),
                );
              },
              child: Text('Registrar Empresa'),
            ),
          ],
        ),
      ),
    );
  }
}
