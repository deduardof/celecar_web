import 'package:celecar_web/database/db_setores.dart';
import 'package:celecar_web/database/db_usuarios.dart';
import 'package:celecar_web/database/db_veiculos.dart';
import 'package:celecar_web/database/db_viagens.dart';
import 'package:celecar_web/database/sessao.dart';
import 'package:celecar_web/models/setor.dart';
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
    Usuario? user = await DBUsuarios(_client).logar(usuario, senha);
    if (user != null) {
      Sessao().save(user);
    }
    return user;
  }

  Future<bool> deslogar() async => await Sessao().remove();

  Future<Usuario?> verificaSessao() async {
    Usuario? usuario = await Sessao().load();
    if (usuario != null) {
      DBUsuarios(_client).registraLogin(usuario.id);
    }
    return usuario;
  }

  Future<List<Setor>> getSetores({int status = Setor.todos}) async {
    return DBSetores(_client).getSetores(status);
  }

  Future<List<Usuario>> getUsuarios(
      {int setor = Setor.todos, int status = Usuario.ativo}) async {
    return DBUsuarios(_client).getUsuarios(setor: setor, status: status);
  }

  Future<List<Veiculo>> getVeiculos({int setor = Setor.todos}) async =>
      await DBVeiculos(_client).getVeiculos(setor);

  Future<List<PDFData>> getViagens(
          {int setor = Setor.todos,
          int veiculo = Veiculo.todos,
          int usuario = Usuario.todos,
          required DateTime dataInicio,
          required DateTime dataFim}) async =>
      await DBViagens(_client)
          .getViagens(setor, veiculo, usuario, dataInicio, dataFim);
}
