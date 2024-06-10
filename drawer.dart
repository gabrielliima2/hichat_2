import 'package:flutter/material.dart';
import '../servicos/autenticacao/servico_autenticacao.dart';
import '../telas/tela_configuracao.dart';

class MeuDrawer extends StatelessWidget {
  const MeuDrawer({super.key});

  void logout() {
    //get servico de autenticacao
    final autenticacao = ServicoAutenticacao();
    autenticacao.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              //logo
              DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.message,
                    color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  ),
                ),
              ),



              //lista da tela inicial
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text("M E N U"),
                  leading: const Icon(Icons.home),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              //configurações da tela incial
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text("C O N F I G U R A Ç Ô E S"),
                  leading: const Icon(Icons.settings),
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.push(
                        context,
                      MaterialPageRoute(
                          builder: (context) => TelaConfiguracao(),
                      )
                    );
                  },
                ),
              ),
            ],
          ),

          //lista de logout
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: ListTile(
              title: const Text("S A I R"),
              leading: const Icon(Icons.logout),
              onTap: logout,
            ),
          ),
        ],
      ),
    );
  }
}
