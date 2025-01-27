import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memory_black_personalities/models/constantes.dart';
import 'package:memory_black_personalities/views/game_page.dart';
import 'package:memory_black_personalities/models/config_jogo.dart';

import '../models/opcao_jogo.dart';
import '../view_models/game_view_model.dart';
import 'botao.dart';

class FeedbackGame extends StatelessWidget {
  final Resultado resultado;
  final OpcaoJogo randomFigura;

  FeedbackGame({
    super.key,
    required this.resultado,
  }) : randomFigura = (Get.find<GameController>().gameCard..shuffle()).first;

  String getResultado() {
    return resultado == Resultado.aprovado ? 'aprovado' : 'eliminado';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        randomFigura.figura.imagePath,
                        scale: 0.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Curiosidade sobre a figura',
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      randomFigura.figura.titulo,
                      style: const TextStyle(fontSize: 23),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      randomFigura.figura.curiosidades.join('\n'),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            resultado == Resultado.eliminado
                ? BotaoIniciar(
                    titulo: 'Tentar Novamente',
                    color: Colors.white,
                    acaoClique: () {
                      Get.find<GameController>().reiniciarJogo();
                      Get.offAll(() => GamePage(
                          gamePlay: Get.find<GameController>().gamePlay));
                    },
                  )
                : BotaoIniciar(
                    titulo: 'Proximo Nivel',
                    color: Colors.white,
                    acaoClique: () {
                      Get.find<GameController>().proximoNivel();
                      Get.offAll(() => GamePage(
                          gamePlay: Get.find<GameController>().gamePlay));
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
