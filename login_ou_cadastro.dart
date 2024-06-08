import 'package:flutter/material.dart';
import 'package:tora_app/telas/tela_login.dart';
import 'package:tora_app/telas/tela_registro.dart';

class LoginOuCadastro extends StatefulWidget {
  const LoginOuCadastro({super.key});

  @override
  State<LoginOuCadastro> createState() => _LoginOuCadastroState();
}

class _LoginOuCadastroState extends State<LoginOuCadastro> {

  //inicialmente mostra a tela de login
  bool showLoginPage = true;

  //mudar entre tela de login e cadastro
  void mudarTelas() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return TelaLogin(
        onTap: mudarTelas,
      );
    }else{
      return TelaRegistro(
        onTap: mudarTelas,
      );
    }
  }
}
