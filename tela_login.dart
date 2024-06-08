import 'package:flutter/material.dart';
import 'package:tora_app/autenticacao/servico_autenticacao.dart';
import 'package:tora_app/componentes/botoes.dart';
import 'package:tora_app/componentes/meu_textfield.dart';

class TelaLogin extends StatelessWidget {

  //controlador do texto do email e senha
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  //clique para ir para a tela de cadastro
  final void Function()? onTap;

  TelaLogin({
    super.key,
    required this.onTap,
  });

  //Método de login
  void login(BuildContext context) async{
    //serviço de autenticação
    final servicoAutenticacao = ServicoAutenticacao();

    //tentar logar
    try{
      await servicoAutenticacao.entrarComEmailSenha(_emailController.text, _senhaController.text);
    }

    //captar erros
    catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
      );
    }

  }


  Widget build(BuildContext context){
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

            //Menssagem de bem-vindo

            Text(
              "Seja bem-vindo!",
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

            const SizedBox(height: 25),

            //Botão de login
            Botoes(
              texto: "Login",
              onTap: () => login(context),
            ),

            const SizedBox(height: 25),

            Row(  //cadastro
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Não tem conta? ",
                  style:
                  TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text("Criar conta",
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