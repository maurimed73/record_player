import 'package:flutter/material.dart';

class PadMissa extends ChangeNotifier {
  String texto;
  IconData icon;
  Color cor;
  String? musica;
  bool isPlaying;

  PadMissa(
      {required this.isPlaying,
      required this.texto,
      required this.icon,
      required this.cor,
      this.musica});

  mudarEstadoMusica() {
    isPlaying = !isPlaying;
    notifyListeners();
  }
}
