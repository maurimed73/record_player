import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:record_player/models/padMissa.dart';

class GloriaPad extends StatefulWidget {
  const GloriaPad({super.key});

  @override
  State<GloriaPad> createState() => _GloriaPadState();
}

class _GloriaPadState extends State<GloriaPad> {
  final playerGloria = AudioPlayer();
  PadMissa gloria = PadMissa(
      texto: 'Glória',
      icon: Icons.play_arrow,
      cor: Colors.amber,
      isPlaying: false);
  PadMissa? objetoConfig;
  bool config = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // UM TOQUE PLAY MÚSICA
      onTap: () {
        if (gloria.isPlaying == null || gloria.isPlaying == false) {
          gloria.icon = Icons.stop;
          gloria.cor = Colors.green;
          gloria.isPlaying = true;

          playerGloria.play(DeviceFileSource(
              '/data/user/0/com.example.record_player/app_flutter/Ato.m4a'));
        } else {
          playerGloria.stop();
          gloria.icon = Icons.play_arrow;
          gloria.cor = Colors.amber;
          gloria.isPlaying = false;
        }
        setState(() {
          // isPlaying = !isPlaying;
        });
      },
      // ARRASTA PARA CIMA EDITA O PAD
      onVerticalDragStart: (details) {
        setState(() {
          config = false;
          objetoConfig = PadMissa(
              texto: gloria.texto,
              icon: gloria.icon,
              cor: gloria.cor,
              isPlaying: false);
        });

        print('deu certo vertical');
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(color: gloria.cor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(gloria.icon),
            Text(gloria.texto),
          ],
        ),
      ),
    );
  }
}
