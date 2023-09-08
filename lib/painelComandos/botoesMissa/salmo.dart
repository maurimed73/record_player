import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:record_player/models/padMissa.dart';

class SalmoPad extends StatefulWidget {
  const SalmoPad({super.key});

  @override
  State<SalmoPad> createState() => _SalmoPadState();
}

class _SalmoPadState extends State<SalmoPad> {
  final playerSalmo = AudioPlayer();
  PadMissa salmo = PadMissa(
      texto: 'Salmo',
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
        if (salmo.isPlaying == null || salmo.isPlaying == false) {
          salmo.icon = Icons.stop;
          salmo.cor = Colors.green;
          salmo.isPlaying = true;

          playerSalmo.play(DeviceFileSource(
              '/data/user/0/com.example.record_player/app_flutter/Ato.m4a'));
        } else {
          playerSalmo.stop();
          salmo.icon = Icons.play_arrow;
          salmo.cor = Colors.amber;
          salmo.isPlaying = false;
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
              texto: salmo.texto,
              icon: salmo.icon,
              cor: salmo.cor,
              isPlaying: false);
        });

        print('deu certo vertical');
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(color: salmo.cor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(salmo.icon),
            Text(salmo.texto),
          ],
        ),
      ),
    );
  }
}
