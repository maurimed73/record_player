import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:record_player/models/padMissa.dart';

class AclamacaoPad extends StatefulWidget {
  const AclamacaoPad({super.key});

  @override
  State<AclamacaoPad> createState() => _AclamacaoPadState();
}

class _AclamacaoPadState extends State<AclamacaoPad> {
  final playerAclamacao = AudioPlayer();
  PadMissa aclamacao = PadMissa(
      texto: 'Aclamação',
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
        if (aclamacao.isPlaying == null || aclamacao.isPlaying == false) {
          aclamacao.icon = Icons.stop;
          aclamacao.cor = Colors.green;
          aclamacao.isPlaying = true;

          playerAclamacao.play(DeviceFileSource(
              '/data/user/0/com.example.record_player/app_flutter/Ato.m4a'));
        } else {
          playerAclamacao.stop();
          aclamacao.icon = Icons.play_arrow;
          aclamacao.cor = Colors.amber;
          aclamacao.isPlaying = false;
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
              texto: aclamacao.texto,
              icon: aclamacao.icon,
              cor: aclamacao.cor,
              isPlaying: false);
        });

        print('deu certo vertical');
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(color: aclamacao.cor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(aclamacao.icon),
            Text(aclamacao.texto),
          ],
        ),
      ),
    );
  }
}
