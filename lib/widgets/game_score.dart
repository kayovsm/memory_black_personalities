import 'package:flutter/material.dart';
import 'package:memory_black_personalities/constantes.dart';
import 'package:memory_black_personalities/view_models/game_view_model.dart';
import 'package:provider/provider.dart';

class GameScore extends StatelessWidget {
  final Modo modo;

  const GameScore({
    super.key,
    required this.modo,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<GameViewModel>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(modo == Modo.dificil
                ? Icons.my_location
                : Icons.touch_app_rounded),
            const SizedBox(width: 10),
            Text(
              controller.score.toString(),
              style: const TextStyle(fontSize: 25),
            ),
          ],
        ),
        Image.asset(
          'imagens/logo.jpeg',
          width: 38,
          height: 38,
        ),
        TextButton(
          child: const Text(
            'Sair',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
