import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:record_player/painelComandos/comandos.dart';

///import 'package:record_player/Data/estudo.dart';
//import 'package:record_player/estado/controller.dart';
import 'package:record_player/service.dart';

class botaoFuncao extends StatefulWidget {
  final IconData iconTipo;
  final String comando;
  bool isRecordingEntrada;
  bool isPlayingEntrada;
  AudioPlayer player;
  final String? musica;
  Duration position;

  botaoFuncao(
      {super.key,
      required this.iconTipo,
      required this.comando,
      required this.isPlayingEntrada,
      required this.player,
      required this.musica,
      required this.position,
      required this.isRecordingEntrada});

  @override
  State<botaoFuncao> createState() => _botaoFuncaoState();
}

class _botaoFuncaoState extends State<botaoFuncao> {
  late bool isRecord;

  @override
  void initState() {
    super.initState();
    isRecord = false;
  }

  Comandos comandos = Comandos();
  @override
  Widget build(BuildContext context) {
    Service service = Service(player: widget.player);

    return ListenableBuilder(
      listenable: service,
      builder: (context, child) => Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(),
                borderRadius: BorderRadius.circular(8)),
            height: 50,
            width: 50,
          ),
          IconButton(
            iconSize: 25,
            onPressed: () {
              switch (widget.comando) {
                case 'recorder':
                  {
                    if (!widget.isPlayingEntrada &&
                        !widget.isRecordingEntrada) {
                      //Record().start();
                      comandos.startRec('Santo');
                      print('Nova Gravação em andamento');
                      isRecord = true;
                    } else {
                      print('Não pode gravar');
                    }
                  }
                  break;

                case 'playing':
                  {
                    if (widget.isPlayingEntrada || widget.isRecordingEntrada) {
                      print('música não pode ser iniciada');
                    } else {
                      print('musica sendo tocada');
                      // widget.player.play(DeviceFileSource(
                      //     '/data/user/0/com.example.record_player/app_flutter/Entrada.m4a'));
                      Comandos().playMusic(widget.player, 'Ato');
                      widget.player.onPlayerComplete.listen((event) {
                        widget.position = Duration.zero;
                        var tempo = widget.player.onDurationChanged;
                      });
                    }
                  }
                  break;

                case 'pause':
                  {
                    if (widget.isPlayingEntrada) {
                      widget.player.pause();
                    } else {
                      widget.player.pause();
                    }
                    print('Pausando a música');
                  }
                  break;
                case 'stop':
                  isRecord = false;
                  //Record().stop();
                  comandos.stopRecording();
                  comandos.stopMusic(widget.player);
                  break;
              }
            },
            icon: Icon(widget.iconTipo),
            color: widget.iconTipo == Icons.circle
                ? Colors.red[900]
                : Colors.black,
          ),
        ],
      ),
    );
  }
}
