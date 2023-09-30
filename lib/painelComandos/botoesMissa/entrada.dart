import 'package:flutter/material.dart';
import 'package:record_player/Data/dadosMissa.dart';
import 'package:record_player/estado/gerencia_estado.dart';
import 'package:record_player/models/padMissa.dart';
import 'package:record_player/painelComandos/comandos.dart';
import 'package:record_player/screens/telaGravacao.dart';

class Entrada extends StatefulWidget {
  var isPlaying;
  var player;
  Entrada({super.key, player, isPlaying});

  @override
  State<Entrada> createState() => _EntradaState();
}

class _EntradaState extends State<Entrada> {
  final canto = DadosPadMissa();
  final comandos = Comandos();
  final store = MissaStore();
  PadMissa? objetoConfig;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // UM TOQUE PLAY MÚSICA
      onTap: () {
        setState(() {
          if (canto.entrada.isPlaying == null ||
              canto.entrada.isPlaying == false) {
            canto.entrada.icon = Icons.stop;
            canto.entrada.cor = Colors.indigo.shade200;
            canto.entrada.isPlaying = true;
            Comandos().playMusic(widget.player, 'Entrada');
          } else {
            Comandos().stopMusic(widget.player);
            canto.entrada.icon = Icons.play_arrow;
            canto.entrada.cor = Colors.amber;
            canto.entrada.isPlaying = false;
          }
          widget.isPlaying = !widget.isPlaying;
        });
      },

      // ARRASTAR PARA CIMA EDITA O PAD

      onVerticalDragStart: (details) {
        if (widget.isPlaying != true) {
          print('Entrei no config');
          //store.getAlterarConfig();
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
        if (widget.isPlaying != true) {
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
