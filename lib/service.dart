import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Service extends ChangeNotifier {
  final AudioPlayer player;
  var isPlaying = false;

  Service({required this.player});

  tocarMusica() {
    player.play(DeviceFileSource(
        '/data/user/0/com.example.record_player/app_flutter/Entrada.m4a'));
  }

  alterarIsPlaying() {
    isPlaying = !isPlaying;
    notifyListeners();
  }
}
