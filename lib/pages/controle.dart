import 'package:celecar_web/database/database.dart';
import 'package:celecar_web/models/usuario.dart';
import 'package:celecar_web/pages/page_home_header.dart';
import 'package:celecar_web/pages/menu_principal.dart';
import 'package:celecar_web/pages/page_home.dart';
import 'package:celecar_web/pages/page_login.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Controle extends StatelessWidget {
  final Usuario usuario;
  const Controle({Key? key, required this.usuario}) : super(key: key);

  _build(Widget body) {
    return Row(
      children: [
        const Spacer(),
        Expanded(
          flex: 8,
          child: Card(
              margin: EdgeInsets.zero,
              elevation: 10,
              shadowColor: Colors.black,
              child: Container(
                  color: Colors.white,
                  child: Row(children: [
                    const MenuPrincipal(),
                    Expanded(child: body)
                  ]))),
        ),
        const Spacer()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //Widget page = HomePage(usuario: usuario);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Gestão de Diários de Bordo'),
          centerTitle: true,
          actions: [
            IconButton(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                onPressed: (() {
                  Database().deslogar().then((value) {
                    if (value) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false);
                    }
                  });
                }),
                icon: const FaIcon(FontAwesomeIcons.running)),
          ],
        ),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.grey.shade50,
            child: _build(HomePage(usuario: usuario))));
  }
}
