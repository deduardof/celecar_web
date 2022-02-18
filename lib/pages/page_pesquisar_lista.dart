import 'package:celecar_web/pdfs/pdfdata.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PesquisarLista extends StatelessWidget {
  final List<PDFData> viagens;
  const PesquisarLista({Key? key, required this.viagens}) : super(key: key);

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

  _listItem(PDFData viagem) {
    DateFormat dt = DateFormat('dd/MM/yyyy HH:mm');
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_label('Veículo'), _content(viagem.veiculo)],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _label('De'),
                  _content(viagem.de),
                  _label('Para'),
                  _content(viagem.para)
                ]),
          ),
          Expanded(
            flex: 1,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_label('Setor'), _content(viagem.setor)]),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label('Horário de saída'),
                _content(dt.format(viagem.horarioSaida)),
                _label('Quilometragem'),
                _content(viagem.quilometrageSaida.toString())
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label('Horário de retorno'),
                _content(dt.format(viagem.horarioChegada)),
                _label('Quilometragem'),
                _content(viagem.quilometragemChegada.toString())
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_label('Motorista'), _content(viagem.nome)],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 10,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, left: 5, right: 0, bottom: 20),
          child: ListView.separated(
              shrinkWrap: true,
              itemCount: viagens.length,
              itemBuilder: ((context, index) {
                return _listItem(viagens.elementAt(index));
              }),
              separatorBuilder: (context, index) => const Divider()),
        ),
      ),
    );
  }
}
