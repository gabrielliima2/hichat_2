import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tora_app/temas/provedor_temas.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isUsuarioAtual;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isUsuarioAtual,
  });

  @override
  Widget build(BuildContext context) {
    bool isModoEscuro =
        Provider.of<ProvedorTemas>(context, listen: false).isModoEscuro;

    return Container(
      decoration: BoxDecoration(
        color: isUsuarioAtual 
        ? (isModoEscuro ? Colors.green.shade600 : Colors.green.shade500)
        : (isModoEscuro ? Colors.grey.shade800 : Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 2.5, horizontal: 25),
      child: Text(
        message,
        style: TextStyle(
          color: isUsuarioAtual ? Colors.white
          : (isModoEscuro ? Colors.white : Colors.black)),
      ),
    );
  }
}
