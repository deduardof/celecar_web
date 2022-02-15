class Veiculo {
  int id;
  String marca;
  String modelo;
  int ano;
  String placa;
  String cor;
  int quilometragem;
  int setor;
  String local;
  int status;

  static const int disponivel = 0;
  static const int emuso = 1;
  static const int manutencao = 2;

  Veiculo(
      {required this.id,
      required this.marca,
      required this.modelo,
      required this.ano,
      required this.placa,
      required this.cor,
      required this.quilometragem,
      required this.setor,
      this.local = '',
      this.status = 0});

  String getDescricao() {
    return '$modelo $placa';
  }

  String getStatus() {
    switch (status) {
      case disponivel:
        return 'Disponível';
      case emuso:
        return 'Em uso';
      case manutencao:
        return 'Manutenção';
    }
    return '';
  }
}
