import 'package:celecar_web/models/usuario.dart';
import 'package:celecar_web/models/veiculo.dart';
import 'package:celecar_web/pdfs/pdfdata.dart';
import 'package:intl/intl.dart';
import 'package:supabase/supabase.dart';

class DBViagens {
  final SupabaseClient _client;
  final String _table = 'viagens';

  DBViagens(this._client);

  Future<List<PDFData>> getViagens(int setor, int veiculo, int usuario,
      DateTime dataInicio, DateTime dataFim) async {
    List<PDFData> list = List.empty(growable: true);
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    const String _query =
        'horarioInicio, localInicio, localDestino, horarioFim, quilometragemInicio, quilometragemFim, setor, usuario: usuarios(nome), veiculo: veiculos(modelo,placa)';
    PostgrestResponse response;

    //print('Setor: $setor | Veiculo: $veiculo | Usuário: $usuario | Data início: $dataInicio | Data fim: $dataFim');

    // setor: todos | veiculo: todos | usuario: todos
    //if (setor == Setor.todos) {
    if (veiculo == Veiculo.todos) {
      if (usuario == Usuario.todos) {
        response = await _client
            .from(_table)
            .select(_query)
            .gte('horarioInicio', dateFormat.format(dataInicio))
            .lte('horarioInicio', dateFormat.format(dataFim))
            .execute();
      } else {
        response = await _client
            .from(_table)
            .select(_query)
            .eq('usuario', usuario)
            .gte('horarioInicio', dateFormat.format(dataInicio))
            .lte('horarioInicio', dateFormat.format(dataFim))
            .execute();
      }
    } else {
      // veiculo especifico | usuario: todos
      if (usuario == Usuario.todos) {
        response = await _client
            .from(_table)
            .select(_query)
            .eq('veiculo', veiculo)
            .gte('horarioInicio', dateFormat.format(dataInicio))
            .lte('horarioInicio', dateFormat.format(dataFim))
            .execute();
      } else {
        // veiculo e usuario especificos
        response = await _client
            .from(_table)
            .select(_query)
            .eq('veiculo', veiculo)
            .eq('usuario', usuario)
            .gte('horarioInicio', dateFormat.format(dataInicio))
            .lte('horarioInicio', dateFormat.format(dataFim))
            .execute();
      }
    }
    // } else {
    //   // setor: especifico
    //   if (veiculo == Veiculo.todos) {
    //     if (usuario == Usuario.todos) {
    //       response = await _client
    //           .from(_table)
    //           .select(_query)
    //           .eq('setor', setor)
    //           .gte('horarioInicio', dateFormat.format(dataInicio))
    //           .lte('horarioInicio', dateFormat.format(dataFim))
    //           .execute();
    //     } else {
    //       response = await _client
    //           .from(_table)
    //           .select(_query)
    //           .eq('setor', setor)
    //           .eq('usuario', usuario)
    //           .gte('horarioInicio', dateFormat.format(dataInicio))
    //           .lte('horarioInicio', dateFormat.format(dataFim))
    //           .execute();
    //     }
    //   } else {
    //     // setor e veiculo especifico
    //     if (usuario == Usuario.todos) {
    //       response = await _client
    //           .from(_table)
    //           .select(_query)
    //           .eq('setor', setor)
    //           .eq('veiculo', veiculo)
    //           .gte('horarioInicio', dateFormat.format(dataInicio))
    //           .lte('horarioInicio', dateFormat.format(dataFim))
    //           .execute();
    //     } else {
    //       response = await _client
    //           .from(_table)
    //           .select(_query)
    //           .eq('setor', setor)
    //           .eq('veiculo', veiculo)
    //           .eq('usuario', usuario)
    //           .gte('horarioInicio', dateFormat.format(dataInicio))
    //           .lte('horarioInicio', dateFormat.format(dataFim))
    //           .execute();

    //       print('response: ${response.data}');
    //     }
    //   }

    if (!response.hasError && (response.data as List).isNotEmpty) {
      for (var data in response.data) {
        list.add(_fromJson(data));
      }
    }
    return list;
  }

  PDFData _fromJson(Map<String, dynamic> json) {
    String veiculo = json['veiculo']['modelo'] + ' ' + json['veiculo']['placa'];
    return PDFData(
        data: DateTime.parse(json['horarioInicio']),
        setor: json['setor'],
        de: json['localInicio'],
        para: json['localDestino'],
        horarioSaida: DateTime.parse(json['horarioInicio']),
        quilometrageSaida: json['quilometragemInicio'],
        horarioChegada: DateTime.parse(json['horarioFim']),
        quilometragemChegada: json['quilometragemFim'],
        nome: json['usuario']['nome'],
        veiculo: veiculo);
  }
}
