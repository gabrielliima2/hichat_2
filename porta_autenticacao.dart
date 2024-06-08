import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tora_app/autenticacao/login_ou_cadastro.dart';

import '../telas/tela_inicial.dart';

class PortaAutenticacao extends StatelessWidget {
  const PortaAutenticacao({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          //usuario esta logado
          if(snapshot.hasData) {
            return const HomePage();
          }
          //usuario nao esta logado
          else{
            return const LoginOuCadastro();
          }

        },
      ),
    );
  }
}
