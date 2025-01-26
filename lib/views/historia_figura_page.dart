import 'package:flutter/material.dart';

import '../models/config_jogo.dart';

class HistoriaFigura extends StatelessWidget {
  final Figura figura;

  const HistoriaFigura({super.key, required this.figura});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('História da Figura'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset(figura.imagePath)),
              const SizedBox(height: 16),
              Text(
                figura.historia,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
