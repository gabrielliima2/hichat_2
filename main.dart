import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tora_app/autenticacao/porta_autenticacao.dart';
import 'package:tora_app/firebase_options.dart';
import 'package:tora_app/temas/modo_clado.dart';
import 'autenticacao/login_ou_cadastro.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TORA',
      theme: modoClaro,
      debugShowCheckedModeBanner: false,
      home: const PortaAutenticacao(),
    );
  }
}
