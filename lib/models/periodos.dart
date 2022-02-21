class PeriodosItem {
  String nome;
  DateTime datetime;

  PeriodosItem({required this.nome, required this.datetime});

  @override
  String toString() {
    return nome;
  }
}

class Periodos {
  List<PeriodosItem> periodos = List.empty(growable: true);

  final List _months = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro'
  ];

  Periodos.generate({required DateTime inicio, required DateTime fim}) {
    int month = fim.month;

    for (int y = fim.year; y > inicio.year; y--) {
      for (int m = month; m > 0; m--) {
        periodos.add(PeriodosItem(
            nome: _months.elementAt(m - 1) + '/' + y.toString(),
            datetime: DateTime(y, m)));
      }
      month = 12;
    }
  }

  get() => periodos;
}
