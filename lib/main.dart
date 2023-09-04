import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:record_player/screens/missa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MissaSamples(),
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

  @override
  void initState() {
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

  Future<void> stopRecording() async {
    try {
      String? path = await audioRecord.stop();
      print(path);
      setState(() {
        isRecording = false;
        audioPath = path!;
      });
    } catch (e) {
      print('Error Stopping Record: $e');
    }
  }

  Future<void> startRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        await audioRecord.start(
            numChannels: 1,
            path:
                '/data/user/0/com.example.record_player/app_flutter/teste4.m4a');
        setState(() {
          isRecording = true;
        });
      }
    } catch (e) {
      print('Error Start Recording : $e');
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    print('O Diretório é: ${directory.uri}');
    return directory.path;
  }

  Future<void> playRecording() async {
    try {
      Source urlSource = UrlSource(
          "/data/user/0/com.example.record_player/app_flutter/teste4.m4a");
      await audioPlayer.play(urlSource);
    } catch (e) {
      print('Error Play audio: $e');
    }
  }

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
            if (isRecording)
              const Text(
                'Recording in Progress',
                style: TextStyle(fontSize: 20),
              ),
            ElevatedButton(
              onPressed: isRecording ? stopRecording : startRecording,
              child: isRecording
                  ? const Text('Stop Recording')
                  : const Text('Start Recording'),
            ),
            SizedBox(
              height: 25,
            ),
            if (!isRecording && audioPath != null)
              ElevatedButton(
                onPressed: playRecording,
                child: const Text('Play Recording'),
              ),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () async {
                var dir = Directory(
                    '///data/user/0/com.example.record_player/app_flutter/');
                try {
                  var dirList = dir.list();
                  await for (final FileSystemEntity f in dirList) {
                    if (f is File) {
                      print('Found file ${f.path}');
                    } else if (f is Directory) {
                      print('Found dir ${f.path}');
                    }
                  }
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
