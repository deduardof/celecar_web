import 'package:celecar_web/models/setor.dart';
import 'package:celecar_web/models/usuario.dart';
import 'package:supabase/supabase.dart';

class DBUsuarios {
  final SupabaseClient _client;
  final String _table = 'usuarios';

  DBUsuarios(this._client);

  Future<Usuario?> logar(String usuario, String senha) async {
    final response = await _client
        .from(_table)
        .select('''*, setorNome: setores(nome)''')
        .eq('email', usuario)
        .eq('senha', senha)
        .limit(1)
        .execute(count: CountOption.exact);

    if (!response.hasError && response.count == 1) {
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

  Future<List<Usuario>> getUsuarios(
      {int setor = Setor.todos, int status = Usuario.ativo}) async {
    final List<Usuario> usuarios = List.empty(growable: true);
    PostgrestResponse response;

    if (setor == Setor.todos) {
      response = await _client
          .from(_table)
          .select('''*, setorNome: setores(nome)''')
          .eq('status', status)
          .execute();
    } else {
      response = await _client
          .from(_table)
          .select('''*, setorNome: setores(nome)''')
          .eq('setor', setor)
          .eq('status', status)
          .execute();
    }

    if (!response.hasError && (response.data as List).isNotEmpty) {
      for (var usuario in response.data) {
        usuarios.add(_fromJson(usuario));
      }
    }
    return usuarios;
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
