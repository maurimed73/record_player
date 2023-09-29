import 'package:mobx/mobx.dart';
import 'package:record_player/models/padMissa.dart';

class ControllerMissa {
  final entradaTocando = Observable<bool>(false);
  late final alterarEntrada = Action(_alterarEntradaPlay);

  _alterarEntradaPlay() {
    entradaTocando.value = !entradaTocando.value;
    if (entradaTocando.value == true) {
      print('Áudio Entrada está tocando');
    } else {
      print('Áudio Entrada está parado');
    }
  }
}
