import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:record_player/models/padMissa.dart';

class AtoPad extends StatefulWidget {
  const AtoPad({super.key});

  @override
  State<AtoPad> createState() => _AtoPadState();
}

class _AtoPadState extends State<AtoPad> {
  final playerAto = AudioPlayer();
  PadMissa ato = PadMissa(
      texto: 'Ato',
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
        if (ato.isPlaying == null || ato.isPlaying == false) {
          ato.icon = Icons.stop;
          ato.cor = Colors.green;
          ato.isPlaying = true;

          playerAto.play(DeviceFileSource(
              '/data/user/0/com.example.record_player/app_flutter/Ato.m4a'));
        } else {
          playerAto.stop();
          ato.icon = Icons.play_arrow;
          ato.cor = Colors.amber;
          ato.isPlaying = false;
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
              texto: ato.texto, icon: ato.icon, cor: ato.cor, isPlaying: false);
        });

        print('deu certo vertical');
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(color: ato.cor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(ato.icon),
            Text(ato.texto),
          ],
        ),
      ),
    );
  }
}
