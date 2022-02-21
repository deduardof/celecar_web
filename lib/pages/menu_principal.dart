import 'package:celecar_web/models/menu_principal_item.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuPrincipal extends StatelessWidget {
  final List<MenuPrincipalItem> menu;
  const MenuPrincipal({Key? key, required this.menu}) : super(key: key);

  List<Widget> _buildMenu() {
    List<Widget> listMenu = List.empty(growable: true);
    for (var item in menu) {
      listMenu.add(_button(item.texto, item.icone, item.onPressed));
    }
    return listMenu;
  }

  _button(String label, IconData icon, Function() onPressed) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 5, right: 0, bottom: 5),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              return (states.contains(MaterialState.hovered))
                  ? Colors.purple
                  : null;
            }),
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 20, horizontal: 10))),
        onPressed: onPressed,
        child: Row(
          children: [
            Expanded(
                child: Text(
              label,
              textAlign: TextAlign.center,
            )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: FaIcon(icon),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          padding: const EdgeInsets.only(top: 8),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: _buildMenu())),
    );
  }
}
