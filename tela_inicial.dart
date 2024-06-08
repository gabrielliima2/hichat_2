import 'package:flutter/material.dart';
import 'package:tora_app/autenticacao/servico_autenticacao.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logout() {
    //get servico de autenticacao
    final _autenticacao = ServicoAutenticacao();
    _autenticacao.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tela Inicial"),
        actions: [
          // botao de sair
          IconButton(onPressed: logout, icon: Icon(Icons.logout))
        ],
      ),
    );
  }
}
