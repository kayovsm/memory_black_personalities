// import 'dart:convert';
// import 'package:flutter/services.dart';

// class Figura {
//   final String imagePath;
//   final String historia;
//   final List<String> curiosidades;

//   Figura({
//     required this.imagePath,
//     required this.historia,
//     required this.curiosidades,
//   });

//   factory Figura.fromJson(Map<String, dynamic> json) {
//     return Figura(
//       imagePath: json['imagePath'],
//       historia: json['historia'],
//       curiosidades: List<String>.from(json['curiosidades']),
//     );
//   }
// }

// class ConfigJogo {
//   static List<Figura> figuras = [];

//   static Future<void> carregarFiguras() async {
//     final String response = await rootBundle.loadString('assets/img.json');
//     final List<dynamic> data = json.decode(response);
//     figuras = data.map((json) => Figura.fromJson(json)).toList();
//   }
// }
