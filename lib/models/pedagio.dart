class Pedagio {
  int id;
  int viagem;
  double valor;
  DateTime horario;
  String local;
  int status;

  static const int ativo = 0;
  static const int inativo = 1;

  Pedagio(
      {this.id = 0,
      required this.viagem,
      required this.valor,
      required this.horario,
      required this.local,
      this.status = Pedagio.ativo});
}
