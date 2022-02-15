import 'package:celecar_web/models/veiculo.dart';
import 'package:supabase/supabase.dart';

class DBVeiculos {
  final SupabaseClient _client;
  final String _table = 'veiculos';

  DBVeiculos(this._client);

  Future<List<Veiculo>> getVeiculos(int setor) async {
    List<Veiculo> veiculos = List.empty(growable: true);

    final response =
        await _client.from(_table).select().eq('setor', setor).execute();

    if (!response.hasError) {
      for (var veiculo in response.data) {
        veiculos.add(_fromJson(veiculo));
      }
    }
    return veiculos;
  }

  Veiculo _fromJson(Map<String, dynamic> json) {
    return Veiculo(
        id: json['id'],
        marca: json['marca'],
        modelo: json['modelo'],
        placa: json['placa'],
        ano: json['ano'],
        cor: json['cor'],
        quilometragem: json['quilometragem'],
        local: json['local'],
        status: json['status'],
        setor: json['setor']);
  }
}
