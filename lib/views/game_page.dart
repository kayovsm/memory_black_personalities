import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memory_black_personalities/models/config_jogo.dart';
import 'package:memory_black_personalities/models/constantes.dart';
import 'package:memory_black_personalities/models/game_play.dart';
import 'package:memory_black_personalities/models/opcao_jogo.dart';
import 'package:memory_black_personalities/widgets/card_game.dart';
import 'package:memory_black_personalities/widgets/feedback_game.dart';
import 'package:memory_black_personalities/widgets/game_score.dart';

import '../view_models/game_view_model.dart';
import '../widgets/botao.dart';

class GamePage extends StatelessWidget {
  final GamePlay gamePlay;

  const GamePage({
    super.key,
    required this.gamePlay,
  });

  @override
  Widget build(BuildContext context) {
    final GameController controller = Get.put(GameController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.startGame(gamePlay: gamePlay);
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: GameScore(modo: gamePlay.modo),
      ),
      body: Obx(
        () {
          if (controller.venceu.value || controller.perdeu.value) {
            print("Exibindo tela de feedback");
            return FeedbackGame(
              resultado: controller.venceu.value ? Resultado.aprovado : Resultado.eliminado,
            );
          } else {
            return Center(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: ConfigJogo.gameBoardAxisCount(gamePlay.nivel),
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                padding: const EdgeInsets.all(24),
                children: controller.gameCard
                    .map((OpcaoJogo opJogo) =>
                        CardGame(modo: gamePlay.modo, opcaoJogo: opJogo))
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}