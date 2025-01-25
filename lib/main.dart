import 'package:flutter/material.dart';
import 'package:memory_black_personalities/tema.dart';
import 'package:memory_black_personalities/view_models/game_view_model.dart';
import 'package:memory_black_personalities/views/tela_inicial.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameViewModel()),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animes Memory',
      debugShowCheckedModeBanner: false,
      theme: TemaJogo.tema,
      home: const TelaInicial(),
    );
  }
}
