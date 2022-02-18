class PDFData {
  String veiculo;
  DateTime data;
  String setor;
  String de;
  String para;
  DateTime horarioSaida;
  int quilometrageSaida;
  DateTime horarioChegada;
  int quilometragemChegada;
  double prime;
  double outros;
  int tipo;
  String nome;
  int pedagio;

  PDFData(
      {required this.veiculo,
      required this.data,
      required this.setor,
      required this.de,
      required this.para,
      required this.horarioSaida,
      required this.quilometrageSaida,
      required this.horarioChegada,
      required this.quilometragemChegada,
      this.prime = 0,
      this.outros = 0,
      this.tipo = 0,
      required this.nome,
      this.pedagio = 0});
}
