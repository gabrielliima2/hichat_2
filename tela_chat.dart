import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tora_app/componentes/chat_bubble.dart';
import 'package:tora_app/componentes/meu_textfield.dart';
import 'package:tora_app/servicos/autenticacao/servico_autenticacao.dart';
import 'package:tora_app/servicos/chat/servico_chat.dart';

class TelaChat extends StatefulWidget {
  final String reciverEmail;
  final String receiverId;

  const TelaChat({
    super.key,
    required this.reciverEmail,
    required this.receiverId,
  });

  @override
  State<TelaChat> createState() => _TelaChatState();
}

class _TelaChatState extends State<TelaChat> {
  //criar mensagem
  final TextEditingController _controladorMensagem = TextEditingController();

  //chat e serviço de autenticação
  final ServicoChat _servicoChat = ServicoChat();
  final ServicoAutenticacao _servicoAutenticacao = ServicoAutenticacao();

  FocusNode myFocousNode = FocusNode();

  @override
  void initState() {
    super.initState();

    myFocousNode.addListener(() {
      if (myFocousNode.hasFocus) {
        Future.delayed(
          const Duration(milliseconds: 100),
          () => scrollDown(),
        );
      }
    });

    Future.delayed(
      const Duration(milliseconds: 100),
      () => scrollDown(),
    );
  }

  @override
  void dispose() {
    myFocousNode.dispose();
    _controladorMensagem.dispose();
    super.dispose();
  }

  final ScrollController _scrollController = ScrollController();
  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  //envia mensagem
  void enviaMensagem() async {
    //se tiver algo escrito
    if (_controladorMensagem.text.isNotEmpty) {
      await _servicoChat.enviarMensagem(
          widget.receiverId, _controladorMensagem.text);

      //limpa o campo de mensagem
      _controladorMensagem.clear();
    }

    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(widget.reciverEmail),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey.shade700,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: _criaListaMensagem(),
          ),
          _criaInputUsuario(),
        ],
      ),
    );
  }

  Widget _criaListaMensagem() {
    String senderID = _servicoAutenticacao.pegarUsuarioAtual()!.uid;
    return StreamBuilder(
      stream: _servicoChat.getMensagens(widget.receiverId, senderID),
      builder: (context, snapshot) {
        //erro
        if (snapshot.hasError) {
          return const Text("Erro");
        }

        //carregando...
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Carregando...');
        }

        //retornando a lista de mensagens
        return ListView(
          controller: _scrollController,
          children:
              snapshot.data!.docs.map((doc) => _criaItemMensagem(doc)).toList(),
        );
      },
    );
  }

  Widget _criaItemMensagem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // usuario atual
    bool isUsuarioAtual =
        data['senderID'] == _servicoAutenticacao.pegarUsuarioAtual()!.uid;

    //coloca a mensagem na direita se quem enviou ela foi o usuario atual, em outro caso na esquerda
    var alignment =
        isUsuarioAtual ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isUsuarioAtual ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(
            message: data['message'],
            isUsuarioAtual: isUsuarioAtual,
          )
        ],
      ),
    );
  }

  Widget _criaInputUsuario() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          Expanded(
            child: MeuCampoDeTexto(
              controller: _controladorMensagem,
              hintText: "Digite uma mensagem",
              obscureText: false,
              focusNode: myFocousNode,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: enviaMensagem,
              icon: const Icon(
                Icons.arrow_upward,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
