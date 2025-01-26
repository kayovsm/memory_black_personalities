import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memory_black_personalities/tema.dart';
import 'package:memory_black_personalities/views/tela_inicial.dart';

import 'models/config_jogo.dart';
import 'view_models/game_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigJogo.carregarFiguras();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Animes Memory',
      debugShowCheckedModeBanner: false,
      theme: TemaJogo.tema,
      initialBinding: BindingsBuilder(() {
        Get.put(GameController());
      }),
      home: const TelaInicial(),
    );
  }
}