import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tora_app/servicos/autenticacao/servico_autenticacao.dart';
import 'package:tora_app/temas/provedor_temas.dart';

class TelaConfiguracao extends StatelessWidget {
  TelaConfiguracao({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _deleteUser(BuildContext context) async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        await _firestore.collection('Users').doc(user.uid).delete(); // Exclui o documento do Firestore
        await user.delete(); // Exclui o usuário do Firebase Authentication
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Usuário deletado com sucesso')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nenhum usuário autenticado')),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Reautenticação necessária')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao deletar usuário: ${e.message}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: ${e.toString()}')),
      );
    }
  }

  void logout() {
    //get servico de autenticacao
    final autenticacao = ServicoAutenticacao();
    autenticacao.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text("Configurações"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey.shade700,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(25),
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // modo escuro
                const Text("Dark Mode"),

                // alterar
                CupertinoSwitch(
                  value: Provider.of<ProvedorTemas>(context, listen: false)
                      .isModoEscuro,
                  onChanged: (value) =>
                      Provider.of<ProvedorTemas>(context, listen: false)
                          .mudarTema(),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Deletar Conta'),
                      content: const Text(
                          'Você tem certeza que quer deletar a conta? Esta ação não pode ser desfeita.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
                            //código para deletar a conta
                            _deleteUser(context);
                            logout;
                            Navigator.of(context).pop();
                          },
                          child: const Text('Deletar'),
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Deletar Conta'),
            ),
          ),
        ],
      ),
    );
  }
}
