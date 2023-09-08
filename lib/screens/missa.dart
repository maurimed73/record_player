import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:record_player/models/padMissa.dart';
import 'package:record_player/painelComandos/botoesMissa/aclamacao.dart';
import 'package:record_player/painelComandos/botoesMissa/ato.dart';
import 'package:record_player/painelComandos/botoesMissa/entrada.dart';
import 'package:record_player/painelComandos/botoesMissa/gloria.dart';
import 'package:record_player/painelComandos/botoesMissa/salmo.dart';
import 'package:record_player/estado/gerencia_estado.dart';
import 'package:record_player/Data/dadosMissa.dart';

class MissaSamples extends StatefulWidget {
  const MissaSamples({super.key});

  @override
  State<MissaSamples> createState() => _MissaSamplesState();
}

class _MissaSamplesState extends State<MissaSamples> {
  final audio = AudioPlayer();
  final playerEntrada = AudioPlayer();

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
  String audioPath =
      "/data/user/0/com.example.record_player/app_flutter/teste4.m4a";

  List<String> listaSamples = [
    "",
    "",
    "",
  ];

  final store = MissaStore();
  final canto = DadosPadMissa();

  @override
  void initState() {
    super.initState();
    store.config = true;
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

  @override
  Widget build(BuildContext context) {
    print('Começou novamente');
    print('valor do config: ${store.config}');
    return ListenableBuilder(
      listenable: store,
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Página de samples Missa',
              textAlign: TextAlign.center,
            ),
          ),
          body: Stack(
            children: [
              store.config
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 5),
                        children: [
                          //Entrada
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (canto.entrada.isPlaying == null ||
                                    canto.entrada.isPlaying == false) {
                                  canto.entrada.icon = Icons.stop;
                                  canto.entrada.cor = Colors.green;
                                  canto.entrada.isPlaying = true;

                                  playerEntrada.play(DeviceFileSource(
                                      '/data/user/0/com.example.record_player/app_flutter/Entrada.m4a'));
                                } else {
                                  playerEntrada.stop();
                                  canto.entrada.icon = Icons.play_arrow;
                                  canto.entrada.cor = Colors.amber;
                                  canto.entrada.isPlaying = false;
                                }
                                isPlayingEntrada = !isPlayingEntrada;
                              });
                            },
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
                                  canto.Ato.cor = Colors.green;
                                  canto.Ato.isPlaying = true;

                                  playerAto.play(DeviceFileSource(
                                      '/data/user/0/com.example.record_player/app_flutter/Ato.m4a'));
                                } else {
                                  playerAto.stop();
                                  canto.Ato.icon = Icons.play_arrow;
                                  canto.Ato.cor = Colors.amber;
                                  canto.Ato.isPlaying = false;
                                }
                                isPlayingAto = !isPlayingAto;
                              });
                            },
                            // ARRASTA PARA CIMA EDITA O PAD
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
                                  canto.Gloria.cor = Colors.green;
                                  canto.Gloria.isPlaying = true;

                                  playerGloria.play(DeviceFileSource(
                                      '/data/user/0/com.example.record_player/app_flutter/Ato.m4a'));
                                } else {
                                  playerGloria.stop();
                                  canto.Gloria.icon = Icons.play_arrow;
                                  canto.Gloria.cor = Colors.amber;
                                  canto.Gloria.isPlaying = false;
                                }
                                isPlayingGloria = !isPlayingGloria;
                              });
                            },
                            // ARRASTA PARA CIMA EDITA O PAD
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
                                  canto.Salmo.cor = Colors.green;
                                  canto.Salmo.isPlaying = true;

                                  playerSalmo.play(DeviceFileSource(
                                      '/data/user/0/com.example.record_player/app_flutter/Ato.m4a'));
                                } else {
                                  playerSalmo.stop();
                                  canto.Salmo.icon = Icons.play_arrow;
                                  canto.Salmo.cor = Colors.amber;
                                  canto.Salmo.isPlaying = false;
                                }
                                isPlayingSalmo = !isPlayingSalmo;
                              });
                            },
                            // ARRASTA PARA CIMA EDITA O PAD
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
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(color: canto.Salmo.cor),
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
                                  canto.Aclamacao.cor = Colors.green;
                                  canto.Aclamacao.isPlaying = true;

                                  playerAcla.play(DeviceFileSource(
                                      '/data/user/0/com.example.record_player/app_flutter/Ato.m4a'));
                                } else {
                                  playerAcla.stop();
                                  canto.Aclamacao.icon = Icons.play_arrow;
                                  canto.Aclamacao.cor = Colors.amber;
                                  canto.Aclamacao.isPlaying = false;
                                }
                                isPlayingAclamacao = !isPlayingAclamacao;
                              });
                            },
                            // ARRASTA PARA CIMA EDITA O PAD
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
                            onTap: () {
                              setState(() {
                                if (canto.Ofertorio.isPlaying == null ||
                                    canto.Ofertorio.isPlaying == false) {
                                  canto.Ofertorio.icon = Icons.stop;
                                  canto.Ofertorio.cor = Colors.green;
                                  canto.Ofertorio.isPlaying = true;

                                  playerOfertorio.play(DeviceFileSource(
                                      '/data/user/0/com.example.record_player/app_flutter/Ato.m4a'));
                                } else {
                                  playerOfertorio.stop();
                                  canto.Ofertorio.icon = Icons.play_arrow;
                                  canto.Ofertorio.cor = Colors.amber;
                                  canto.Ofertorio.isPlaying = false;
                                }
                                isPlayingOfertorio = !isPlayingOfertorio;
                              });
                            },
                            // ARRASTA PARA CIMA EDITA O PAD
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
                            onTap: () {
                              setState(() {
                                if (canto.Santo.isPlaying == null ||
                                    canto.Santo.isPlaying == false) {
                                  canto.Santo.icon = Icons.stop;
                                  canto.Santo.cor = Colors.green;
                                  canto.Santo.isPlaying = true;

                                  playerSanto.play(DeviceFileSource(
                                      '/data/user/0/com.example.record_player/app_flutter/Ato.m4a'));
                                } else {
                                  playerSanto.stop();
                                  canto.Santo.icon = Icons.play_arrow;
                                  canto.Santo.cor = Colors.amber;
                                  canto.Santo.isPlaying = false;
                                }
                                isPlayingSanto = !isPlayingSanto;
                              });
                            },
                            // ARRASTA PARA CIMA EDITA O PAD
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
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(color: canto.Santo.cor),
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
                            onTap: () {
                              setState(() {
                                if (canto.Cordeiro.isPlaying == null ||
                                    canto.Cordeiro.isPlaying == false) {
                                  canto.Cordeiro.icon = Icons.stop;
                                  canto.Cordeiro.cor = Colors.green;
                                  canto.Cordeiro.isPlaying = true;

                                  playerCordeiro.play(DeviceFileSource(
                                      '/data/user/0/com.example.record_player/app_flutter/Ato.m4a'));
                                } else {
                                  playerCordeiro.stop();
                                  canto.Cordeiro.icon = Icons.play_arrow;
                                  canto.Cordeiro.cor = Colors.amber;
                                  canto.Cordeiro.isPlaying = false;
                                }
                                isPlayingCordeiro = !isPlayingCordeiro;
                              });
                            },
                            // ARRASTA PARA CIMA EDITA O PAD
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
                            onTap: () {
                              setState(() {
                                if (canto.Comunhao1.isPlaying == null ||
                                    canto.Comunhao1.isPlaying == false) {
                                  canto.Comunhao1.icon = Icons.stop;
                                  canto.Comunhao1.cor = Colors.green;
                                  canto.Comunhao1.isPlaying = true;

                                  playerComunhao.play(DeviceFileSource(
                                      '/data/user/0/com.example.record_player/app_flutter/Ato.m4a'));
                                } else {
                                  playerComunhao.stop();
                                  canto.Comunhao1.icon = Icons.play_arrow;
                                  canto.Comunhao1.cor = Colors.amber;
                                  canto.Comunhao1.isPlaying = false;
                                }
                                isPlayingComunhao = !isPlayingComunhao;
                              });
                            },
                            // ARRASTA PARA CIMA EDITA O PAD
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
                            onTap: () {
                              setState(() {
                                if (canto.Comunhao2.isPlaying == null ||
                                    canto.Comunhao2.isPlaying == false) {
                                  canto.Comunhao2.icon = Icons.stop;
                                  canto.Comunhao2.cor = Colors.green;
                                  canto.Comunhao2.isPlaying = true;

                                  playerComunhao2.play(DeviceFileSource(
                                      '/data/user/0/com.example.record_player/app_flutter/Ato.m4a'));
                                } else {
                                  playerComunhao2.stop();
                                  canto.Comunhao2.icon = Icons.play_arrow;
                                  canto.Comunhao2.cor = Colors.amber;
                                  canto.Comunhao2.isPlaying = false;
                                }
                                isPlayingComunhao2 = !isPlayingComunhao2;
                              });
                            },
                            // ARRASTA PARA CIMA EDITA O PAD
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
                            onTap: () {
                              setState(() {
                                if (canto.Final.isPlaying == null ||
                                    canto.Final.isPlaying == false) {
                                  canto.Final.icon = Icons.stop;
                                  canto.Final.cor = Colors.green;
                                  canto.Final.isPlaying = true;

                                  playerFinal.play(DeviceFileSource(
                                      '/data/user/0/com.example.record_player/app_flutter/Ato.m4a'));
                                } else {
                                  playerFinal.stop();
                                  canto.Final.icon = Icons.play_arrow;
                                  canto.Final.cor = Colors.amber;
                                  canto.Final.isPlaying = false;
                                }
                                isPlayingFinal = !isPlayingFinal;
                              });
                            },
                            // ARRASTA PARA CIMA EDITA O PAD
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
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(color: canto.Final.cor),
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
                            onTap: () {
                              setState(() {
                                if (canto.opcional.isPlaying == null ||
                                    canto.opcional.isPlaying == false) {
                                  canto.opcional.icon = Icons.stop;
                                  canto.opcional.cor = Colors.green;
                                  canto.opcional.isPlaying = true;

                                  playerOpcional.play(DeviceFileSource(
                                      '/data/user/0/com.example.record_player/app_flutter/Ato.m4a'));
                                } else {
                                  playerOpcional.stop();
                                  canto.opcional.icon = Icons.play_arrow;
                                  canto.opcional.cor = Colors.amber;
                                  canto.opcional.isPlaying = false;
                                }
                                isPlayingOpcional = !isPlayingOpcional;
                              });
                            },
                            // ARRASTA PARA CIMA EDITA O PAD
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
                    )
                  : Container(
                      height: 300,
                      width: 500,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Config',
                            style: TextStyle(fontSize: 30),
                          ),
                          objetoConfig == null
                              ? Text('')
                              : Text('Nome: ${objetoConfig!.texto}'),
                          ElevatedButton(
                            onPressed: () {
                              store.getAlterarConfig();
                              setState(() {});
                            },
                            child: Text('Voltar'),
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
}
