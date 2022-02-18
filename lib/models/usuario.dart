class Usuario {
  int id;
  int matricula;
  String email;
  String nome;
  int setor;
  String setorNome;
  DateTime loggedIn;

  static const int todos = -1;
  static const int ativo = 0;
  static const int inativo = 1;

  Usuario(
      {required this.id,
      required this.matricula,
      required this.email,
      required this.nome,
      required this.setor,
      this.setorNome = '',
      required this.loggedIn});

  @override
  String toString() {
    return nome;
  }
}
