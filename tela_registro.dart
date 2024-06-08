import 'package:flutter/material.dart';
import 'package:tora_app/autenticacao/servico_autenticacao.dart';

import '../componentes/botoes.dart';
import '../componentes/meu_textfield.dart';

class TelaRegistro extends StatelessWidget {
  //controlador do texto do email e senha
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController = TextEditingController();

  //clique para ir para a tela de login
  final void Function()? onTap;

  TelaRegistro({
    super.key,
    required this.onTap,
  });

  //Método de cadastro
  void cadastro(BuildContext context) {
    //get servico de autenticacao
    final _autenticacao = ServicoAutenticacao();

    // se a senha for igual, criar a conta.
    if (_senhaController.text == _confirmarSenhaController.text) {
      try {
        _autenticacao.cadastrarComEmailSenha(
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
    }
    // se a senha NÃO for igual, mostrar o erro de senha incorreta
    else{
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
              Icon(
                Icons.message,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
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

              Row(  //cadastro
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Já possui conta? ",
                      style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: Text("login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,),
                      ),
                    ),
                  ]
              ),
            ],
          )
      ),
    );
  }
}
