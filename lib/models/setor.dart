class Setor {
  int id;
  String nome;
  String endereco;
  int veiculos;
  int status;

  static const int todos = -1;
  static const int ativo = 0;
  static const int inativo = 1;

  Setor(
      {required this.id,
      required this.nome,
      required this.endereco,
      this.veiculos = 0,
      required this.status});

  @override
  String toString() {
    return nome;
  }
}
