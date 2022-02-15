import 'package:celecar_web/database/db_usuario.dart';
import 'package:celecar_web/database/db_veiculos.dart';
import 'package:celecar_web/database/db_viagens.dart';
import 'package:celecar_web/database/sessao.dart';
import 'package:celecar_web/models/usuario.dart';
import 'package:celecar_web/models/veiculo.dart';
import 'package:celecar_web/pdfs/pdfdata.dart';
import 'package:celecar_web/repositories/repo_supabase.dart';
import 'package:supabase/supabase.dart';

class Database {
  late SupabaseClient _client;

  Database() {
    _client = RepoSupabase().getClient();
  }

  Future<Usuario?> logar(
      {required String usuario, required String senha}) async {
    Usuario? user = await DBUsuario(_client).logar(usuario, senha);
    if (user != null) {
      Sessao().save(user);
    }
    return user;
  }

  Future<bool> deslogar() async => await Sessao().remove();

  Future<Usuario?> verificaSessao() async {
    Usuario? usuario = await Sessao().load();
    if (usuario != null) {
      DBUsuario(_client).registraLogin(usuario.id);
    }
    return usuario;
  }

  Future<List<Veiculo>> getVeiculos(int setor) async =>
      await DBVeiculos(_client).getVeiculos(setor);

  Future<List<PDFData>> getViagens(
          int veiculo, DateTime dataInicio, DateTime dataFim) async =>
      await DBViagens(_client).getViagens(veiculo, dataInicio, dataFim);
}
