import 'package:firebase_auth/firebase_auth.dart';

class ServicoAutenticacao {
  //instancia de autenticar
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //entrar
  Future<UserCredential> entrarComEmailSenha(String email, senha) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //cadastrar
  Future<UserCredential> cadastrarComEmailSenha(String email, senha) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sair
  Future<void> signOut() async{
    return await _auth.signOut();
  }


  //erros


}