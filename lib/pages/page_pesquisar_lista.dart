import 'package:celecar_web/pdfs/pdfdata.dart';
import 'package:celecar_web/widgets/widget_pesquisar_lista_item.dart';
import 'package:flutter/material.dart';

class PesquisarLista extends StatelessWidget {
  final List<PDFData> viagens;
  const PesquisarLista({Key? key, required this.viagens}) : super(key: key);

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
                return PesquisarListaItem(viagem: viagens.elementAt(index));
              }),
              separatorBuilder: (context, index) => const Divider()),
        ),
      ),
    );
  }
}
