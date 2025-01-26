import 'config_jogo.dart';

class OpcaoJogo {
  int opcao;
  bool cardIgual;
  bool selecionado;
  Figura figura;

  OpcaoJogo({
    required this.opcao,
    required this.cardIgual,
    required this.selecionado,
    required this.figura,
  });
}
