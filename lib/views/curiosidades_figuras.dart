import 'package:flutter/material.dart';
import 'package:memory_black_personalities/models/opcao_jogo.dart';

class CuriosidadesFiguras extends StatelessWidget {
  final List<OpcaoJogo> figuras;

  const CuriosidadesFiguras({super.key, required this.figuras});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Curiosidades das Figuras'),
      ),
      body: ListView.builder(
        itemCount: figuras.length,
        itemBuilder: (context, index) {
          final figura = figuras[index];
          return ListTile(
            leading: Image.asset('imagens/${figura.opcao}.jpeg'),
            title: Text('Figura ${figura.opcao}'),
            subtitle: Text('História da figura ${figura.opcao}.'),
          );
        },
      ),
    );
  }
}