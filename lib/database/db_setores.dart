import 'package:celecar_web/models/setor.dart';
import 'package:supabase/supabase.dart';

class DBSetores {
  final SupabaseClient _client;
  final String _table = 'setores_com_veiculos';

  DBSetores(this._client);

  Future<List<Setor>> getSetores(int status) async {
    List<Setor> setores = List.empty(growable: true);
    PostgrestResponse response;
    if (status == Setor.todos) {
      response = await _client.from(_table).select().execute();
    } else {
      response =
          await _client.from(_table).select().eq('status', status).execute();
    }

    if (!response.hasError && (response.data as List).isNotEmpty) {
      for (var setor in (response.data as List)) {
        setores.add(_fromJson(setor));
      }
    }
    return setores;
  }

  Setor _fromJson(Map<String, dynamic> json) {
    return Setor(
        id: json['id'],
        nome: json['nome'],
        endereco: json['endereco'],
        veiculos: json['veiculos'] ?? 0,
        status: json['status']);
  }
}
