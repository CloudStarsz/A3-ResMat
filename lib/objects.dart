import 'package:flutter/material.dart';

class CsStyle {
  static const TextStyle caminho = TextStyle(
    fontSize: 24,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle descricao = TextStyle(
    fontSize: 16,
    color: Colors.white,
  );
}

class GraphPositions {

  final double x;
  final double y;
  GraphPositions({required this.x, required this.y});

}



List<double> valoresCarga (double carga){
  return [carga, carga];
}