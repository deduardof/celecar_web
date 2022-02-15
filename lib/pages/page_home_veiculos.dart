import 'package:celecar_web/models/veiculo.dart';
import 'package:celecar_web/widgets/widget_veiculo.dart';
import 'package:flutter/material.dart';

class HomeVeiculos extends StatelessWidget {
  final List<Veiculo> veiculos;
  const HomeVeiculos({Key? key, required this.veiculos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (veiculos.isEmpty) {
      return Card(
        elevation: 5,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          child: const Text('Não há veículos disponíveis para este setor.'),
        ),
      );
    } else {
      return Card(
        elevation: 5,
        child: ListView.separated(
            shrinkWrap: true,
            itemCount: veiculos.length,
            itemBuilder: (context, index) {
              return VeiculoWidget(veiculo: veiculos.elementAt(index));
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider()),
      );
    }
  }
}
