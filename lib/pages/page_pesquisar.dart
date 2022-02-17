import 'package:celecar_web/database/database.dart';
import 'package:celecar_web/models/setor.dart';
import 'package:celecar_web/models/usuario.dart';
import 'package:celecar_web/models/veiculo.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class PesquisarPage extends StatefulWidget {
  const PesquisarPage({Key? key}) : super(key: key);

  @override
  State<PesquisarPage> createState() => _PesquisarPageState();
}

class _PesquisarPageState extends State<PesquisarPage> {
  final List<String> veiculos = ['HB20S 0X00', 'HB20S 0X01', 'HB20S 0X02'];
  String dropdownValue = 'HB20S 0X00';
  List<Setor> _setores = List.empty(growable: true);
  List<Veiculo> _veiculos = List.empty(growable: true);
  List<Usuario> _usuarios = List.empty(growable: true);
  late Setor _setorSelected;
  late Veiculo _veiculoSelected;
  late Usuario _usuarioSelected;
  DateTime _initialDate = DateTime.now().subtract(Duration(days: 30));
  DateTime _finalDate = DateTime.now();
  final TextEditingController _initialDateController = TextEditingController();
  final TextEditingController _finalDateController = TextEditingController();

  final Database _database = Database();
  bool _loading = true;

  @override
  initState() {
    _loadInitial().whenComplete(() => setState(() {
          _loading = false;
        }));
    _initialDateController.text = DateFormat('dd/MM/yyyy').format(_initialDate);
    _finalDateController.text = DateFormat('dd/MM/yyyy').format(_finalDate);
    super.initState();
  }

  Future _loadInitial() async {
    await _database.getSetores(status: Setor.ativo).then((list) {
      _setores = list;
      _setorSelected = _setores.first;
    });
    await _database.getVeiculos().then((list) {
      _veiculos = list;
      _veiculoSelected = _veiculos.first;
    });
    await _database.getUsuarios().then((list) {
      _usuarios = list;
      _usuarioSelected = _usuarios.first;
    });
  }

  Widget _label(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _item(List<Object> itens, dynamic value, Function(dynamic) function,
      {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: DropdownButton<dynamic>(
              isDense: true,
              isExpanded: true,
              focusColor: Colors.transparent,
              value: value, // _setorSelected,
              underline: const Divider(color: Colors.transparent, height: 0),
              elevation: 0,
              items: itens.map<DropdownMenuItem>((value) {
                return DropdownMenuItem(
                    child: Text(
                      value.toString(),
                      maxLines: 1,
                      style: const TextStyle(overflow: TextOverflow.ellipsis),
                    ),
                    value: value);
              }).toList(),
              onChanged: (dynamic newValue) {
                setState(() {
                  function(newValue);
                });
              }),
        ),
      ),
    );
  }

  Widget _firstLine() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          _item(_setores, _setorSelected, (value) => _setorSelected = value),
          _item(
              _veiculos, _veiculoSelected, (value) => _veiculoSelected = value),
          _item(
              _usuarios, _usuarioSelected, (value) => _usuarioSelected = value,
              flex: 2),
        ],
      ),
    );
  }

  _showDatePicker(bool initial) {
    final today = DateTime.now();
    showDatePicker(
            context: context,
            initialDate: today,
            firstDate: today.subtract(const Duration(days: 1000)),
            lastDate: today)
        .then((date) {
      setState(() {
        if (date != null) {
          if (initial && _initialDate != date) {
            _initialDate = date;
            _initialDateController.text =
                DateFormat("dd/MM/yyyy").format(_initialDate);
          } else {
            if (!initial && _finalDate != date && _initialDate.isBefore(date)) {
              _finalDate = date;
              _finalDateController.text =
                  DateFormat("dd/MM/yyyy").format(_finalDate);
            }
          }
        }
      });
    });
  }

  Widget _secondLine() {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                  onTap: () {
                    _showDatePicker(true);
                  },
                  controller: _initialDateController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: FaIcon(FontAwesomeIcons.calendar),
                      ),
                      contentPadding: EdgeInsets.all(10))),
            )),
        Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextField(
                  onTap: () {
                    _showDatePicker(false);
                  },
                  controller: _finalDateController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: FaIcon(FontAwesomeIcons.calendar),
                      ),
                      contentPadding: EdgeInsets.all(10))),
            )),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ElevatedButton(
                onPressed: () {},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        'Pesquisar',
                        textAlign: TextAlign.center,
                      ),
                    )),
                    FaIcon(FontAwesomeIcons.search)
                  ],
                )),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Column(
        children: [
          Card(
            elevation: 10,
            margin: const EdgeInsets.only(top: 10.0, right: 10.0, bottom: 10.0),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Expanded(child: _label('Setor')),
                    Expanded(child: _label('Veículo')),
                    Expanded(child: _label('Usuário'), flex: 2),
                  ]),
                  _firstLine(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(child: _label('Período inicial'), flex: 2),
                          Expanded(child: _label('Período final'), flex: 2),
                          const Spacer()
                        ]),
                  ),
                  _secondLine()
                ],
              ),
            ),
          ),
        ],
      );
    }
  }
}
