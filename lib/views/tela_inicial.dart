import 'package:flutter/material.dart';
import 'package:memory_black_personalities/views/modo_jogo.dart';
import 'package:memory_black_personalities/tema.dart';
import 'package:memory_black_personalities/widgets/botao.dart';
import 'package:memory_black_personalities/widgets/logo.dart';
import 'package:memory_black_personalities/widgets/nivel_jogo.dart';
import 'package:memory_black_personalities/constantes.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Logo(),
            BotaoIniciar(
              titulo: 'Modo Normal',
              color: Colors.white,
              acaoClique: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const ModoJogo(modo: Modo.normal),
                ),
              ),
            ),
            BotaoIniciar(
              titulo: 'Modo Dificil',
              color: TemaJogo.color,
              acaoClique: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const ModoJogo(modo: Modo.dificil),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
