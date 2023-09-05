import 'package:flutter/material.dart';

class PadMissa {
  String texto;
  IconData icon;
  Color cor;
  String? musica;

  PadMissa(
      {required this.texto,
      required this.icon,
      required this.cor,
      this.musica});
}
