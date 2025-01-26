import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memory_black_personalities/models/constantes.dart';
import 'package:memory_black_personalities/models/game_play.dart';
import 'package:memory_black_personalities/tema.dart';
import 'package:memory_black_personalities/views/game_page.dart';

import '../view_models/game_view_model.dart';

class NivelJogo extends StatelessWidget {
  final GamePlay gamePlay;

  const NivelJogo({
    super.key,
    required this.gamePlay,
  });

  void startGame() {
    final GameController controller = Get.put(GameController());
    controller.startGame(gamePlay: gamePlay);
    Get.to(() => GamePage(gamePlay: gamePlay));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: startGame,
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Container(
        width: 90,
        height: 90,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: gamePlay.modo == Modo.normal ? Colors.white : TemaJogo.color,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: gamePlay.modo == Modo.normal
              ? Colors.transparent
              : TemaJogo.color.withOpacity(.6),
        ),
        child: Center(
          child: Text(
            gamePlay.nivel.toString(),
            style: const TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
