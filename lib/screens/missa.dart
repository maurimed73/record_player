import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:record_player/models/padMissa.dart';

class MissaSamples extends StatefulWidget {
  const MissaSamples({super.key});

  @override
  State<MissaSamples> createState() => _MissaSamplesState();
}

class _MissaSamplesState extends State<MissaSamples> {
  late AudioPlayer audioPlayer;
  String audioPath =
      "/data/user/0/com.example.record_player/app_flutter/teste4.m4a";

  List<String> listaSamples = [
    "",
    "",
    "",
  ];

  @override
  void initState() {
    audioPlayer = AudioPlayer();

    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  PadMissa entrada =
      PadMissa(texto: 'Entrada', icon: Icons.play_arrow, cor: Colors.amber);
  PadMissa Ato =
      PadMissa(texto: 'Ato', icon: Icons.play_arrow, cor: Colors.amber);
  PadMissa Gloria =
      PadMissa(texto: 'Glória', icon: Icons.play_arrow, cor: Colors.amber);
  PadMissa Salmo =
      PadMissa(texto: 'Salmo', icon: Icons.play_arrow, cor: Colors.amber);
  PadMissa Aclamacao =
      PadMissa(texto: 'Aclamação', icon: Icons.play_arrow, cor: Colors.amber);
  PadMissa Ofertorio =
      PadMissa(texto: 'Ofertório', icon: Icons.play_arrow, cor: Colors.amber);
  PadMissa Santo =
      PadMissa(texto: 'Santo', icon: Icons.play_arrow, cor: Colors.amber);
  PadMissa Cordeiro =
      PadMissa(texto: 'Cordeiro', icon: Icons.play_arrow, cor: Colors.amber);
  PadMissa Comunhao1 =
      PadMissa(texto: 'Comunhão ', icon: Icons.play_arrow, cor: Colors.amber);
  PadMissa Comunhao2 =
      PadMissa(texto: 'Comunhão', icon: Icons.play_arrow, cor: Colors.amber);
  PadMissa Final =
      PadMissa(texto: 'Final', icon: Icons.play_arrow, cor: Colors.amber);
  PadMissa opcional =
      PadMissa(texto: 'Opcional', icon: Icons.play_arrow, cor: Colors.amber);
  PadMissa? objetoConfig;
  bool config = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Página de samples Missa',
          textAlign: TextAlign.center,
        ),
      ),
      body: Stack(
        children: [
          config
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
                        // UM TOQUE PLAY MÚSICA
                        onTap: () {
                          setState(() {
                            entrada.icon == Icons.play_arrow
                                ? entrada.icon = Icons.stop
                                : entrada.icon = Icons.play_arrow;

                            entrada.cor == Colors.amber
                                ? entrada.cor = Colors.green
                                : entrada.cor = Colors.amber;
                          });
                        },
                        // ARRASTA PARA CIMA EDITA O PAD
                        onVerticalDragStart: (details) {
                          setState(() {
                            config = false;
                            objetoConfig = PadMissa(
                                texto: entrada.texto,
                                icon: entrada.icon,
                                cor: entrada.cor);
                          });

                          print('deu certo vertical');
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
                      ),
                      //Ato
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Ato.icon == Icons.play_arrow
                                ? Ato.icon = Icons.stop
                                : Ato.icon = Icons.play_arrow;

                            Ato.cor == Colors.amber
                                ? Ato.cor = Colors.green
                                : Ato.cor = Colors.amber;
                          });
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(color: Ato.cor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Ato.icon),
                              Text(Ato.texto),
                            ],
                          ),
                        ),
                      ),
                      //Glória
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Gloria.icon == Icons.play_arrow
                                ? Gloria.icon = Icons.stop
                                : Gloria.icon = Icons.play_arrow;

                            Gloria.cor == Colors.amber
                                ? Gloria.cor = Colors.green
                                : Gloria.cor = Colors.amber;
                          });
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(color: Gloria.cor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Gloria.icon),
                              Text(Gloria.texto),
                            ],
                          ),
                        ),
                      ),
                      //Salmo
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Salmo.icon == Icons.play_arrow
                                ? Salmo.icon = Icons.stop
                                : Salmo.icon = Icons.play_arrow;

                            Salmo.cor == Colors.amber
                                ? Salmo.cor = Colors.green
                                : Salmo.cor = Colors.amber;
                          });
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(color: Salmo.cor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Salmo.icon),
                              Text(Salmo.texto),
                            ],
                          ),
                        ),
                      ),
                      //Aclamação
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Aclamacao.icon == Icons.play_arrow
                                ? Aclamacao.icon = Icons.stop
                                : Aclamacao.icon = Icons.play_arrow;

                            Aclamacao.cor == Colors.amber
                                ? Aclamacao.cor = Colors.green
                                : Aclamacao.cor = Colors.amber;
                          });
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(color: Aclamacao.cor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Aclamacao.icon),
                              Text(Aclamacao.texto),
                            ],
                          ),
                        ),
                      ),
                      //Ofertório
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Ofertorio.icon == Icons.play_arrow
                                ? Ofertorio.icon = Icons.stop
                                : Ofertorio.icon = Icons.play_arrow;

                            Ofertorio.cor == Colors.amber
                                ? Ofertorio.cor = Colors.green
                                : Ofertorio.cor = Colors.amber;
                          });
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(color: Ofertorio.cor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Ofertorio.icon),
                              Text(Ofertorio.texto),
                            ],
                          ),
                        ),
                      ),
                      //Santo
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Santo.icon == Icons.play_arrow
                                ? Santo.icon = Icons.stop
                                : Santo.icon = Icons.play_arrow;

                            Santo.cor == Colors.amber
                                ? Santo.cor = Colors.green
                                : Santo.cor = Colors.amber;
                          });
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(color: Santo.cor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Santo.icon),
                              Text(Santo.texto),
                            ],
                          ),
                        ),
                      ),
                      //Cordeiro
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Cordeiro.icon == Icons.play_arrow
                                ? Cordeiro.icon = Icons.stop
                                : Cordeiro.icon = Icons.play_arrow;

                            Cordeiro.cor == Colors.amber
                                ? Cordeiro.cor = Colors.green
                                : Cordeiro.cor = Colors.amber;
                          });
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(color: Cordeiro.cor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Cordeiro.icon),
                              Text(Cordeiro.texto),
                            ],
                          ),
                        ),
                      ),
                      //Comunhão 1
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Comunhao1.icon == Icons.play_arrow
                                ? Comunhao1.icon = Icons.stop
                                : Comunhao1.icon = Icons.play_arrow;

                            Comunhao1.cor == Colors.amber
                                ? Comunhao1.cor = Colors.green
                                : Comunhao1.cor = Colors.amber;
                          });
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(color: Comunhao1.cor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Comunhao1.icon),
                              Text(Comunhao1.texto),
                            ],
                          ),
                        ),
                      ),
                      //Comunhão 2
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Comunhao2.icon == Icons.play_arrow
                                ? Comunhao2.icon = Icons.stop
                                : Comunhao2.icon = Icons.play_arrow;

                            Comunhao2.cor == Colors.amber
                                ? Comunhao2.cor = Colors.green
                                : Comunhao2.cor = Colors.amber;
                          });
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(color: Comunhao2.cor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Comunhao2.icon),
                              Text(Comunhao2.texto),
                            ],
                          ),
                        ),
                      ),
                      //Final
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Final.icon == Icons.play_arrow
                                ? Final.icon = Icons.stop
                                : Final.icon = Icons.play_arrow;

                            Final.cor == Colors.amber
                                ? Final.cor = Colors.green
                                : Final.cor = Colors.amber;
                          });
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(color: Final.cor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Final.icon),
                              Text(Final.texto),
                            ],
                          ),
                        ),
                      ),
                      //opcional
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            opcional.icon == Icons.play_arrow
                                ? opcional.icon = Icons.stop
                                : opcional.icon = Icons.play_arrow;

                            opcional.cor == Colors.amber
                                ? opcional.cor = Colors.green
                                : opcional.cor = Colors.amber;
                          });
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(color: opcional.cor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(opcional.icon),
                              Text(opcional.texto),
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
                          setState(() {
                            config = true;
                          });
                        },
                        child: Text('Voltar'),
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }

  Future<void> _playing(index) async {
    try {
      Source urlSource = UrlSource(listaSamples[index]);
      await audioPlayer.play(urlSource);
    } catch (e) {
      print('Error Play audio: $e');
    }
  }
}
