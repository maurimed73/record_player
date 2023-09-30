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
  AudioPlayer player = AudioPlayer();
  Record recordPlayer = Record();

  bool isPlaying = false;
  bool isRecoding = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  Color corContainer = Colors.amber;

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(4, '0');
  }

  @override
  void initState() {
    super.initState();

    recordPlayer.onStateChanged().listen((state) {
      setState(() {
        isRecoding = state == RecordState.record;
      });
    });

    player.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    player.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    player.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 88, 75, 28),
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
                  max: duration.inSeconds.toDouble(),
                  value: position.inSeconds.toDouble(),
                  onChanged: (value) {
                    final position = Duration(seconds: value.toInt());
                    player.seek(position);
                    player.resume();
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
                    formatTime(position.inSeconds),
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(formatTime((duration - position).inSeconds),
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
                            isPlaying: isPlaying,
                            isRecording: isRecoding,
                            musica: widget.tipoMusica,
                            player: player,
                            position: position,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: botaoFuncao(
                              iconTipo: Icons.play_arrow,
                              comando: "playing",
                              isPlaying: isPlaying,
                              isRecording: isRecoding,
                              musica: widget.tipoMusica,
                              player: player,
                              position: position,
                            ),
                          ),
                          botaoFuncao(
                            iconTipo: Icons.pause,
                            comando: "pause",
                            isPlaying: isPlaying,
                            isRecording: isRecoding,
                            musica:
                                '/data/user/0/com.example.record_player/app_flutter/Ato.m4a',
                            player: player,
                            position: position,
                          ),
                          botaoFuncao(
                            iconTipo: Icons.stop,
                            comando: "stop",
                            isPlaying: isPlaying,
                            isRecording: isRecoding,
                            musica: null,
                            player: player,
                            position: position,
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
