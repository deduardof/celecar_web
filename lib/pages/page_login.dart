import 'dart:convert';

import 'package:celecar_web/database/database.dart';
import 'package:celecar_web/pages/page_home.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _controllerUsuario = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();

  _logar(BuildContext context) async {
    String user =
        _controllerUsuario.text.trim().toLowerCase() + '@celepar.pr.gov.br';
    String pass =
        sha256.convert(utf8.encode(_controllerSenha.text.trim())).toString();
    await Database().logar(usuario: user, senha: pass).then((usuario) {
      if (usuario != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage(usuario: usuario)),
            (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Gestão de Veículos'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey.withAlpha(100),
        child: Center(
          child: Material(
            elevation: 10.0,
            shadowColor: Colors.blueGrey,
            child: Container(
                width: 600,
                height: 320,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.blueGrey.shade800,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: FaIcon(FontAwesomeIcons.lock,
                                color: Colors.white),
                          ),
                          Expanded(
                              child: Container(
                            padding: const EdgeInsets.all(20.0),
                            child: const Text(
                              'Área de Acesso',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              decoration: const InputDecoration(
                                labelText: 'Usuário',
                                prefixIcon: FaIcon(FontAwesomeIcons.user),
                              ),
                              controller: _controllerUsuario,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextField(
                              decoration: const InputDecoration(
                                  labelText: 'Senha',
                                  prefixIcon: FaIcon(FontAwesomeIcons.key)),
                              controller: _controllerSenha,
                              obscureText: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: ElevatedButton(
                              onPressed: () => _logar(context),
                              child: const Text('Entrar'),
                              style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all(
                                      const Size(250, 60))),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
