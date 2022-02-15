import 'package:celecar_web/models/veiculo.dart';
import 'package:celecar_web/pdfs/pdf_creator.dart';
import 'package:flutter/material.dart';

class VeiculoWidget extends StatelessWidget {
  final Veiculo veiculo;
  const VeiculoWidget({Key? key, required this.veiculo}) : super(key: key);

  Widget _item(String label, String content, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(content),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _item('Veículo:', veiculo.getDescricao()),
          _item('Quilometragem:', veiculo.quilometragem.toString() + 'KM'),
          _item(
              'Status:',
              (veiculo.status == Veiculo.disponivel)
                  ? 'Disponível'
                  : 'Em viagem'),
          ElevatedButton(
              onPressed: () {
                PDFCreator(veiculo: veiculo.id).addPage();
              },
              child: const Text('Gerenciar')),
        ],
      ),
    );
  }
}
