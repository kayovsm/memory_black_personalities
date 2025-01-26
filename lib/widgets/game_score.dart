import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memory_black_personalities/models/constantes.dart';
import 'package:memory_black_personalities/views/tela_inicial.dart';

import '../view_models/game_view_model.dart';

class GameScore extends StatelessWidget {
  final Modo modo;

  const GameScore({
    super.key,
    required this.modo,
  });

  @override
  Widget build(BuildContext context) {
    final GameController controller = Get.find();

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
            Obx(() => Text(
              '${controller.remainingTime.value}s',
              style: const TextStyle(fontSize: 25),
            )),
          ],
        ),
        Image.asset(
          'assets/img/logo.jpeg',
          width: 38,
          height: 38,
        ),
        TextButton(
          child: const Text(
            'Sair',
            style: TextStyle(fontSize: 18),
          ),
          onPressed: () => Get.offAll(const TelaInicial()),
        ),
      ],
    );
  }
}