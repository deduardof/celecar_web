class Viagem {
  int id = 0;
  int usuario;
  String usuarioNome;
  int veiculo;
  String veiculoDescricao;
  DateTime horarioInicio;
  int quilometragemInicio;
  String localInicio;
  String localDestino;
  String setor;
  DateTime horarioFim;
  String localFim;
  int quilometragemFim;
  int numPedagios;
  double totalPedagios;
  int tipoCombustivel;
  double totalCombustivel;
  int usuarioFinalizou;
  int status;

  static const int ativa = 0;
  static const int encerrada = 1;
  static const int encerradaporoutrousuario = 2;
  static const int inativa = 3;

  Viagem(
    {this.id = 0,
      required this.usuario,
      required this.usuarioNome,
      required this.veiculo,
      this.veiculoDescricao = '',
      required this.horarioInicio,
      required this.quilometragemInicio,
      required this.localInicio,
      required this.localDestino,
      this.setor = '',
      required this.horarioFim,
      this.localFim = '',
      this.quilometragemFim = 0,
      this.numPedagios = 0,
      this.totalPedagios = 0,
      this.tipoCombustivel = 0,
      this.totalCombustivel = 0,
      this.usuarioFinalizou = 0,
      required this.status});
}
