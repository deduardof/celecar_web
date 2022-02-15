import 'package:celecar_web/models/usuario.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final Usuario usuario;
  const HomeHeader({Key? key, required this.usuario}) : super(key: key);

  _item(String label, String content, int flex) {
    return Expanded(
      flex: flex,
      child: Row(
        children: [
          Center(
              child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 70),
                  child: Text(label,
                      textAlign: TextAlign.start,
                      style: const TextStyle(fontWeight: FontWeight.bold)))),
          Text(content)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Container(
          padding: const EdgeInsets.all(10.0),
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    _item('Nome:', usuario.nome, 3),
                    _item('Matrícula:', usuario.matricula.toString(), 1),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    _item('Setor:', usuario.setorNome, 4),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
