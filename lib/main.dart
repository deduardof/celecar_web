import 'package:celecar_web/database/database.dart';
import 'package:celecar_web/models/usuario.dart';
import 'package:celecar_web/pages/controle.dart';
import 'package:celecar_web/pages/page_login.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestão de Diário de Bordo - CeleCAR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
          future: Database().verificaSessao(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Controle(
                    usuario: snapshot.data
                        as Usuario); //HomePage(usuario: snapshot.data as Usuario);
              } else {
                return LoginPage();
              }
            } else {
              return const Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }
}
