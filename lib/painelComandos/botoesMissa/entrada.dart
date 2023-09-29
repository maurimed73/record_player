import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:record_player/estado/controller.dart';
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

  PadMissa? objetoConfig;

  final store = MissaStore();
  bool isPlayingEntrada = false;
  final controllerEntrada = ControllerMissa();

  PadMissa entrada = PadMissa(
      texto: 'Entrada',
      icon: Icons.play_arrow,
      cor: Colors.amber,
      isPlaying: false);

  @override
  Widget build(contexto) {
    return ListenableBuilder(
      listenable: store,
      builder: (BuildContext context, Widget? child) {
        return GestureDetector(
          // UM TOQUE PLAY MÚSICA
          onTap: () {
            controllerEntrada.alterarEntrada();
            if (controllerEntrada.entradaTocando.value) {
              entrada.cor = Colors.green;
            } else {
              entrada.cor = Colors.amber;
            }
            setState(() {});
          },

          onDoubleTap: () {
            if (!controllerEntrada.entradaTocando.value) {
              print('Entrei no config, audio está parado');
            } else {
              print(
                  'Não posso entrar no config pois o áudio está sendo executado');
            }
          },

          onLongPress: () {
            if (!controllerEntrada.entradaTocando.value) {
              print('Entrei no modo gravação, audio está parado');
            } else {
              print(
                  'Não posso entrar no modo gravação pois o áudio está sendo executado');
            }
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
              print('ok');
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
