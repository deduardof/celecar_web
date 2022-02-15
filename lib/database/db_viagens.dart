import 'package:celecar_web/pdfs/pdfdata.dart';
import 'package:intl/intl.dart';
import 'package:supabase/supabase.dart';

class DBViagens {
  final SupabaseClient _client;
  final String _table = 'viagens';

  DBViagens(this._client);

  Future<List<PDFData>> getViagens(
      int veiculo, DateTime dataInicio, DateTime dataFim) async {
    List<PDFData> list = List.empty(growable: true);
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

    final response = await _client
        .from(_table)
        .select('''*, matricula: usuarios(matricula)''')
        .gte('horarioInicio', dateFormat.format(dataInicio))
        .lte('horarioInicio', dateFormat.format(dataFim))
        .execute();

    if (!response.hasError) {}

    return list;
  }

  PDFData _fromJson(Map<String, dynamic> json) {
    return PDFData(
        data: DateTime.parse(json['horarioInicio']),
        setor: json['setor'],
        de: json['localInicio'],
        para: json['localDestino'],
        horarioSaida: DateTime.parse(json['horarioInicio']),
        quilometrageSaida: json['quilometragemInicio'],
        horarioChegada: DateTime.parse(json['horarioFim']),
        quilometragemChegada: json['quilometragemFim'],
        nome: json['matricula']['matricula']);
  }
}
