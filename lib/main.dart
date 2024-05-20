import 'package:flutter/material.dart';
// Importa las páginas que tienes
import 'package:app/src/pages/home_page.dart';
import 'package:app/src/pages/PagesRegisterAndLogin/sing_in.dart';
import 'package:app/src/pages/PagesRegisterAndLogin/sing_up.dart';
import 'package:app/src/pages/UsuarioInicio/home_user.dart';
import 'package:app/src/pages/PageEmpresa/empresa_register.dart';
import 'package:app/src/pages/PagesIngresoInventario/ingresoinventario.dart';
import 'package:app/src/pages/PagesIngresoInventario/viewingresinventario.dart';
import 'package:app/src/pages/PageInventario/pageregisterinventario.dart';
import 'package:app/src/pages/PageInventario/pageinventarioview.dart';
import 'package:app/src/pages/PageInventario/pagedatosinventario.dart'; // Asegúrate de que esta importación sea correcta
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: 'Home',
      routes: {
        'Home': (BuildContext context) => const HomePage(),
        'sing_in': (BuildContext context) => const SingIn(),
        'sing_up': (BuildContext context) => const SingUp(),
        'empresa_register': (BuildContext context) => const EmpresaRegister(),
      },
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case 'home_user':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) =>
                  HomeUser(username: args['username'], token: args['token']),
            );
          case 'ingreso_inventario':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) =>
                  IngresoInventario(empresaId: args['empresaId']),
            );
          case 'view_ingreso_inventario':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => VieIngresoInventario(
                  empresaId: args['empresaId'], token: args['token']),
            );
          case 'page_register_inventario':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => PageRegisterInventario(
                ingresoinventarioId: args['ingresoinventarioId'],
                token: args['token'],
              ),
            );
          case 'view_inventario':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => ViewInventario(
                ingresoinventarioId: args['ingresoinventarioId'],
                token: args['token'],
              ),
            );
          case 'inventario_detalle':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (context) => InventarioDetalle(
                inventario: args['inventario'],
              ),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => const HomePage(),
            );
        }
      },
    );
  }
}
