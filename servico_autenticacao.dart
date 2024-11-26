import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServicoAutenticacao {
  // Instância de autenticação
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Pegar usuário atual
  User? pegarUsuarioAtual() {
    return _auth.currentUser;
  }

  // Entrar
  Future<UserCredential> entrarComEmailSenha(String email, senha) async {
    try {
      // Faz login do usuário
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );

      // Salva as informações do usuário, se ele ainda não existe
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': email,

        },
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

// Cadastrar
  Future<UserCredential> cadastrarComEmailSenha(String nome, String email, String senha) async {
    try {
      // Cria o usuário com email e senha
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      // Armazena o nome do usuário no Firestore
      await _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'nome': nome,  // Armazena o nome do usuário
        'email': email,
      });

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }



  // Sair
  Future<void> signOut() async {
    return await _auth.signOut();
  }

// Erros
}
