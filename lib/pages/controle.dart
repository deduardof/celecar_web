import 'package:celecar_web/database/database.dart';
import 'package:celecar_web/models/menu_principal_item.dart';
import 'package:celecar_web/models/usuario.dart';
import 'package:celecar_web/pages/menu_principal.dart';
import 'package:celecar_web/pages/page_home.dart';
import 'package:celecar_web/pages/page_login.dart';
import 'package:celecar_web/pages/page_pesquisar.dart';
import 'package:celecar_web/pages/page_pesquisar_lista.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Controle extends StatefulWidget {
  final Usuario usuario;

  const Controle({Key? key, required this.usuario}) : super(key: key);

  @override
  State<Controle> createState() => _ControleState();
}

class _ControleState extends State<Controle> {
  late Widget _page;

  List<MenuPrincipalItem> _menuBuild() {
    List<MenuPrincipalItem> menu = List.empty(growable: true);
    menu.add(MenuPrincipalItem(
        texto: 'Home',
        icone: FontAwesomeIcons.home,
        onPressed: () => _onMenuPressed(0)));
    menu.add(MenuPrincipalItem(
        texto: 'Pesquisar',
        icone: FontAwesomeIcons.search,
        onPressed: () => _onMenuPressed(1)));
    menu.add(MenuPrincipalItem(
        texto: 'Relatórios',
        icone: FontAwesomeIcons.print,
        onPressed: () => _onMenuPressed(2)));
    menu.add(MenuPrincipalItem(
        texto: 'Gerenciar',
        icone: FontAwesomeIcons.usersCog,
        onPressed: () => _onMenuPressed(3)));

    return menu;
  }

  _onMenuPressed(int id) {
    switch (id) {
      case 0:
        {
          _page = HomePage(usuario: widget.usuario);
          break;
        }
      case 1:
        {
          _page = const PesquisarPage();
          break;
        }
      case 2:
        {
          //_page = PesquisarLista(viagens: viagens);
          break;
        }
    }
    setState(() {});
  }

  @override
  void initState() {
    _page = HomePage(usuario: widget.usuario);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          child: Row(
            children: [
              const Spacer(),
              Expanded(
                  flex: 8,
                  child: Card(
                      elevation: 10,
                      margin: EdgeInsets.zero,
                      child: Row(children: [
                        Expanded(
                            flex: 1,
                            child: MenuPrincipal(
                              menu: _menuBuild(),
                            )),
                        Expanded(flex: 3, child: _page)
                      ]))),
              const Spacer()
            ],
          ),
        ));
  }
}
