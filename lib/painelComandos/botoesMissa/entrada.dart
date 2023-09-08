import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:record_player/estado/gerencia_estado.dart';
import 'package:record_player/models/padMissa.dart';

class EntradaPad extends StatefulWidget {
  final contexto;
  const EntradaPad({super.key, this.contexto});

  @override
  State<EntradaPad> createState() => _EntradaPadState();
}

class _EntradaPadState extends State<EntradaPad> {
  final playerEntrada = AudioPlayer();
  PadMissa entrada = PadMissa(
      texto: 'Entrada',
      icon: Icons.play_arrow,
      cor: Colors.amber,
      isPlaying: false);

  PadMissa? objetoConfig;

  final store = MissaStore();
  bool isPlayingEntrada = false;

  @override
  Widget build(contexto) {
    return ListenableBuilder(
      listenable: store,
      builder: (BuildContext context, Widget? child) {
        return GestureDetector(
          // UM TOQUE PLAY MÚSICA
          onTap: () {
            setState(() {
              entrada.icon == Icons.play_arrow
                  ? entrada.icon = Icons.stop
                  : entrada.icon = Icons.play_arrow;

              entrada.cor == Colors.amber
                  ? entrada.cor = Colors.green
                  : entrada.cor = Colors.amber;

              entrada.icon == Icons.play_arrow
                  ? entrada.isPlaying = true
                  : entrada.isPlaying = false;

              isPlayingEntrada = !isPlayingEntrada;
            });
          },
          onVerticalDragStart: (details) {
            if (isPlayingEntrada != true) {
              print('Entrei no config');
              store.getAlterarConfig();
              objetoConfig = PadMissa(
                  texto: entrada.texto,
                  icon: entrada.icon,
                  cor: entrada.cor,
                  isPlaying: false);

              print('deu certo vertical');
            } else {
              print('Não entrei no config');
            }
          },

          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(color: entrada.cor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(entrada.icon),
                Text(entrada.texto),
              ],
            ),
          ),
        );
      },
    );
  }
}
