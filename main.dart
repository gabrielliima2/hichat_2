import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tora_app/firebase_options.dart';
import 'package:tora_app/servicos/autenticacao/porta_autenticacao.dart';
import 'package:tora_app/temas/provedor_temas.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(create: (context) => ProvedorTemas(),
    child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TORA',
      theme: Provider.of<ProvedorTemas>(context).themeData,
      debugShowCheckedModeBanner: false,
      home: const PortaAutenticacao(),
    );
  }
}
