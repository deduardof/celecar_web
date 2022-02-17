import 'package:celecar_web/database/database.dart';
import 'package:celecar_web/models/usuario.dart';
import 'package:celecar_web/models/veiculo.dart';
import 'package:celecar_web/pages/page_home_header.dart';
import 'package:celecar_web/pages/page_home_veiculos.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final Usuario usuario;

  const HomePage({Key? key, required this.usuario}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Veiculo> veiculos = List.empty(growable: true);

  _loadVeiculos() async {
    await Database().getVeiculos(setor: widget.usuario.setor).then((list) {
      veiculos = list;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _loadVeiculos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          HomeHeader(usuario: widget.usuario),
          HomeVeiculos(veiculos: veiculos)
        ],
      ),
    );
  }
}
