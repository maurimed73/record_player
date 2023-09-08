import 'package:flutter/material.dart';

class MissaStore extends ChangeNotifier {
  bool config = true;
  bool isPlaying = false;

  getAlterarConfig() async {
    config = !config;
    notifyListeners();
  }

  getAlterarIsPlaying() {
    isPlaying = !isPlaying;
    notifyListeners();
  }
}
