import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
// import 'package:record/record.dart';

class Comandos {
  final audio = AudioPlayer();
  final recorded = Record();
  bool isRecording = false;
  String audioPath = '';

  Comandos();

  Future<bool> startRec(canto) async {
    String tipo = canto;

    try {
      if (await recorded.hasPermission()) {
        await recorded.start(
            numChannels: 1,
            // path:
            //     '/data/user/0/com.example.record_player/app_flutter/teste4.m4a');
            path:
                '/data/user/0/com.example.record_player/app_flutter/$tipo.m4a');

        return true;
      }
    } catch (e) {
      print('Error Start Recording : $e');
    }
    return false;
  }

  Future<bool> stopRecording() async {
    try {
      String? path = await recorded.stop();
      print(path);
      return false;
    } catch (e) {
      print('Error Stopping Record: $e');
    }
    return false;
  }

  void playMusic(entrada) {
    Source urlSource = UrlSource(
        "/data/user/0/com.example.record_player/app_flutter/Santo.m4a");
    entrada.play(urlSource);
  }

  void stopMusic(paraMusica) {
    paraMusica.stop();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    print('O Diretório é: ${directory.uri}');
    return directory.path;
  }
}
