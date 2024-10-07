import 'package:flutter/material.dart';
import 'package:teste/objects.dart';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';

class TelaCalculos2 extends StatelessWidget {
  final double comprimento;
  final double largura;
  final double altura;
  final double carga;
  final String message;
  final double maxMoment;
  final double momentInercia;
  final String segurancaM;
  final double fc0k = 4;
  final ft0k = 5.1948;
  final double fvk = 0.6;
  final String segurancaV;

  List<GraphPositions> get graphPositions {
    final data = <double>[carga, (carga * -1)];
    return data
        .mapIndexed(((index, element) =>
            GraphPositions(x: index.toDouble(), y: element)))
        .toList();
  }

  double pesoProprio(double alt, double larg, double compr) {
    double volumeViga = (alt / 100) * (larg / 100) * compr;
    double pesoproprio = volumeViga * 2;
    return pesoproprio;
  }

  const TelaCalculos2({
    Key? key,
    required this.comprimento,
    required this.largura,
    required this.altura,
    required this.carga,
    required this.message,
    required this.maxMoment,
    required this.momentInercia,
    required this.segurancaM,
    required this.segurancaV,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                message,
                style: CsStyle.caminho,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Text('Comprimento da viga: ${comprimento / 100}m',
                  style: const TextStyle(fontSize: 22, color: Colors.white)),
              Text('Altura da viga: ${altura.ceil()}cm',
                  style: const TextStyle(fontSize: 22, color: Colors.white)),
              Text('largura da viga: ${largura.ceil()}cm',
                  style: const TextStyle(fontSize: 22, color: Colors.white)),
              Text('Carga sobre a viga: ${carga * 100}KN/cm',
                  style: const TextStyle(fontSize: 22, color: Colors.white)),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Resistências da madeira C40',
                style: CsStyle.caminho,
              ),
              Text(
                  'Resistência a compressão:\n Fc0k = 40 MPa ou ${fc0k.toString()} KN/cm²',
                  style: const TextStyle(color: Colors.white, fontSize: 22),
                  textAlign: TextAlign.center),
              Text(
                  'Resistência a tração:\n Ft0k = 51,948 MPa ou ${ft0k.toString()} KN/cm²',
                  style: const TextStyle(color: Colors.white, fontSize: 22),
                  textAlign: TextAlign.center),
              Text(
                  'Resistência a cisalhamento:\n Fvk = 6 MPa ou ${fvk.toString()} KN/cm²',
                  style: const TextStyle(color: Colors.white, fontSize: 22),
                  textAlign: TextAlign.center),
              const Text(
                'Valor KMod: 0,7',
                style: TextStyle(color: Colors.white, fontSize: 22),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Tensões Resistentes de calculo',
                style: CsStyle.caminho,
              ),
              Text(
                'valor de cálculo da resistência à compressão paralela às fibras: '
                '\nFc0d = ${(fc0k * 0.7) / 1.4} KN/cm²',
                style: const TextStyle(color: Colors.white, fontSize: 22),
                textAlign: TextAlign.center,
              ),
              Text(
                'valor de cálculo da resistência à tração paralela às fibras: '
                '\nFt0d = ${(ft0k * 0.7 / 1.8).toStringAsFixed(2)} KN/cm²',
                style: const TextStyle(color: Colors.white, fontSize: 22),
                textAlign: TextAlign.center,
              ),
              Text(
                'valor de cálculo da resistência à cisalhamento: '
                '\nFvd = ${(fvk * 0.7 / 1.8).toStringAsFixed(2)} KN/cm²',
                style: const TextStyle(color: Colors.white, fontSize: 22),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              const Text('Diagramas de esforços internos:',
                  style: CsStyle.caminho),
              const Text(
                'Diagrama de momento cortante V:',
                style: CsStyle.descricao,
              ),
              Container(
                  color: Colors.white,
                  child: AspectRatio(
                    aspectRatio: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: LineChart(
                        LineChartData(
                          minX: 0,
                          maxX: comprimento / 100,
                          lineBarsData: [
                            LineChartBarData(
                              color: Colors.black,
                              barWidth: 2,
                              spots: [
                                FlSpot(0, 0),
                                FlSpot(comprimento / 100, 0)
                              ],
                            ),
                            LineChartBarData(
                              barWidth: 2,
                              spots: [
                                FlSpot(0,
                                    ((carga * (comprimento / 100)) / 2) * 1.4),
                                FlSpot(comprimento / 100,
                                    (((carga * comprimento / 100) / 2) * -1.4)),
                              ],
                              isCurved: true,
                              dotData: FlDotData(show: true),
                              belowBarData: BarAreaData(
                                show: true,
                                color: Colors.deepPurpleAccent.withOpacity(0.4),
                                cutOffY: 0,
                                applyCutOffY: true,
                              ),
                              aboveBarData: BarAreaData(
                                show: true,
                                color: Colors.orange.withOpacity(0.6),
                                cutOffY: 0,
                                applyCutOffY: true,
                              ),
                            )
                          ],
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: true),
                              axisNameWidget: const Text(
                                'Comprimento da barra',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
              const SizedBox(height: 20),
              Text(
                'Esforço cortante (Já com coeficiente de ponderação):'
                '\n${(((carga * (comprimento / 100)) / 2) * 1.4).toStringAsFixed(2)}KN/m '
                'ou ${(((carga * comprimento) / 2) * 1.4).toStringAsFixed(2)}KN/cm',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(height: 20),
              const Text(
                'Diagrama de momento fletor M:',
                style: CsStyle.descricao,
              ),
              Container(
                  color: Colors.white,
                  child: AspectRatio(
                    aspectRatio: 2,
                    child: LineChart(
                      LineChartData(
                        titlesData: FlTitlesData(
                          show: true,
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true),
                            axisNameWidget: const Text(
                              'Comprimento da barra',
                            ),
                          ),
                        ),
                        minX: 0,
                        maxX: comprimento / 100,
                        lineBarsData: [
                          LineChartBarData(
                          color: Colors.black,
                          barWidth: 2,
                          spots: [
                            FlSpot(0, 0),
                            FlSpot(comprimento / 100, 0)
                          ],
                        ),
                          LineChartBarData(
                            barWidth: 2,
                            spots: [
                              const FlSpot(0, 0),
                              FlSpot((comprimento / 100) / 2,
                                  (maxMoment * 1.4) * -1),
                              FlSpot(comprimento / 100, 0),
                            ],
                            isCurved: true,
                            belowBarData: BarAreaData(
                              show: true,
                              color: Colors.deepPurple.withOpacity(0.4),
                              cutOffY: 5,
                              applyCutOffY: true,
                            ),
                            aboveBarData: BarAreaData(
                              show: true,
                              color: Colors.orange.withOpacity(0.6),
                              cutOffY: 5,
                              applyCutOffY: true,
                            ),
                            curveSmoothness: 0.6,
                            dotData: FlDotData(show: true),
                          )
                        ],
                      ),
                    ),
                  )),
              const SizedBox(height: 20),
              Text(
                  'momento fletor máximo (já com coeficiente de ponderação):'
                  '\n${(maxMoment * 1.4).toStringAsFixed(2)}KN/m '
                  'ou ${((maxMoment * 100) * 1.4).toStringAsFixed(2)}KN/cm',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 20)),
              SizedBox(height: 20),
              Text(
                  'Area da seção da madeira:\nA = ${(largura * altura).toStringAsFixed(2)}cm²\n'
                  'Momento de inércia:\nI = ${momentInercia.toStringAsFixed(2)}cm^4'
                  '\nMódulo resistente:\n W superior (comprimida) = ${(momentInercia / (altura / 2)).toStringAsFixed(2)}cm³\n'
                  'W inferior (tracionada) = ${(momentInercia / (altura / 2)).toStringAsFixed(2)}cm³\n'
                  '\n Tensão Superior: σ superior = ${(((maxMoment * 100) * 1.4) / (momentInercia / (altura / 2))).toStringAsFixed(2)}KN/cm² (compressão)'
                  '\n Tensão inferior: σ inferior = ${(((maxMoment * 100) * 1.4) / (momentInercia / (altura / 2))).toStringAsFixed(2)}KN/cm² (tração)',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.center),
              const SizedBox(height: 40),
              Text(
                segurancaM,
                style: TextStyle(color: Colors.white, fontSize: 22),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Text(
                segurancaV,
                style: TextStyle(color: Colors.white, fontSize: 22),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40,
              )

              /*Container(color: Colors.white,child: LineChartWidget(graphPositions,comprimento/100)),*/
            ],
          ),
        ),
      ),
    );
  }
}
