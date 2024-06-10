import 'package:flutter/material.dart';
import 'package:tora_app/temas/mode_escuro.dart';
import 'package:tora_app/temas/modo_clado.dart';

class ProvedorTemas extends ChangeNotifier {
  ThemeData _themeData = modoClaro;

  ThemeData get themeData => _themeData;

  bool get isModoEscuro => _themeData == modoEscuro;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void mudarTema() {
    if (_themeData == modoClaro) {
      themeData = modoEscuro;
    } else {
      themeData = modoClaro;
    }
  }
}
