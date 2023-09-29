import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:record_player/screens/telaGravacao.dart';
import 'package:record_player/painelComandos/comandos.dart';
import 'package:record_player/screens/missa.dart';
import 'dart:io' as io;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Record Player',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(),
        useMaterial3: false,
      ),
      home: const MissaSamples(),
      //home: const MyHomePage(),

      //home: MusicaEntrada(title: 'Meu Estudo', tipoMusica: 'Entrada'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AudioPlayer audioPlayer;
  late Record audioRecord;
  bool isRecording = false;
  String audioPath = '';

  //Declare Globaly
  late String directory;
  List file = [];

  void _listofFiles() async {
    directory = "/storage/emulated/0/Android/data/"; //Give your folder path
    setState(() {
      file =
          io.Directory("///data/user/0/com.example.record_player/app_flutter/")
              .listSync(); //use your folder name insted of resume.
    });
  }

  @override
  void initState() {
    _listofFiles();
    audioPlayer = AudioPlayer();
    audioRecord = Record();
    super.initState();
  }

  @override
  void dispose() {
    audioRecord.dispose();
    audioPlayer.dispose();
    super.dispose();
  }

  TextEditingController tipoMusica = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Recorder'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: tipoMusica,
            ),
            if (isRecording)
              const Text(
                'Recording in Progress',
                style: TextStyle(fontSize: 20),
              ),

            // botão de gravação
            ElevatedButton(
              onPressed: () {
                if (isRecording) {
                  Comandos().stopRecording();
                  //stopRecording();
                  setState(() {
                    isRecording = false;
                  });
                } else {
                  //startRecording(tipoMusica.text.toString());
                  setState(() {
                    isRecording = true;
                  });
                  Comandos().startRec(tipoMusica.text.toString());
                }
              },
              child: isRecording
                  ? const Text('Stop Recording')
                  : const Text('Start Recording'),
            ),

            SizedBox(
              height: 25,
            ),
            if (!isRecording && audioPath != null)

              // botão de tocar gravação
              ElevatedButton(
                onPressed: () {
                  Comandos().playMusic(audioPlayer, 'Entrada');
                },
                child: const Text('Play Recording'),
              ),

            SizedBox(
              height: 25,
            ),

            // botão de listar arquivos
            ElevatedButton(
              onPressed: () async {
                //Criar diretório
                final Directory extDir =
                    await getApplicationDocumentsDirectory();
                final String dirPath = '${extDir.path}/Missa1';

                await new Directory(dirPath).create(recursive: true);
                // final String filePath = '$dirPath.mp4';
                // print(filePath);

                //Deletar diretório
                // final direc = Directory(
                //     'data/user/0/com.example.record_player/app_flutter/dir');
                // direc.deleteSync(recursive: true);

                //listar diretório
                var dir = Directory(
                    'data/user/0/com.example.record_player/app_flutter');
                try {
                  var dirList = dir.list();
                  await for (final FileSystemEntity f in dirList) {
                    if (f is File) {
                      print('PATH ${f.path}');
                      audioPath = f.path;
                    } else if (f is Directory) {
                      print('Diretório encontrado ${f.path}');
                    }
                  }

                  // Apagar items do diretório
                  // await for (final FileSystemEntity f in dirList) {
                  //   if (f is File) {
                  //     f.delete();
                  //     print('Found file ${f.path}');
                  //   }
                  // }
                  // ;

                  // listar somente nome do arquivo no diretório
                  File arquivo = new File(audioPath);
                  String fileName = arquivo.path.split('/').last;
                  print('o arquivo é o  $fileName');
                } catch (e) {
                  print(e.toString());
                }
              },
              child: Text('procurar audio'),
            ),
          ],
        ),
      ),
    );
  }
}
