import 'package:flutter/material.dart';
import '../componentes/botoes.dart';
import '../componentes/meu_textfield.dart';
import '../servicos/autenticacao/servico_autenticacao.dart';

class TelaRegistro extends StatelessWidget {
  //controlador do texto do email, senha e nome
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController = TextEditingController();

  //clique para ir para a tela de login
  final void Function()? onTap;

  TelaRegistro({
    super.key,
    required this.onTap,
  });

// Método de cadastro
  void cadastro(BuildContext context) {
    // Serviço de autenticação
    final _autenticacao = ServicoAutenticacao();

    // Se a senha for igual, criar a conta
    if (_senhaController.text == _confirmarSenhaController.text) {
      try {
        _autenticacao.cadastrarComEmailSenha(
          _nomeController.text, // Passando o nome corretamente
          _emailController.text,
          _senhaController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      // Se as senhas não forem iguais, mostrar erro
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("As senhas não estão iguais"),
        ),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("HICHAT",  style: TextStyle(
              fontSize: 30.0,
              color: Color.fromARGB(255, 147, 147, 147),
              )
            ),


          const SizedBox(height: 50),

          //Menssagem criar conta
          Text(
            "Crie sua conta",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 25),

          //Campo de texto do nome

          MeuCampoDeTexto(
            hintText: 'Nome',
            obscureText: false,
            controller: _nomeController,
          ),

          const SizedBox(height: 10),

          //Campo de texto do email

          MeuCampoDeTexto(
            hintText: 'Email',
            obscureText: false,
            controller: _emailController,
          ),

          const SizedBox(height: 10),

          //Campo de texto da senha
          MeuCampoDeTexto(
            hintText: 'Senha',
            obscureText: true,
            controller: _senhaController,
          ),

          const SizedBox(height: 10),

          //Campo de texto para confirmar a senha
          MeuCampoDeTexto(
            hintText: 'Confirmar senha',
            obscureText: true,
            controller: _confirmarSenhaController,
          ),

          const SizedBox(height: 25),

          //Botão de login
          Botoes(
            texto: "Cadastrar-se",
            onTap: () => cadastro(context),
          ),

          const SizedBox(height: 25),

          Row(
              //cadastro
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Já possui conta? ",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ]),
        ],
      )),
    );
  }
}
