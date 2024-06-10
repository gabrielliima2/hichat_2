import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tora_app/componentes/user_tile.dart';
import 'package:tora_app/servicos/autenticacao/servico_autenticacao.dart';
import 'package:tora_app/servicos/chat/servico_chat.dart';
import 'package:tora_app/telas/tela_chat.dart';
import '../componentes/drawer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // serviço de chat e autenticação
  final ServicoChat _servicoChat = ServicoChat();
  final ServicoAutenticacao _servicoAutenticacao = ServicoAutenticacao();

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Home"),
            Text("${user?.email}"),
            ],
          ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey.shade700,
        elevation: 0,
      ),
      drawer: const MeuDrawer(),
      body: _criarListaUsuario(),
    );
  }

  //cria a lista de usuarios, exeto usuarios logados
  Widget _criarListaUsuario() {
    return StreamBuilder(
      stream: _servicoChat.recebeUsuario(),
      builder: (context, snapshot) {
        //erro
        if (snapshot.hasError) {
          return const Text("Erro");
        }
        //carregando..
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Carregando...");
        }
        //retorna a lista
        return ListView(
          children: snapshot.data!
              .map<Widget>(
                  (userData) => _criarItemListaUsuario(userData, context))
              .toList(),
        );
      },
    );
  }

  //cria lista de usuarios individuais
  Widget _criarItemListaUsuario(
      Map<String, dynamic> userData, BuildContext context) {
    //exibe todos os usuarios, menos o atual
    if (userData["email"] != _servicoAutenticacao.pegarUsuarioAtual()!.email) {
      return UserTile(
        texto: userData["email"],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TelaChat(
                reciverEmail: userData["email"],
                receiverId: userData["uid"],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
