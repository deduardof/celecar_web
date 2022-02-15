class Abastecimento {
  int id;
  int viagem;
  DateTime horario;
  int quilometragem;
  double valor;
  double quantidade;
  int combustivel;
  double total;
  int status;

  static const int ativo = 0;
  static const int inativo = 1;

  Abastecimento(
      {this.id = 0,
      required this.viagem,
      required this.horario,
      required this.quilometragem,
      required this.valor,
      required this.quantidade,
      this.combustivel = 0,
      required this.total,
      this.status = Abastecimento.ativo});
}

enum Combustiveis { gasolina, etanol, diesel }
