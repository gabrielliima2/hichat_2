import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServicoAutenticacao {
  //instancia de autenticar
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //pegar usuario atual
  User? pegarUsuarioAtual() {
    return _auth.currentUser;
  }

  //entrar
  Future<UserCredential> entrarComEmailSenha(String email, senha) async {
    try {
      //faz login do usuario
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );

      //salva as informaçoes do usuario, se ele ainda nao existe
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

  //cadastrar
  Future<UserCredential> cadastrarComEmailSenha(String email, senha) async {
    try {
      //cria o usuario
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      //salva as informaçoes do usuario em um documento separado
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

  //sair
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  //erros
}
