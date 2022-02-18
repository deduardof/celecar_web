import 'package:celecar_web/database/database.dart';
import 'package:celecar_web/pdfs/pdfdata.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PDFCreator {
  final pdf = pw.Document();
  final String _frota = 'Frota CS BRASIL';
  final String _contrato = 'Contrato 2998/2020';
  final String periodo = 'Janeiro/2022';
  final int veiculo;
  final List<PDFData> viagens = List.empty(growable: true);

  PDFCreator({required this.veiculo}) {
    _getViagens();
  }

  _getViagens() async => await Database().getViagens(
      veiculo: veiculo,
      dataInicio: DateTime(2022, 1, 1),
      dataFim: DateTime(2022, 1, 31));

  addPage() async {
    pdf.addPage(pw.Page(
      margin: const pw.EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      pageFormat: PdfPageFormat.a4,
      orientation: pw.PageOrientation.landscape,
      build: (context) {
        return pw.Column(children: [
          _title(title: 'DIÁRIO DE BORDO - $periodo'),
          _subtitle(subtitle: 'HB20S BEP0X00'),
          _rowTitle(),
          pw.Container(
              decoration: const pw.BoxDecoration(
                  border: pw.Border(
                      left: pw.BorderSide(width: 1, color: PdfColors.grey),
                      top: pw.BorderSide(width: 1, color: PdfColors.grey))),
              child: pw.Column(children: _createData()))
        ]);
      },
    ));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  _title({required String title}) {
    return pw.Container(
        color: PdfColors.grey600,
        padding: pw.EdgeInsets.only(left: 20, top: 5, bottom: 5, right: 10),
        child: pw.Row(children: [
          pw.Expanded(
              child: pw.Text(title,
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
          pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [pw.Text(_frota), pw.Text(_contrato)])
        ]));
  }

  _subtitle({required String subtitle}) {
    return pw.Container(
        color: PdfColors.grey400,
        padding: pw.EdgeInsets.only(left: 20),
        child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
          pw.Expanded(
              child: pw.Text(subtitle,
                  style: pw.TextStyle(
                      fontSize: 12, fontWeight: pw.FontWeight.bold))),
          pw.Text('* informar tipo de Combustível'),
          pw.Padding(
              padding: const pw.EdgeInsets.all(10),
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('A - para álcool'),
                    pw.Text('G - para gasolina'),
                    pw.Text('D - para diesel')
                  ]))
        ]));
  }

  _rowTitle() {
    return pw.Container(
        child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Container(
            width: 60,
            color: PdfColors.amber,
            child: pw.Text('DATA', textAlign: pw.TextAlign.center)),
        pw.Container(
            width: 80,
            color: PdfColors.red,
            child: pw.Text('SETOR/OS', textAlign: pw.TextAlign.center)),
        pw.Container(
            width: 160,
            color: PdfColors.amber,
            child: pw.Column(children: [
              pw.Text('ITINERÁRIO'),
              pw.Row(children: [
                pw.Container(
                    width: 80,
                    child: pw.Text('DE', textAlign: pw.TextAlign.center)),
                pw.Container(
                    width: 80,
                    child: pw.Text('PARA', textAlign: pw.TextAlign.center))
              ])
            ])),
        pw.Container(
            width: 100,
            color: PdfColors.red,
            child: pw.Column(children: [
              pw.Text('SAÍDA', textAlign: pw.TextAlign.center),
              pw.Row(children: [
                pw.Container(
                    width: 50,
                    child: pw.Text('HORÁRIO',
                        style: pw.TextStyle(fontSize: 10),
                        textAlign: pw.TextAlign.center)),
                pw.Container(
                    width: 50,
                    child: pw.Text('KM',
                        style: pw.TextStyle(fontSize: 10),
                        textAlign: pw.TextAlign.center))
              ])
            ])),
        pw.Container(
            width: 100,
            color: PdfColors.blue,
            child: pw.Column(children: [
              pw.Text('CHEGADA', textAlign: pw.TextAlign.center),
              pw.Row(children: [
                pw.Container(
                    width: 50,
                    child: pw.Text('HORÁRIO',
                        style: pw.TextStyle(fontSize: 10),
                        textAlign: pw.TextAlign.center)),
                pw.Container(
                    width: 50,
                    child: pw.Text('KM',
                        style: pw.TextStyle(fontSize: 10),
                        textAlign: pw.TextAlign.center))
              ])
            ])),
        pw.Container(
            width: 120,
            color: PdfColors.green,
            child: pw.Column(children: [
              pw.Text('LITROS'),
              pw.Row(children: [
                pw.Container(
                    width: 60,
                    child: pw.Text('PRIME', textAlign: pw.TextAlign.center)),
                pw.Container(
                    width: 60,
                    child: pw.Text('OUTROS', textAlign: pw.TextAlign.center))
              ])
            ])),
        pw.Container(
            width: 40,
            color: PdfColors.red,
            child: pw.Container(
                width: 40,
                child: pw.Text('*', textAlign: pw.TextAlign.center))),
        pw.Container(
            width: 80,
            color: PdfColors.amber,
            child: pw.Container(
                width: 80,
                child: pw.Text('NOME', textAlign: pw.TextAlign.center))),
        pw.Container(
            width: 60,
            color: PdfColors.green,
            child: pw.Container(
                width: 60,
                child: pw.Text('QTDE PEDÁGIO', textAlign: pw.TextAlign.center)))
      ],
    ));
  }

  _createData() {
    List<pw.Widget> list = List.empty(growable: true);
    for (var data in viagens) {
      list.add(pw.Container(
        //padding: const pw.EdgeInsets.symmetric(vertical: 4),
        child: _rowData(data: data),
      ));
    }
    return list;
  }

  _box({required String data, required double width}) {
    return pw.Container(
        width: width,
        height: 20,
        padding: const pw.EdgeInsets.symmetric(vertical: 3),
        decoration: const pw.BoxDecoration(
            border: pw.Border(
                right: pw.BorderSide(width: 1, color: PdfColors.grey),
                bottom: pw.BorderSide(width: 1, color: PdfColors.grey))),
        child: pw.Text(data, textAlign: pw.TextAlign.center));
  }

  _rowData({required PDFData data}) {
    return pw.Row(children: [
      _box(data: DateFormat('dd/MM').format(data.data), width: 60),
      _box(data: data.setor, width: 80),
      _box(data: data.de, width: 80),
      _box(data: data.para, width: 80),
      _box(data: DateFormat('HH:mm').format(data.horarioSaida), width: 50),
      _box(data: data.quilometrageSaida.toString(), width: 50),
      _box(data: DateFormat('HH:mm').format(data.horarioChegada), width: 50),
      _box(data: data.quilometragemChegada.toString(), width: 50),
      _box(data: (data.prime > 0) ? data.prime.toString() : ' ', width: 60),
      _box(data: (data.outros > 0) ? data.outros.toString() : ' ', width: 60),
      _box(data: (data.tipo > 0) ? data.tipo.toString() : ' ', width: 40),
      _box(data: data.nome, width: 80),
      _box(data: (data.pedagio > 0) ? data.pedagio.toString() : ' ', width: 60),
      // pw.Container(
      //     width: 60,
      //     padding: pw.EdgeInsets.symmetric(vertical: 4),
      //     color: PdfColors.amber,
      //     child: pw.Text(DateFormat('dd/MM').format(data.data),
      //         textAlign: pw.TextAlign.center)),
      // pw.Container(
      //     width: 80,
      //     color: PdfColors.grey,
      //     child: pw.Text(data.setor, textAlign: pw.TextAlign.center)),
      // pw.Container(
      //     width: 80, child: pw.Text(data.de, textAlign: pw.TextAlign.center)),
      // pw.Container(
      //     width: 80,
      //     color: PdfColors.grey,
      //     child: pw.Text(data.para, textAlign: pw.TextAlign.center)),
      // pw.Container(
      //     width: 50,
      //     child: pw.Text(DateFormat('HH:mm').format(data.horarioSaida),
      //         textAlign: pw.TextAlign.center)),
      // pw.Container(
      //     width: 50,
      //     color: PdfColors.grey,
      //     child: pw.Text(data.quilometrageSaida.toString(),
      //         textAlign: pw.TextAlign.center)),
      // pw.Container(
      //     width: 50,
      //     child: pw.Text(DateFormat('HH:mm').format(data.horarioChegada),
      //         textAlign: pw.TextAlign.center)),
      // pw.Container(
      //     width: 50,
      //     color: PdfColors.grey,
      //     child: pw.Text(data.quilometragemChegada.toString(),
      //         textAlign: pw.TextAlign.center)),
      // pw.Container(
      //     width: 60,
      //     child: pw.Text((data.prime > 0) ? data.prime.toString() : '',
      //         textAlign: pw.TextAlign.center)),
      // pw.Container(
      //     width: 60,
      //     color: PdfColors.grey,
      //     child: pw.Text((data.outros > 0) ? data.outros.toString() : '',
      //         textAlign: pw.TextAlign.center)),
      // pw.Container(
      //     width: 40,
      //     child: pw.Text((data.tipo > 0) ? data.tipo.toString() : '',
      //         textAlign: pw.TextAlign.center)),
      // pw.Container(
      //     width: 80,
      //     color: PdfColors.grey,
      //     child: pw.Text(data.nome, textAlign: pw.TextAlign.center)),
      // pw.Container(
      //     width: 60,
      //     child: pw.Text((data.pedagio > 0) ? data.pedagio.toString() : '',
      //         textAlign: pw.TextAlign.center))
    ]);
  }
}
