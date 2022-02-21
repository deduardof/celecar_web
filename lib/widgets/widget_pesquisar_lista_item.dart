import 'package:celecar_web/pdfs/pdfdata.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PesquisarListaItem extends StatelessWidget {
  final PDFData viagem;
  PesquisarListaItem({Key? key, required this.viagem}) : super(key: key);
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy HH:mm');

  _label(String label) {
    return Text(label,
        style: const TextStyle(color: Colors.grey, fontSize: 14));
  }

  _content(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, top: 2.0),
      child: Text(content, style: const TextStyle(color: Colors.purple)),
    );
  }

  _item(String label, String content, {int flex = 1}) {
    return Expanded(
        flex: flex,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_label(label), _content(content)]));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Row(
            children: [
              _item('Veículo', viagem.veiculo),
              _item('De', viagem.de),
              _item('Para', viagem.para),
              _item('Setor', viagem.setor),
              _item('Motorista', viagem.nome, flex: 2)
            ],
          ),
          Row(
            children: [
              _item(
                  'Horário de saída', _dateFormat.format(viagem.horarioSaida)),
              _item('Quilometragem', viagem.quilometrageSaida.toString(),
                  flex: 2),
              _item('Horário de retorno',
                  _dateFormat.format(viagem.horarioChegada)),
              _item('Quilometragem', viagem.quilometragemChegada.toString(),
                  flex: 2)
            ],
          )
        ],
      ),
    );
  }
}
