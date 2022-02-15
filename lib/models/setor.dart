class Setor {
  int id;
  String nome;
  String endereco;
  int veiculos;
  int status;

  Setor({
    required this.id,
    required this.nome,
    required this.endereco,
    this.veiculos = 0,
    required this.status});
}
