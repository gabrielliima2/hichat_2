import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tora_app/modelos/menssagem.dart';

class ServicoChat {
  //receber instancia do firebase
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //usuario
  Stream<List<Map<String, dynamic>>> recebeUsuario() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final usuario = doc.data();

        return usuario;
      }).toList();
    });
  }

  //enviar mensagem
  Future<void> enviarMensagem(String receiverId, message) async {
    //recebe informação do usuario atual
    final String idUsuarioAtual = _auth.currentUser!.uid;
    final String emailUsuarioAtual = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //cria uma nova mensagem
    Mensagem novaMensagem = Mensagem(
        senderID: idUsuarioAtual,
        senderEmail: emailUsuarioAtual,
        receiverId: receiverId,
        message: message,
        timestamp: timestamp,
      );

    //criar ID da sala de conversa para os dois usuarios
    List<String> ids = [idUsuarioAtual, receiverId];
    ids.sort();
    String chatRoomID = ids.join('_');

    //adiciona a mensagem no banco de dados
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomID)
        .collection("messages")
        .add(novaMensagem.toMap());
  }

  //recebe a menssagem
  Stream<QuerySnapshot> getMensagens(String userID, otherUserID) {
    //cria um id da sala de conversa para os usuarios
    List<String> ids = [userID, otherUserID];
    ids.sort();
    String chatRoomID = ids.join('_');

    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomID)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
