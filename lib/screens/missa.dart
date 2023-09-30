import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
//import 'package:record_player/painelComandos/botoesMissa/entrada.dart';
import 'package:record_player/painelComandos/comandos.dart';
import 'package:record_player/screens/telaGravacao.dart';
import 'package:record_player/estado/controller.dart';
import 'package:record_player/models/padMissa.dart';

import 'package:record_player/estado/gerencia_estado.dart';
import 'package:record_player/Data/dadosMissa.dart';
//import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
//import 'package:record_player/widgets/botao_funcao.dart';

class MissaSamples extends StatefulWidget {
  const MissaSamples({super.key});

  @override
  State<MissaSamples> createState() => _MissaSamplesState();
}

class _MissaSamplesState extends State<MissaSamples> {
  final audio = AudioPlayer();
  final playerEntrada = AudioPlayer();
  Duration durationEntrada = Duration.zero;
  Duration positionEntrada = Duration.zero;
  bool isRecording = false;

  final playerAto = AudioPlayer();
  final playerGloria = AudioPlayer();
  final playerSalmo = AudioPlayer();
  final playerAcla = AudioPlayer();
  final playerOfertorio = AudioPlayer();
  final playerSanto = AudioPlayer();
  final playerCordeiro = AudioPlayer();
  final playerComunhao = AudioPlayer();
  final playerComunhao2 = AudioPlayer();
  final playerFinal = AudioPlayer();
  final playerOpcional = AudioPlayer();
  final recorded = Record();
  String audioPath = "";

  String formatTime(int seconds) {
    return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(3, '0');
  }

  ControllerMissa controller = ControllerMissa();

  List<String> listaSamples = [];

  final store = MissaStore();
  final canto = DadosPadMissa();

  @override
  void initState() {
    super.initState();
    store.config = true;
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

    recorded.onStateChanged().listen((state) {
      setState(() {
        isRecording = state == RecordState.record;
      });
    });
  }

  @override
  void dispose() {
    audio.dispose();
    super.dispose();
  }

  //variaveis para  troca de tela para config do pad
  PadMissa? objetoConfig;
  bool isPlayingEntrada = false;
  bool isPlayingAto = false;
  bool isPlayingGloria = false;
  bool isPlayingSalmo = false;
  bool isPlayingAclamacao = false;
  bool isPlayingOfertorio = false;
  bool isPlayingSanto = false;
  bool isPlayingCordeiro = false;
  bool isPlayingComunhao = false;
  bool isPlayingComunhao2 = false;
  bool isPlayingFinal = false;
  bool isPlayingOpcional = false;
  late Duration songLength;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: store,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          backgroundColor: Color.fromARGB(255, 173, 131, 2),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text(
              'Tela Missa.dart',
              textAlign: TextAlign.center,
            ),
          ),
          body: Stack(
            children: [
              store.config
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: GridView(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 2),
                          children: [
                            //Entrada
                            GestureDetector(
                              // UM TOQUE PLAY MÚSICA
                              onTap: () {
                                setState(() {
                                  if (canto.entrada.isPlaying == null ||
                                      canto.entrada.isPlaying == false) {
                                    canto.entrada.icon = Icons.stop;
                                    canto.entrada.cor =
                                        Color.fromARGB(255, 115, 92, 25);
                                    canto.entrada.isPlaying = true;
                                    Comandos()
                                        .playMusic(playerEntrada, 'Entrada');
                                  } else {
                                    Comandos().stopMusic(playerEntrada);
                                    canto.entrada.icon = Icons.play_arrow;
                                    canto.entrada.cor = Colors.amber;
                                    canto.entrada.isPlaying = false;
                                  }
                                  isPlayingEntrada = !isPlayingEntrada;
                                });
                              },

                              // ARRASTAR PARA CIMA EDITA O PAD

                              onVerticalDragStart: (details) {
                                if (isPlayingEntrada != true) {
                                  print('Entrei no config');
                                  store.getAlterarConfig();
                                  objetoConfig = PadMissa(
                                      texto: canto.entrada.texto,
                                      icon: canto.entrada.icon,
                                      cor: canto.entrada.cor,
                                      isPlaying: false);

                                  print('deu certo vertical');
                                } else {
                                  print('Não entrei no config');
                                }
                              },

                              // SEGURAR PARA ENTRAR NA GRAVAÇÃO
                              onLongPress: () {
                                if (isPlayingEntrada != true) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TelaGravacao(
                                            title: '${canto.entrada.texto}',
                                            tipoMusica: 'Entrada')),
                                  );
                                  print('gravação iniciada');
                                } else {
                                  print('Não pode gravar');
                                }
                              },

                              child: Container(
                                height: 100,
                                width: 100,
                                decoration:
                                    BoxDecoration(color: canto.entrada.cor),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(canto.entrada.icon),
                                    Text(canto.entrada.texto),
                                  ],
                                ),
                              ),
                            ),

                            //Ato
                            GestureDetector(
                              // UM TOQUE PLAY MÚSICA
                              onTap: () {
                                setState(() {
                                  if (canto.Ato.isPlaying == null ||
                                      canto.Ato.isPlaying == false) {
                                    canto.Ato.icon = Icons.stop;
                                    canto.Ato.cor =
                                        Color.fromARGB(255, 115, 92, 25);
                                    canto.Ato.isPlaying = true;
                                    Comandos().playMusic(playerAto, 'Ato');
                                  } else {
                                    Comandos().stopMusic(playerAto);
                                    canto.Ato.icon = Icons.play_arrow;
                                    canto.Ato.cor = Colors.amber;
                                    canto.Ato.isPlaying = false;
                                  }
                                  isPlayingAto = !isPlayingAto;
                                });
                              },

                              // ARRASTAR PARA CIMA EDITA O PAD

                              onVerticalDragStart: (details) {
                                if (isPlayingAto != true) {
                                  print('Entrei no config');
                                  store.getAlterarConfig();
                                  objetoConfig = PadMissa(
                                      texto: canto.Ato.texto,
                                      icon: canto.Ato.icon,
                                      cor: canto.Ato.cor,
                                      isPlaying: false);

                                  print('deu certo vertical');
                                } else {
                                  print('Não entrei no config');
                                }
                              },

                              // SEGURAR PARA ENTRAR NA GRAVAÇÃO
                              onLongPress: () {
                                if (isPlayingAto != true) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TelaGravacao(
                                            title: '${canto.Ato.texto}',
                                            tipoMusica: 'Ato')),
                                  );
                                  print('gravação iniciada');
                                } else {
                                  print('Não pode gravar');
                                }
                              },

                              child: Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(color: canto.Ato.cor),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(canto.Ato.icon),
                                    Text(canto.Ato.texto),
                                  ],
                                ),
                              ),
                            ),

                            //Glória
                            GestureDetector(
                              // UM TOQUE PLAY MÚSICA
                              onTap: () {
                                setState(() {
                                  if (canto.Gloria.isPlaying == null ||
                                      canto.Gloria.isPlaying == false) {
                                    canto.Gloria.icon = Icons.stop;
                                    canto.Gloria.cor =
                                        Color.fromARGB(255, 115, 92, 25);
                                    canto.Gloria.isPlaying = true;
                                    Comandos()
                                        .playMusic(playerGloria, 'Gloria');
                                  } else {
                                    Comandos().stopMusic(playerGloria);
                                    canto.Gloria.icon = Icons.play_arrow;
                                    canto.Gloria.cor = Colors.amber;
                                    canto.Gloria.isPlaying = false;
                                  }
                                  isPlayingGloria = !isPlayingGloria;
                                });
                              },

                              // ARRASTAR PARA CIMA EDITA O PAD

                              onVerticalDragStart: (details) {
                                if (isPlayingGloria != true) {
                                  print('Entrei no config');
                                  store.getAlterarConfig();
                                  objetoConfig = PadMissa(
                                      texto: canto.Gloria.texto,
                                      icon: canto.Gloria.icon,
                                      cor: canto.Gloria.cor,
                                      isPlaying: false);

                                  print('deu certo vertical');
                                } else {
                                  print('Não entrei no config');
                                }
                              },

                              // SEGURAR PARA ENTRAR NA GRAVAÇÃO
                              onLongPress: () {
                                if (isPlayingGloria != true) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TelaGravacao(
                                            title: '${canto.Gloria.texto}',
                                            tipoMusica: 'Gloria')),
                                  );
                                  print('gravação iniciada');
                                } else {
                                  print('Não pode gravar');
                                }
                              },

                              child: Container(
                                height: 100,
                                width: 100,
                                decoration:
                                    BoxDecoration(color: canto.Gloria.cor),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(canto.Gloria.icon),
                                    Text(canto.Gloria.texto),
                                  ],
                                ),
                              ),
                            ),

                            //Salmo
                            GestureDetector(
                              // UM TOQUE PLAY MÚSICA
                              onTap: () {
                                setState(() {
                                  if (canto.Salmo.isPlaying == null ||
                                      canto.Salmo.isPlaying == false) {
                                    canto.Salmo.icon = Icons.stop;
                                    canto.Salmo.cor =
                                        Color.fromARGB(255, 115, 92, 25);
                                    canto.Salmo.isPlaying = true;
                                    Comandos().playMusic(playerSalmo, 'Ato');
                                  } else {
                                    Comandos().stopMusic(playerSalmo);
                                    canto.Salmo.icon = Icons.play_arrow;
                                    canto.Salmo.cor = Colors.amber;
                                    canto.Salmo.isPlaying = false;
                                  }
                                  isPlayingSalmo = !isPlayingSalmo;
                                });
                              },

                              // ARRASTAR PARA CIMA EDITA O PAD

                              onVerticalDragStart: (details) {
                                if (isPlayingSalmo != true) {
                                  print('Entrei no config');
                                  store.getAlterarConfig();
                                  objetoConfig = PadMissa(
                                      texto: canto.Salmo.texto,
                                      icon: canto.Salmo.icon,
                                      cor: canto.Salmo.cor,
                                      isPlaying: false);

                                  print('deu certo vertical');
                                } else {
                                  print('Não entrei no config');
                                }
                              },

                              // SEGURAR PARA ENTRAR NA GRAVAÇÃO
                              onLongPress: () {
                                if (isPlayingSalmo != true) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TelaGravacao(
                                            title: '${canto.Salmo.texto}',
                                            tipoMusica: 'Salmo')),
                                  );
                                  print('gravação iniciada');
                                } else {
                                  print('Não pode gravar');
                                }
                              },

                              child: Container(
                                height: 100,
                                width: 100,
                                decoration:
                                    BoxDecoration(color: canto.Salmo.cor),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(canto.Salmo.icon),
                                    Text(canto.Salmo.texto),
                                  ],
                                ),
                              ),
                            ),

                            //Aclamação
                            GestureDetector(
                              // UM TOQUE PLAY MÚSICA
                              onTap: () {
                                setState(() {
                                  if (canto.Aclamacao.isPlaying == null ||
                                      canto.Aclamacao.isPlaying == false) {
                                    canto.Aclamacao.icon = Icons.stop;
                                    canto.Aclamacao.cor =
                                        Color.fromARGB(255, 115, 92, 25);
                                    canto.Aclamacao.isPlaying = true;
                                    Comandos()
                                        .playMusic(playerAcla, 'Aclamacao');
                                  } else {
                                    Comandos().stopMusic(playerAcla);
                                    canto.Aclamacao.icon = Icons.play_arrow;
                                    canto.Aclamacao.cor = Colors.amber;
                                    canto.Aclamacao.isPlaying = false;
                                  }
                                  isPlayingAclamacao = !isPlayingAclamacao;
                                });
                              },

                              // ARRASTAR PARA CIMA EDITA O PAD

                              onVerticalDragStart: (details) {
                                if (isPlayingAclamacao != true) {
                                  print('Entrei no config');
                                  store.getAlterarConfig();
                                  objetoConfig = PadMissa(
                                      texto: canto.Aclamacao.texto,
                                      icon: canto.Aclamacao.icon,
                                      cor: canto.Aclamacao.cor,
                                      isPlaying: false);

                                  print('deu certo vertical');
                                } else {
                                  print('Não entrei no config');
                                }
                              },

                              // SEGURAR PARA ENTRAR NA GRAVAÇÃO
                              onLongPress: () {
                                if (isPlayingAclamacao != true) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TelaGravacao(
                                            title: '${canto.Aclamacao.texto}',
                                            tipoMusica: 'Aclamacao')),
                                  );
                                  print('gravação iniciada');
                                } else {
                                  print('Não pode gravar');
                                }
                              },

                              child: Container(
                                height: 100,
                                width: 100,
                                decoration:
                                    BoxDecoration(color: canto.Aclamacao.cor),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(canto.Aclamacao.icon),
                                    Text(canto.Aclamacao.texto),
                                  ],
                                ),
                              ),
                            ),

                            //Ofertório
                            GestureDetector(
                              // UM TOQUE PLAY MÚSICA
                              onTap: () {
                                setState(() {
                                  if (canto.Ofertorio.isPlaying == null ||
                                      canto.Ofertorio.isPlaying == false) {
                                    canto.Ofertorio.icon = Icons.stop;
                                    canto.Ofertorio.cor =
                                        Color.fromARGB(255, 115, 92, 25);
                                    canto.Ofertorio.isPlaying = true;
                                    Comandos().playMusic(
                                        playerOfertorio, 'Ofertorio');
                                  } else {
                                    Comandos().stopMusic(playerOfertorio);
                                    canto.Ofertorio.icon = Icons.play_arrow;
                                    canto.Ofertorio.cor = Colors.amber;
                                    canto.Ofertorio.isPlaying = false;
                                  }
                                  isPlayingOfertorio = !isPlayingOfertorio;
                                });
                              },

                              // ARRASTAR PARA CIMA EDITA O PAD

                              onVerticalDragStart: (details) {
                                if (isPlayingOfertorio != true) {
                                  print('Entrei no config');
                                  store.getAlterarConfig();
                                  objetoConfig = PadMissa(
                                      texto: canto.Ofertorio.texto,
                                      icon: canto.Ofertorio.icon,
                                      cor: canto.Ofertorio.cor,
                                      isPlaying: false);

                                  print('deu certo vertical');
                                } else {
                                  print('Não entrei no config');
                                }
                              },

                              // SEGURAR PARA ENTRAR NA GRAVAÇÃO
                              onLongPress: () {
                                if (isPlayingOfertorio != true) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TelaGravacao(
                                            title: '${canto.Ofertorio.texto}',
                                            tipoMusica: 'Ofertorio')),
                                  );
                                  print('gravação iniciada');
                                } else {
                                  print('Não pode gravar');
                                }
                              },

                              child: Container(
                                height: 100,
                                width: 100,
                                decoration:
                                    BoxDecoration(color: canto.Ofertorio.cor),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(canto.Ofertorio.icon),
                                    Text(canto.Ofertorio.texto),
                                  ],
                                ),
                              ),
                            ),

                            //Santo
                            GestureDetector(
                              // UM TOQUE PLAY MÚSICA
                              onTap: () {
                                setState(() {
                                  if (canto.Santo.isPlaying == null ||
                                      canto.Santo.isPlaying == false) {
                                    canto.Santo.icon = Icons.stop;
                                    canto.Santo.cor =
                                        Color.fromARGB(255, 115, 92, 25);
                                    canto.Santo.isPlaying = true;
                                    Comandos().playMusic(playerSanto, 'Santo');
                                  } else {
                                    Comandos().stopMusic(playerSanto);
                                    canto.Santo.icon = Icons.play_arrow;
                                    canto.Santo.cor = Colors.amber;
                                    canto.Santo.isPlaying = false;
                                  }
                                  isPlayingSanto = !isPlayingSanto;
                                });
                              },

                              // ARRASTAR PARA CIMA EDITA O PAD

                              onVerticalDragStart: (details) {
                                if (isPlayingSanto != true) {
                                  print('Entrei no config');
                                  store.getAlterarConfig();
                                  objetoConfig = PadMissa(
                                      texto: canto.Santo.texto,
                                      icon: canto.Santo.icon,
                                      cor: canto.Santo.cor,
                                      isPlaying: false);

                                  print('deu certo vertical');
                                } else {
                                  print('Não entrei no config');
                                }
                              },

                              // SEGURAR PARA ENTRAR NA GRAVAÇÃO
                              onLongPress: () {
                                if (isPlayingSanto != true) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TelaGravacao(
                                            title: '${canto.Santo.texto}',
                                            tipoMusica: 'Santo')),
                                  );
                                  print('gravação iniciada');
                                } else {
                                  print('Não pode gravar');
                                }
                              },

                              child: Container(
                                height: 100,
                                width: 100,
                                decoration:
                                    BoxDecoration(color: canto.Santo.cor),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(canto.Santo.icon),
                                    Text(canto.Santo.texto),
                                  ],
                                ),
                              ),
                            ),

                            //Cordeiro
                            GestureDetector(
                              // UM TOQUE PLAY MÚSICA
                              onTap: () {
                                setState(() {
                                  if (canto.Cordeiro.isPlaying == null ||
                                      canto.Cordeiro.isPlaying == false) {
                                    canto.Cordeiro.icon = Icons.stop;
                                    canto.Cordeiro.cor =
                                        Color.fromARGB(255, 115, 92, 25);
                                    canto.Cordeiro.isPlaying = true;
                                    Comandos()
                                        .playMusic(playerCordeiro, 'Cordeiro');
                                  } else {
                                    Comandos().stopMusic(playerCordeiro);
                                    canto.Cordeiro.icon = Icons.play_arrow;
                                    canto.Cordeiro.cor = Colors.amber;
                                    canto.Cordeiro.isPlaying = false;
                                  }
                                  isPlayingCordeiro = !isPlayingCordeiro;
                                });
                              },

                              // ARRASTAR PARA CIMA EDITA O PAD

                              onVerticalDragStart: (details) {
                                if (isPlayingCordeiro != true) {
                                  print('Entrei no config');
                                  store.getAlterarConfig();
                                  objetoConfig = PadMissa(
                                      texto: canto.Cordeiro.texto,
                                      icon: canto.Cordeiro.icon,
                                      cor: canto.Cordeiro.cor,
                                      isPlaying: false);

                                  print('deu certo vertical');
                                } else {
                                  print('Não entrei no config');
                                }
                              },

                              // SEGURAR PARA ENTRAR NA GRAVAÇÃO
                              onLongPress: () {
                                if (isPlayingCordeiro != true) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TelaGravacao(
                                            title: '${canto.Cordeiro.texto}',
                                            tipoMusica: 'Cordeiro')),
                                  );
                                  print('gravação iniciada');
                                } else {
                                  print('Não pode gravar');
                                }
                              },

                              child: Container(
                                height: 100,
                                width: 100,
                                decoration:
                                    BoxDecoration(color: canto.Cordeiro.cor),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(canto.Cordeiro.icon),
                                    Text(canto.Cordeiro.texto),
                                  ],
                                ),
                              ),
                            ),

                            //Comunhão 1
                            GestureDetector(
                              // UM TOQUE PLAY MÚSICA
                              onTap: () {
                                setState(() {
                                  if (canto.Comunhao1.isPlaying == null ||
                                      canto.Comunhao1.isPlaying == false) {
                                    canto.Comunhao1.icon = Icons.stop;
                                    canto.Comunhao1.cor =
                                        Color.fromARGB(255, 115, 92, 25);
                                    canto.Comunhao1.isPlaying = true;
                                    Comandos()
                                        .playMusic(playerComunhao, 'Comunhao1');
                                  } else {
                                    Comandos().stopMusic(playerComunhao);
                                    canto.Comunhao1.icon = Icons.play_arrow;
                                    canto.Comunhao1.cor = Colors.amber;
                                    canto.Comunhao1.isPlaying = false;
                                  }
                                  isPlayingComunhao = !isPlayingComunhao;
                                });
                              },

                              // ARRASTAR PARA CIMA EDITA O PAD

                              onVerticalDragStart: (details) {
                                if (isPlayingComunhao != true) {
                                  print('Entrei no config');
                                  store.getAlterarConfig();
                                  objetoConfig = PadMissa(
                                      texto: canto.Comunhao1.texto,
                                      icon: canto.Comunhao1.icon,
                                      cor: canto.Comunhao1.cor,
                                      isPlaying: false);

                                  print('deu certo vertical');
                                } else {
                                  print('Não entrei no config');
                                }
                              },

                              // SEGURAR PARA ENTRAR NA GRAVAÇÃO
                              onLongPress: () {
                                if (isPlayingComunhao != true) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TelaGravacao(
                                            title: '${canto.Comunhao1.texto}',
                                            tipoMusica: 'Comunhao1')),
                                  );
                                  print('gravação iniciada');
                                } else {
                                  print('Não pode gravar');
                                }
                              },

                              child: Container(
                                height: 100,
                                width: 100,
                                decoration:
                                    BoxDecoration(color: canto.Comunhao1.cor),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(canto.Comunhao1.icon),
                                    Text(canto.Comunhao1.texto),
                                  ],
                                ),
                              ),
                            ),

                            //Comunhão 2
                            GestureDetector(
                              // UM TOQUE PLAY MÚSICA
                              onTap: () {
                                setState(() {
                                  if (canto.Comunhao2.isPlaying == null ||
                                      canto.Comunhao2.isPlaying == false) {
                                    canto.Comunhao2.icon = Icons.stop;
                                    canto.Comunhao2.cor =
                                        Color.fromARGB(255, 115, 92, 25);
                                    canto.Comunhao2.isPlaying = true;
                                    Comandos().playMusic(
                                        playerComunhao2, 'Comunhao2');
                                  } else {
                                    Comandos().stopMusic(playerComunhao2);
                                    canto.Comunhao2.icon = Icons.play_arrow;
                                    canto.Comunhao2.cor = Colors.amber;
                                    canto.Comunhao2.isPlaying = false;
                                  }
                                  isPlayingComunhao2 = !isPlayingComunhao2;
                                });
                              },

                              // ARRASTAR PARA CIMA EDITA O PAD

                              onVerticalDragStart: (details) {
                                if (isPlayingComunhao2 != true) {
                                  print('Entrei no config');
                                  store.getAlterarConfig();
                                  objetoConfig = PadMissa(
                                      texto: canto.Comunhao2.texto,
                                      icon: canto.Comunhao2.icon,
                                      cor: canto.Comunhao2.cor,
                                      isPlaying: false);

                                  print('deu certo vertical');
                                } else {
                                  print('Não entrei no config');
                                }
                              },

                              // SEGURAR PARA ENTRAR NA GRAVAÇÃO
                              onLongPress: () {
                                if (isPlayingComunhao2 != true) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TelaGravacao(
                                            title: '${canto.Comunhao2.texto}',
                                            tipoMusica: 'Comunhao2')),
                                  );
                                  print('gravação iniciada');
                                } else {
                                  print('Não pode gravar');
                                }
                              },

                              child: Container(
                                height: 100,
                                width: 100,
                                decoration:
                                    BoxDecoration(color: canto.Comunhao2.cor),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(canto.Comunhao2.icon),
                                    Text(canto.Comunhao2.texto),
                                  ],
                                ),
                              ),
                            ),

                            //Final
                            GestureDetector(
                              // UM TOQUE PLAY MÚSICA
                              onTap: () {
                                setState(() {
                                  if (canto.Final.isPlaying == null ||
                                      canto.Final.isPlaying == false) {
                                    canto.Final.icon = Icons.stop;
                                    canto.Final.cor =
                                        Color.fromARGB(255, 115, 92, 25);
                                    canto.Final.isPlaying = true;
                                    Comandos().playMusic(playerFinal, 'Final');
                                  } else {
                                    Comandos().stopMusic(playerFinal);
                                    canto.Final.icon = Icons.play_arrow;
                                    canto.Final.cor = Colors.amber;
                                    canto.Final.isPlaying = false;
                                  }
                                  isPlayingFinal = !isPlayingFinal;
                                });
                              },

                              // ARRASTAR PARA CIMA EDITA O PAD

                              onVerticalDragStart: (details) {
                                if (isPlayingFinal != true) {
                                  print('Entrei no config');
                                  store.getAlterarConfig();
                                  objetoConfig = PadMissa(
                                      texto: canto.Final.texto,
                                      icon: canto.Final.icon,
                                      cor: canto.Final.cor,
                                      isPlaying: false);

                                  print('deu certo vertical');
                                } else {
                                  print('Não entrei no config');
                                }
                              },

                              // SEGURAR PARA ENTRAR NA GRAVAÇÃO
                              onLongPress: () {
                                if (isPlayingFinal != true) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TelaGravacao(
                                            title: '${canto.Final.texto}',
                                            tipoMusica: 'Final')),
                                  );
                                  print('gravação iniciada');
                                } else {
                                  print('Não pode gravar');
                                }
                              },

                              child: Container(
                                height: 100,
                                width: 100,
                                decoration:
                                    BoxDecoration(color: canto.Final.cor),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(canto.Final.icon),
                                    Text(canto.Final.texto),
                                  ],
                                ),
                              ),
                            ),

                            //opcional
                            GestureDetector(
                              // UM TOQUE PLAY MÚSICA
                              onTap: () {
                                setState(() {
                                  if (canto.opcional.isPlaying == null ||
                                      canto.opcional.isPlaying == false) {
                                    canto.opcional.icon = Icons.stop;
                                    canto.opcional.cor =
                                        Color.fromARGB(255, 115, 92, 25);
                                    canto.opcional.isPlaying = true;
                                    Comandos()
                                        .playMusic(playerOpcional, 'Opcional');
                                  } else {
                                    Comandos().stopMusic(playerOpcional);
                                    canto.opcional.icon = Icons.play_arrow;
                                    canto.opcional.cor = Colors.amber;
                                    canto.opcional.isPlaying = false;
                                  }
                                  isPlayingOpcional = !isPlayingOpcional;
                                });
                              },

                              // ARRASTAR PARA CIMA EDITA O PAD

                              onVerticalDragStart: (details) {
                                if (isPlayingOpcional != true) {
                                  print('Entrei no config');
                                  store.getAlterarConfig();
                                  objetoConfig = PadMissa(
                                      texto: canto.opcional.texto,
                                      icon: canto.opcional.icon,
                                      cor: canto.opcional.cor,
                                      isPlaying: false);

                                  print('deu certo vertical');
                                } else {
                                  print('Não entrei no config');
                                }
                              },

                              // SEGURAR PARA ENTRAR NA GRAVAÇÃO
                              onLongPress: () {
                                if (isPlayingOpcional != true) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TelaGravacao(
                                            title: '${canto.opcional.texto}',
                                            tipoMusica: 'Opcional')),
                                  );
                                  print('gravação iniciada');
                                } else {
                                  print('Não pode gravar');
                                }
                              },

                              child: Container(
                                height: 100,
                                width: 100,
                                decoration:
                                    BoxDecoration(color: canto.opcional.cor),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(canto.opcional.icon),
                                    Text(canto.opcional.texto),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      height: 300,
                      width: 500,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                //Criar diretório
                                final Directory extDir =
                                    await getApplicationDocumentsDirectory();
                                final String dirPath = '${extDir.path}/Missa1';

                                await new Directory(dirPath)
                                    .create(recursive: true);
                                // final String filePath = '$dirPath.mp4';
                                // print(filePath);

                                var dir = Directory(
                                    'data/user/0/com.example.record_player/app_flutter/');

                                try {
                                  var dirList = dir.list();

                                  await for (final FileSystemEntity f
                                      in dirList) {
                                    if (f is File) {
                                      //print('PATH ${f.path}');
                                      audioPath = f.path;
                                      File arquivo = File(audioPath);
                                      String fileName =
                                          arquivo.path.split('/').last;
                                      listaSamples.add(fileName);
                                      print(fileName);
                                    } else if (f is Directory) {
                                      print('Diretório encontrado ${f.path}');
                                    }
                                  }
                                  // await for (final FileSystemEntity f
                                  //     in dirList) {
                                  //   if (f is File) {
                                  //     f.delete();
                                  //     print('Found file ${f.path}');
                                  //   }
                                  // }

                                  // print(listaSamples);
                                  // File arquivo = File(audioPath);
                                  // String fileName =
                                  //     arquivo.path.split('/').last;
                                  // print('o arquivo é o  $fileName');
                                } catch (e) {
                                  print(e.toString());
                                }
                                // Directory dir = new Directory(
                                //     '///data/user/0/com.example.record_player/app_flutter/');
                                // List<FileSystemEntity> files =
                                //     dir.listSync(recursive: true);
                                // for (FileSystemEntity file in files) {
                                //   FileStat f1 = file.statSync();
                                //   print(file.absolute);
                                //   print(f1.toString());
                                // }
                              },
                              child: const Text('Listar arquivos')),
                          ElevatedButton(
                              onPressed: () {}, child: const Text('Procurar')),
                          const Text(
                            'Config',
                            style: TextStyle(fontSize: 30),
                          ),
                          objetoConfig == null
                              ? const Text('')
                              : Text('Nome: ${objetoConfig!.texto}'),
                          ElevatedButton(
                            onPressed: () {
                              store.getAlterarConfig();
                              //setState(() {});
                            },
                            child: const Text('Voltar'),
                          ),
                        ],
                      ),
                    )
            ],
          ),
        );
      },
    );
  }

  GestureDetector EntradaTeste(BuildContext context) {
    return GestureDetector(
      // UM TOQUE PLAY MÚSICA
      onTap: () {
        setState(() {
          if (canto.entrada.isPlaying == null ||
              canto.entrada.isPlaying == false) {
            canto.entrada.icon = Icons.stop;
            canto.entrada.cor = Colors.indigo.shade200;
            canto.entrada.isPlaying = true;
            Comandos().playMusic(playerEntrada, 'Entrada');
          } else {
            Comandos().stopMusic(playerEntrada);
            canto.entrada.icon = Icons.play_arrow;
            canto.entrada.cor = Colors.amber;
            canto.entrada.isPlaying = false;
          }
          isPlayingEntrada = !isPlayingEntrada;
        });
      },

      // ARRASTAR PARA CIMA EDITA O PAD

      onVerticalDragStart: (details) {
        if (isPlayingEntrada != true) {
          print('Entrei no config');
          store.getAlterarConfig();
          objetoConfig = PadMissa(
              texto: canto.entrada.texto,
              icon: canto.entrada.icon,
              cor: canto.entrada.cor,
              isPlaying: false);

          print('deu certo vertical');
        } else {
          print('Não entrei no config');
        }
      },

      // SEGURAR PARA ENTRAR NA GRAVAÇÃO
      onLongPress: () {
        if (isPlayingEntrada != true) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TelaGravacao(
                    title: 'TelaGravação - ${canto.entrada.texto}',
                    tipoMusica: 'Entrada')),
          );
          print('gravação iniciada');
        } else {
          print('Não pode gravar');
        }
      },

      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(color: canto.entrada.cor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(canto.entrada.icon),
            Text(canto.entrada.texto),
          ],
        ),
      ),
    );
  }
}
