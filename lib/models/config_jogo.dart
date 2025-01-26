import 'dart:convert';
import 'package:flutter/services.dart';

class Figura {
  final String imagePath;
  final String titulo;
  final String historia;
  final List<String> curiosidades;

  Figura({
    required this.imagePath,
    required this.titulo,
    required this.historia,
    required this.curiosidades,
  });

  factory Figura.fromJson(Map<String, dynamic> json) {
    return Figura(
      imagePath: json['imagePath'],
      titulo: json['titulo'],
      historia: json['historia'],
      curiosidades: List<String>.from(json['curiosidades']),
    );
  }
}

class ConfigJogo {
  static const niveis = [4, 16, 20, 24, 28];
  static const cardOpcoes = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14];

  static List<Figura> figuras = [];

  static Future<void> carregarFiguras() async {
    final String response = await rootBundle.loadString('assets/json/img_data.json');
    final List<dynamic> data = json.decode(response);
    figuras = data.map((json) => Figura.fromJson(json)).toList();
  }

  static int gameBoardAxisCount(int nivel) {
    if (nivel <= 16) {
      return 4;
    } else if (nivel == 24 || nivel == 28) {
      return 4;
    } else {
      return 5;
    }
  }
}