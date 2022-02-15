import 'package:celecar_web/models/usuario.dart';
import 'package:hive/hive.dart';

class Sessao {
  final String _boxname = 'sessao';

  Future<Box> _openBox() async => (Hive.isBoxOpen(_boxname))
      ? Hive.box(_boxname)
      : await Hive.openBox(_boxname);

  Future<Usuario?> load() async {
    Box sessao = await _openBox();
    if (sessao.get('id') > 0) {
      Usuario usuario = Usuario(
          id: sessao.get('id', defaultValue: 0),
          matricula: sessao.get('matricula', defaultValue: 0),
          email: sessao.get('email', defaultValue: ''),
          nome: sessao.get('nome', defaultValue: ''),
          setor: sessao.get('setor', defaultValue: 0),
          setorNome: sessao.get('setorNome', defaultValue: ''),
          loggedIn: sessao.get('loggedIn', defaultValue: DateTime(2020, 1, 1)));
      print('[Sessao] Sessão carregada com sucesso.');
      return usuario;
    }
  }

  Future save(Usuario usuario) async {
    await _openBox().then((sessao) {
      sessao.put('id', usuario.id);
      sessao.put('matricula', usuario.matricula);
      sessao.put('nome', usuario.nome);
      sessao.put('email', usuario.email);
      sessao.put('setor', usuario.setor);
      sessao.put('setorNome', usuario.setorNome);
      sessao.put('loggedIn', usuario.loggedIn);
      //sessao.close();
      print('[Sessao] Sessão salva com sucesso.');
    });
  }

  Future<bool> remove() async {
    return (await _openBox().then((sessao) => sessao.clear()) > 0);
  }
}
