import 'package:celecar_web/database/database.dart';
import 'package:celecar_web/models/periodos.dart';
import 'package:celecar_web/models/setor.dart';
import 'package:celecar_web/models/veiculo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RelatoriosPage extends StatefulWidget {
  const RelatoriosPage({Key? key}) : super(key: key);

  @override
  State<RelatoriosPage> createState() => _RelatoriosPageState();
}

class _RelatoriosPageState extends State<RelatoriosPage> {
  late PeriodosItem _periodoSelected;
  late List<PeriodosItem> _periodos;
  final List<Veiculo> _veiculos = List.empty(growable: true);
  final List<Setor> _setores = List.empty(growable: true);
  late Setor _setorSelected;
  late Veiculo _veiculoSelected;
  final Database _database = Database();
  bool _loading = true;

  _RelatoriosPageState() {
    _loadData();
    _periodos =
        Periodos.generate(inicio: DateTime(2020, 1), fim: DateTime.now())
            .periodos;
    _periodoSelected = _periodos.first;
  }

  _loadData() async {
    await _database.getVeiculos().then((veiculos) {
      _veiculos.addAll(veiculos);
      _veiculoSelected = _veiculos.first;
    });

    await _database.getSetores().then((setores) {
      _setores.addAll(setores);
      _setores.insert(
          0,
          Setor(
              id: Setor.todos,
              nome: 'Todos',
              endereco: '',
              status: Setor.ativo));
      _setorSelected = _setores.first;
    });

    setState(() {
      _loading = false;
    });
  }

  _updateVeiculos() async {
    await _database.getVeiculos(setor: _setorSelected.id).then((veiculos) {
      _veiculos.clear();
      _veiculos.addAll(veiculos);
      _veiculoSelected = _veiculos.first;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return (_loading)
        ? const Center(child: CircularProgressIndicator())
        : Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    child: Row(
                      children: [
                        const Expanded(
                            child: Text('Setores', textAlign: TextAlign.start)),
                        DropdownButton<Setor>(
                            isDense: true,
                            alignment: Alignment.centerRight,
                            onChanged: ((value) {
                              _setorSelected = value!;
                              _updateVeiculos();
                            }),
                            focusColor: Colors.transparent,
                            value: _setorSelected, // _setorSelected,
                            underline: const Divider(
                                color: Colors.transparent, height: 0),
                            items:
                                _setores.map<DropdownMenuItem<Setor>>((value) {
                              return DropdownMenuItem<Setor>(
                                  child: Text(value.toString()), value: value);
                            }).toList())
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    child: Row(
                      children: [
                        const Expanded(
                            child: Text('Veículo', textAlign: TextAlign.start)),
                        DropdownButton<Veiculo>(
                            isDense: true,
                            alignment: Alignment.centerRight,
                            onChanged: ((value) {
                              setState(() {
                                _veiculoSelected = value!;
                              });
                            }),
                            focusColor: Colors.transparent,
                            value: _veiculoSelected, // _setorSelected,
                            underline: const Divider(
                                color: Colors.transparent, height: 0),
                            items: _veiculos
                                .map<DropdownMenuItem<Veiculo>>((value) {
                              return DropdownMenuItem<Veiculo>(
                                  child: Text(value.toString()), value: value);
                            }).toList())
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    child: Row(
                      children: [
                        const Expanded(
                            child: Text('Período', textAlign: TextAlign.start)),
                        DropdownButton<PeriodosItem>(
                            isDense: true,
                            alignment: Alignment.centerRight,
                            onChanged: ((value) {
                              setState(() {
                                _periodoSelected = value!;
                              });
                            }),
                            focusColor: Colors.transparent,
                            value: _periodoSelected, // _setorSelected,
                            underline: const Divider(
                                color: Colors.transparent, height: 0),
                            items: _periodos
                                .map<DropdownMenuItem<PeriodosItem>>((value) {
                              return DropdownMenuItem<PeriodosItem>(
                                  child: Text(value.toString()), value: value);
                            }).toList())
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ElevatedButton(
                      onPressed: () {},
                      child:
                          Row(mainAxisSize: MainAxisSize.min, children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10),
                          child: Text('Gerar PDF'),
                        ),
                        FaIcon(FontAwesomeIcons.print),
                      ]),
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(10),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 50)),
                          alignment: Alignment.centerRight)),
                ),
              ],
            ),
          );
  }
}
