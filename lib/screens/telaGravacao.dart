import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:record/record.dart';
import 'package:record_player/service.dart';

import 'package:record_player/widgets/botao_funcao.dart';

class TelaGravacao extends StatefulWidget {
  const TelaGravacao(
      {super.key, required this.title, required this.tipoMusica});

  final String title;
  final String tipoMusica;

  @override
  State<TelaGravacao> createState() => _TelaGravacaoState();
}

class _TelaGravacaoState extends State<TelaGravacao> {
  AudioPlayer playerEntrada = AudioPlayer();
  Record recordPlayer = Record();

  bool isPlayingEntrada = false;
  bool isRecodingEntrada = false;
  Duration durationEntrada = Duration.zero;
  Duration positionEntrada = Duration.zero;
  Color corContainer = Colors.amber;

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(4, '0');
  }

  @override
  void initState() {
    super.initState();

    recordPlayer.onStateChanged().listen((state) {
      setState(() {
        isRecodingEntrada = state == RecordState.record;
      });
    });

    playerEntrada.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlayingEntrada = state == PlayerState.playing;
      });
    });

    playerEntrada.onDurationChanged.listen((newDuration) {
      setState(() {
        durationEntrada = newDuration;
      });
    });

    playerEntrada.onPositionChanged.listen((newPosition) {
      setState(() {
        positionEntrada = newPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: Center(
        child: Container(
          height: 400,
          width: 300,
          decoration: BoxDecoration(
              color: corContainer,
              borderRadius: BorderRadius.all(Radius.circular(4))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Text(
                  widget.tipoMusica,
                  style: TextStyle(fontSize: 30),
                ),
              ),
              SizedBox(
                height: 45,
                child: Slider(
                  min: 0,
                  max: durationEntrada.inSeconds.toDouble(),
                  value: positionEntrada.inSeconds.toDouble(),
                  onChanged: (value) {
                    final position = Duration(seconds: value.toInt());
                    playerEntrada.seek(position);
                    playerEntrada.resume();
                  },
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    formatTime(positionEntrada.inSeconds),
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                      formatTime((durationEntrada - positionEntrada).inSeconds),
                      style: TextStyle(fontSize: 12)),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      height: 80,
                      width: 280,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          botaoFuncao(
                            iconTipo: Icons.circle,
                            comando: "recorder",
                            isPlayingEntrada: isPlayingEntrada,
                            isRecordingEntrada: isRecodingEntrada,
                            musica: null,
                            player: playerEntrada,
                            position: positionEntrada,
                          ),
                          GestureDetector(
                            onTap: () {
                              // playerEntrada.play(DeviceFileSource(
                              //     '/data/user/0/com.example.record_player/app_flutter/Entrada.m4a'));
                            },
                            child: botaoFuncao(
                              iconTipo: Icons.play_arrow,
                              comando: "playing",
                              isPlayingEntrada: isPlayingEntrada,
                              isRecordingEntrada: isRecodingEntrada,
                              musica:
                                  '/data/user/0/com.example.record_player/app_flutter/Ato.m4a',
                              player: playerEntrada,
                              position: positionEntrada,
                            ),
                          ),
                          botaoFuncao(
                            iconTipo: Icons.pause,
                            comando: "pause",
                            isPlayingEntrada: isPlayingEntrada,
                            isRecordingEntrada: isRecodingEntrada,
                            musica:
                                '/data/user/0/com.example.record_player/app_flutter/Ato.m4a',
                            player: playerEntrada,
                            position: positionEntrada,
                          ),
                          botaoFuncao(
                            iconTipo: Icons.stop,
                            comando: "stop",
                            isPlayingEntrada: isPlayingEntrada,
                            isRecordingEntrada: isRecodingEntrada,
                            musica: null,
                            player: playerEntrada,
                            position: positionEntrada,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
