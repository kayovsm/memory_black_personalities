import 'package:flutter/material.dart';
import 'package:memory_black_personalities/models/config_jogo.dart';
import 'package:memory_black_personalities/constantes.dart';
import 'package:memory_black_personalities/models/game_play.dart';
import 'package:memory_black_personalities/models/opcao_jogo.dart';

class GameViewModel extends ChangeNotifier {
  List<OpcaoJogo> gameCard = [];
  int score = 0;
  bool venceu = false;
  bool perdeu = false;

  late GamePlay _gamePlay;
  List<OpcaoJogo> _cartaEscolhida = [];
  List<Function> _escolhaIgual = [];
  int _acertos = 0;
  int _numPares = 0;

  bool get jogadaCompleta => (_cartaEscolhida.length == 2);

  void startGame({required GamePlay gamePlay}) {
    _gamePlay = gamePlay;
    _acertos = 0;
    _numPares = (_gamePlay.nivel / 2).round();
    venceu = false;
    perdeu = false;

    _resetScore();
    _gerarCard();
    notifyListeners();
  }

  void _resetScore() {
    _gamePlay.modo == Modo.normal ? score = 0 : score = _gamePlay.nivel;
  }

  void _gerarCard() {
    List<int> cardOpocoes = ConfigJogo.cardOpcoes.sublist(0)..shuffle();
    cardOpocoes = cardOpocoes.sublist(0, _numPares);
    gameCard = [...cardOpocoes, ...cardOpocoes]
        .map((opcao) =>
            OpcaoJogo(opcao: opcao, cardIgual: false, selecionado: false))
        .toList();
    gameCard.shuffle();
    notifyListeners();
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
      notifyListeners();
    }
  }

  Future<void> _checarResultado() async {
    bool allMatched = _acertos == _numPares;
    if (_gamePlay.modo == Modo.normal) {
      await _checarResultadoNormal(allMatched);
    } else {
      await _checarResultadoDificil(allMatched);
    }
  }

  Future<void> _checarResultadoNormal(bool allMatched) async {
    await Future.delayed(const Duration(seconds: 1), () {
      venceu = allMatched;
      notifyListeners();
    });
  }

  Future<void> _checarResultadoDificil(bool allMatched) async {
    if (_chancesAcabaram()) {
      await Future.delayed(const Duration(seconds: 1), () {
        perdeu = true;
        notifyListeners();
      });
    }
    if (allMatched && score >= 0) {
      await Future.delayed(const Duration(seconds: 1), () {
        venceu = allMatched;
        notifyListeners();
      });
    }
  }

  bool _chancesAcabaram() {
    return score < _numPares - _acertos;
  }

  void _resetJogada() {
    _cartaEscolhida = [];
    _escolhaIgual = [];
  }

  void _updateScore() {
    _gamePlay.modo == Modo.normal ? score++ : score--;
    notifyListeners();
  }

  void reiniciarJogo() {
    startGame(gamePlay: _gamePlay);
  }

  void proximoNivel() {
    int nivelIndex = 0;

    if (_gamePlay.nivel != ConfigJogo.niveis.last) {
      nivelIndex = ConfigJogo.niveis.indexOf(_gamePlay.nivel) + 1;
    }

    _gamePlay.nivel = ConfigJogo.niveis[nivelIndex];
    startGame(gamePlay: _gamePlay);
  }
}
