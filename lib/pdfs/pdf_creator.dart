import 'package:celecar_web/database/database.dart';
import 'package:celecar_web/models/periodos.dart';
import 'package:celecar_web/models/veiculo.dart';
import 'package:celecar_web/pdfs/pdfdata.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PDFCreator {
  final pdf = pw.Document();
  final String _frota = 'Frota CS BRASIL';
  final String _contrato = 'Contrato 2998/2020';
  final PeriodosItem periodo;
  final Veiculo veiculo;

  final List<PDFData> _viagens = List.empty(growable: true);

  PDFCreator({required this.veiculo, required this.periodo}) {
    _getViagens();
  }

  _getViagens() async => await Database()
          .getViagens(
              veiculo: veiculo.id,
              dataInicio: periodo.datetime,
              dataFim: DateTime(periodo.datetime.year, periodo.datetime.month,
                      _lastDayOfMonth())
                  .add(const Duration(hours: 23, minutes: 59, seconds: 59)))
          .then((list) {
        _viagens.addAll(list);
        addPage();
      });

  _lastDayOfMonth() {
    switch (periodo.datetime.month) {
      case 1:
      case 3:
      case 5:
      case 7:
      case 8:
      case 10:
      case 12:
        return 31;
      case 4:
      case 6:
      case 9:
      case 11:
        return 30;
      case 2:
        return ((periodo.datetime.year % 4 == 0 &&
                    periodo.datetime.year % 100 != 0) ||
                periodo.datetime.year % 400 == 0)
            ? 29
            : 28;
    }
  }

  addPage() async {
    pdf.addPage(pw.Page(
      margin: const pw.EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      pageFormat: PdfPageFormat.a4,
      orientation: pw.PageOrientation.landscape,
      build: (context) {
        return pw.Column(children: [
          _title(title: 'DIÁRIO DE BORDO - ${periodo.nome}'),
          _subtitle(subtitle: veiculo.getDescricao()),
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
        decoration: pw.BoxDecoration(
            color: PdfColors.grey600,
            border: pw.Border.all(width: 1, color: PdfColors.grey600)),
        padding:
            const pw.EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 10),
        child: pw.Row(children: [
          pw.Expanded(
              child: pw.Text(title,
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold))),
          pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [pw.Text(_frota), pw.Text(_contrato)])
        ]));
  }

  _subtitle({required String subtitle}) {
    return pw.Container(
        decoration: pw.BoxDecoration(
            color: PdfColors.grey400,
            border: pw.Border.all(width: 1, color: PdfColors.grey400)),
        padding: const pw.EdgeInsets.only(left: 20),
        child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
          pw.Expanded(
              child: pw.Text(subtitle,
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold))),
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
    const PdfColor colorBorderTitle = PdfColors.grey400;
    return pw.Container(
        decoration: pw.BoxDecoration(
            color: PdfColors.grey600,
            border: pw.Border.all(width: 1, color: PdfColors.grey600)),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Container(
                width: 60,
                height: 40,
                alignment: pw.Alignment.center,
                decoration: const pw.BoxDecoration(
                    border: pw.Border(
                        right: pw.BorderSide(
                            width: 0.5, color: colorBorderTitle))),
                child: pw.Text('DATA',
                    textAlign: pw.TextAlign.center,
                    style: const pw.TextStyle(fontSize: 10))),
            pw.Container(
                width: 80,
                height: 40,
                alignment: pw.Alignment.center,
                decoration: const pw.BoxDecoration(
                    border: pw.Border(
                        right: pw.BorderSide(
                            width: 0.5, color: colorBorderTitle))),
                child: pw.Text('SETOR/OS',
                    textAlign: pw.TextAlign.center,
                    style: const pw.TextStyle(fontSize: 10))),
            pw.Container(
                width: 160,
                height: 40,
                decoration: const pw.BoxDecoration(
                    border: pw.Border(
                        right: pw.BorderSide(
                            width: 0.5, color: colorBorderTitle))),
                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text('ITINERÁRIO',
                          style: const pw.TextStyle(fontSize: 10)),
                      pw.Row(children: [
                        pw.Container(
                            width: 80,
                            padding: const pw.EdgeInsets.symmetric(vertical: 5),
                            child: pw.Text('DE',
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 8))),
                        pw.Container(
                            width: 80,
                            padding: const pw.EdgeInsets.symmetric(vertical: 5),
                            child: pw.Text('PARA',
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 8)))
                      ])
                    ])),
            pw.Container(
                width: 100,
                height: 40,
                decoration: const pw.BoxDecoration(
                    border: pw.Border(
                        right: pw.BorderSide(
                            width: 0.5, color: colorBorderTitle))),
                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text('SAÍDA',
                          textAlign: pw.TextAlign.center,
                          style: const pw.TextStyle(fontSize: 10)),
                      pw.Row(children: [
                        pw.Container(
                            width: 50,
                            padding: const pw.EdgeInsets.symmetric(vertical: 5),
                            child: pw.Text('HORÁRIO',
                                style: const pw.TextStyle(fontSize: 8),
                                textAlign: pw.TextAlign.center)),
                        pw.Container(
                            width: 50,
                            padding: const pw.EdgeInsets.symmetric(vertical: 5),
                            child: pw.Text('KM',
                                style: const pw.TextStyle(fontSize: 8),
                                textAlign: pw.TextAlign.center))
                      ])
                    ])),
            pw.Container(
                width: 100,
                height: 40,
                decoration: const pw.BoxDecoration(
                    border: pw.Border(
                        right: pw.BorderSide(
                            width: 0.5, color: colorBorderTitle))),
                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text('CHEGADA',
                          textAlign: pw.TextAlign.center,
                          style: const pw.TextStyle(fontSize: 10)),
                      pw.Row(children: [
                        pw.Container(
                            width: 50,
                            padding: const pw.EdgeInsets.symmetric(vertical: 5),
                            child: pw.Text('HORÁRIO',
                                style: const pw.TextStyle(fontSize: 8),
                                textAlign: pw.TextAlign.center)),
                        pw.Container(
                            width: 50,
                            padding: const pw.EdgeInsets.symmetric(vertical: 5),
                            child: pw.Text('KM',
                                style: const pw.TextStyle(fontSize: 8),
                                textAlign: pw.TextAlign.center))
                      ])
                    ])),
            pw.Container(
                width: 120,
                height: 40,
                decoration: const pw.BoxDecoration(
                    border: pw.Border(
                        right: pw.BorderSide(
                            width: 0.5, color: colorBorderTitle))),
                child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text('LITROS',
                          style: const pw.TextStyle(fontSize: 10)),
                      pw.Row(children: [
                        pw.Container(
                            width: 60,
                            padding: const pw.EdgeInsets.symmetric(vertical: 5),
                            child: pw.Text('PRIME',
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 8))),
                        pw.Container(
                            width: 60,
                            padding: const pw.EdgeInsets.symmetric(vertical: 5),
                            child: pw.Text('OUTROS',
                                textAlign: pw.TextAlign.center,
                                style: const pw.TextStyle(fontSize: 8)))
                      ])
                    ])),
            pw.Container(
                width: 30,
                height: 40,
                alignment: pw.Alignment.center,
                decoration: const pw.BoxDecoration(
                    border: pw.Border(
                        right: pw.BorderSide(
                            width: 0.5, color: colorBorderTitle))),
                child: pw.Container(
                    width: 40,
                    child: pw.Text('*', textAlign: pw.TextAlign.center))),
            pw.Container(
                width: 94,
                height: 40,
                alignment: pw.Alignment.center,
                decoration: const pw.BoxDecoration(
                    border: pw.Border(
                        right: pw.BorderSide(
                            width: 0.5, color: colorBorderTitle))),
                child: pw.Container(
                    width: 80,
                    child: pw.Text('NOME',
                        textAlign: pw.TextAlign.center,
                        style: const pw.TextStyle(fontSize: 10)))),
            pw.Container(
                width: 60,
                child: pw.Container(
                    width: 60,
                    child: pw.Text('QTDE PEDÁGIO',
                        textAlign: pw.TextAlign.center,
                        style: const pw.TextStyle(fontSize: 10))))
          ],
        ));
  }

  _createData() {
    List<pw.Widget> list = List.empty(growable: true);
    for (var data in _viagens) {
      list.add(pw.Container(
        child: _rowData(data),
      ));
    }
    if (list.length < 20) {
      for (int i = list.length; i < 20; i++) {
        list.add(pw.Container(child: _rowData(null)));
      }
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
        child: pw.Text(data,
            textAlign: pw.TextAlign.center,
            maxLines: 1,
            overflow: pw.TextOverflow.clip));
  }

  _rowData(PDFData? data) {
    return pw.Row(children: [
      _box(
          data: (data == null) ? '' : DateFormat('dd/MM').format(data.data),
          width: 60),
      _box(data: (data == null) ? '' : data.setor, width: 80),
      _box(data: (data == null) ? '' : data.de, width: 80),
      _box(data: (data == null) ? '' : data.para, width: 80),
      _box(
          data: (data == null)
              ? ''
              : DateFormat('HH:mm').format(data.horarioSaida),
          width: 50),
      _box(
          data: (data == null) ? '' : data.quilometrageSaida.toString(),
          width: 50),
      _box(
          data: (data == null)
              ? ''
              : DateFormat('HH:mm').format(data.horarioChegada),
          width: 50),
      _box(
          data: (data == null) ? '' : data.quilometragemChegada.toString(),
          width: 50),
      _box(
          data: (data == null)
              ? ''
              : (data.prime > 0)
                  ? data.prime.toString()
                  : ' ',
          width: 60),
      _box(
          data: (data == null)
              ? ''
              : (data.outros > 0)
                  ? data.outros.toString()
                  : ' ',
          width: 60),
      _box(
          data: (data == null)
              ? ''
              : (data.tipo > 0)
                  ? data.tipo.toString()
                  : ' ',
          width: 30),
      _box(data: (data == null) ? '' : data.nome, width: 94),
      _box(
          data: (data == null)
              ? ''
              : (data.pedagio > 0)
                  ? data.pedagio.toString()
                  : ' ',
          width: 58),
    ]);
  }
}
