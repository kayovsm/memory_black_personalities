import 'package:get/get.dart';
import 'package:memory_black_personalities/models/config_jogo.dart';
import 'package:memory_black_personalities/models/game_play.dart';
import 'package:memory_black_personalities/models/opcao_jogo.dart';
import 'dart:async';

class GameController extends GetxController {
  var gameCard = <OpcaoJogo>[].obs;
  var score = 0.obs;
  var venceu = false.obs;
  var perdeu = false.obs;
  var remainingTime = 60.obs;
  Timer? _timer;
  var figurasAcertadas = <OpcaoJogo>[].obs;

  late GamePlay gamePlay;
  List<OpcaoJogo> _cartaEscolhida = [];
  List<Function> _escolhaIgual = [];
  int _acertos = 0;
  int _numPares = 0;

  bool get jogadaCompleta => (_cartaEscolhida.length == 2);

  void startGame({required GamePlay gamePlay}) {
    this.gamePlay = gamePlay;
    _acertos = 0;
    _numPares = (gamePlay.nivel / 2).round();
    venceu.value = false;
    perdeu.value = false;
    remainingTime.value = 60;
    figurasAcertadas.clear();

    _resetScore();
    _gerarCard();
    _startTimer();
  }

  void _resetScore() {
    score.value = 0;
  }

  void _gerarCard() {
    int maxOpcoes = ConfigJogo.figuras.length;
    List<int> cardOpocoes = ConfigJogo.cardOpcoes.sublist(0, maxOpcoes)
      ..shuffle();
    cardOpocoes = cardOpocoes.sublist(0, _numPares);

    gameCard.value = [...cardOpocoes, ...cardOpocoes].map((opcao) {
      final figura = ConfigJogo.figuras[opcao - 1];
      return OpcaoJogo(
          opcao: opcao, cardIgual: false, selecionado: false, figura: figura);
    }).toList();
    gameCard.shuffle();
  }

  void escolher(OpcaoJogo opcao, Function resetCard) async {
    opcao.selecionado = true;
    _cartaEscolhida.add(opcao);
    _escolhaIgual.add(resetCard);

    await _compararEscolha();
  }

  Future<void> _compararEscolha() async {
    if (jogadaCompleta) {
      if (_cartaEscolhida[0].opcao == _cartaEscolhida[1].opcao) {
        _acertos++;
        _cartaEscolhida[0].cardIgual = true;
        _cartaEscolhida[1].cardIgual = true;
        figurasAcertadas.add(_cartaEscolhida[0]);
        _addTime(5); // Adiciona 5 segundos ao cronômetro
      } else {
        await Future.delayed(const Duration(seconds: 1), () {
          for (var i in [0, 1]) {
            _cartaEscolhida[i].selecionado = false;
            _escolhaIgual[i]();
          }
        });
      }
      _resetJogada();
      _updateScore();
      _checarResultado();
    }
  }

  Future<void> _checarResultado() async {
    bool allMatched = _acertos == _numPares;
    if (allMatched) {
      venceu.value = true;
      _stopTimer();
      print("Jogo vencido!");
    }
  }

  void _resetJogada() {
    _cartaEscolhida = [];
    _escolhaIgual = [];
  }

  void _updateScore() {
    score.value++;
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        perdeu.value = true;
        _stopTimer();
        print("Tempo esgotado! Jogo perdido!");
      }
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _addTime(int seconds) {
    remainingTime.value += seconds;
  }

  void reiniciarJogo() {
    startGame(gamePlay: gamePlay);
  }

  void proximoNivel() {
    int nivelIndex = 0;

    if (gamePlay.nivel != ConfigJogo.niveis.last) {
      nivelIndex = ConfigJogo.niveis.indexOf(gamePlay.nivel) + 1;
    }

    gamePlay.nivel = ConfigJogo.niveis[nivelIndex];
    startGame(gamePlay: gamePlay);
  }
}
