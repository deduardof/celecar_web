import 'package:celecar_web/models/usuario.dart';
import 'package:supabase/supabase.dart';

class DBUsuario {
  final SupabaseClient _client;
  final String _table = 'usuarios';

  DBUsuario(this._client);

  Future<Usuario?> logar(String usuario, String senha) async {
    final response = await _client
        .from(_table)
        .select('''*, setorNome: setores(nome)''')
        .eq('email', usuario)
        .eq('senha', senha)
        .limit(1)
        .execute(count: CountOption.exact);

    if (!response.hasError && response.count == 1) {
      print(response.data);
      return _fromJson(response.data[0]);
    }
    return null;
  }

  Future<bool> registraLogin(int usuario) async {
    final response = await _client
        .from(_table)
        .update({'loggedIn': DateTime.now()})
        .eq('id', usuario)
        .limit(1)
        .execute(count: CountOption.exact);

    return (!response.hasError && response.count == 1);
  }

  Usuario _fromJson(Map<String, dynamic> json) {
    return Usuario(
        id: json['id'],
        matricula: json['matricula'],
        email: json['email'],
        nome: json['nome'],
        setor: json['setor'],
        setorNome: json['setorNome']['nome'],
        loggedIn: DateTime.parse(json['loggedIn']));
  }
}
