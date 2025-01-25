import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:memory_black_personalities/models/config_jogo.dart';
import 'package:memory_black_personalities/constantes.dart';
import 'package:memory_black_personalities/models/game_play.dart';
import 'package:memory_black_personalities/models/opcao_jogo.dart';
import 'package:memory_black_personalities/view_models/game_view_model.dart';
import 'package:memory_black_personalities/widgets/card_game.dart';
import 'package:memory_black_personalities/widgets/feedback_game.dart';
import 'package:memory_black_personalities/widgets/game_score.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {
  final GamePlay gamePlay;

  const GamePage({
    super.key,
    required this.gamePlay,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GameViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: GameScore(modo: gamePlay.modo),
      ),
      body: Observer(
        builder: (_) {
          if (controller.venceu) {
            return const FeedbackGame(resultado: Resultado.aprovado);
          } else if (controller.perdeu) {
            return const FeedbackGame(resultado: Resultado.eliminado);
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
