import 'package:celecar_web/models/veiculo.dart';
import 'package:flutter/material.dart';

class VeiculoPage extends StatelessWidget {
  final Veiculo veiculo;
  const VeiculoPage({Key? key, required this.veiculo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Veículo $veiculo'),
    );
  }
}
