import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal({Key? key}) : super(key: key);

  _button(String label, IconData icon, Function() onClick) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              return (states.contains(MaterialState.hovered))
                  ? Colors.purple
                  : null;
            }),
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 20, horizontal: 10))),
        onPressed: onClick,
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
          constraints: const BoxConstraints(minWidth: 200, maxWidth: 300),
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _button('Home', FontAwesomeIcons.home, () => null),
              _button('Pesquisar', FontAwesomeIcons.search, () => null),
              _button('Relatórios', FontAwesomeIcons.print, () => null),
              _button('Gerenciar', FontAwesomeIcons.userCog, () => null),
            ],
          )),
    );
  }
}
