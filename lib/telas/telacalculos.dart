import 'package:flutter/material.dart';
import 'package:teste/objects.dart';
import 'package:teste/telas/telacalculos2.dart';
import 'package:teste/calculations.dart';

class TelaCalculos extends StatefulWidget {
  const TelaCalculos({Key? key}) : super(key: key);

  @override
  State<TelaCalculos> createState() => _TelaCalculosState();
}

class _TelaCalculosState extends State<TelaCalculos> {
  _TelaCalculosState() {
    _selectedVal = _tipoDeApoioLista[0];
  }

  final TextEditingController _compriVigaController = TextEditingController();
  final TextEditingController _largVigaController = TextEditingController();
  final TextEditingController _strVigaController = TextEditingController();
  final TextEditingController _altVigaController = TextEditingController();

  final _tipoDeApoioLista = [
    'bi-apoiada (dois apoios)',
    'contínua (em desenvolvimento)'
  ];
  String? _selectedVal = '';

  String verifSegurancaM(double maxMoment, double momentInercia, double altura) {
    const double fc0k = 4;
    double tensao =
        (((maxMoment * 100) * 1.4) / (momentInercia / (altura / 2)));
    double compressao = (fc0k * 0.7) / 1.4;
    if (tensao > compressao) {
      String segurancaM =
          'Essa viga apresenta uma tensão resistente de tração/compressão de ${tensao.toStringAsFixed(2)}KN/cm²,'
          'enquanto o maior permitido é ${compressao.toStringAsFixed(2)}KN/cm²'
          '\nResultado: NÃO PASSOU';
      return segurancaM;
    } else {
      String segurancaM =
          'Essa viga apresenta uma tensão resistente de tração/compressão de ${tensao.toStringAsFixed(2)}KN/cm²,'
          'enquanto o maior permitido é ${compressao.toStringAsFixed(2)}KN/cm²'
          '\nResultado: PASSOU';
      return segurancaM;
    }
  }
  String VerifiSegurancaV(double carga, double comprimento, double altura, double largura){
    double cisalhamento = (3/2) * ((((carga * (comprimento / 100)) / 2) * 1.4)/(altura * largura));
    double fvd = (0.6 * 0.7 / 1.8);
    if (cisalhamento <= fvd){
      String message = 'Essa viga apresenta uma tensão cortante de ${cisalhamento.toStringAsFixed(2)}KN/cm²\n'
          'enquanto o maior permitido é de ${fvd.toStringAsFixed(2)}KN/cm²\n'
          'Resultado: PASSOU';
      return message;
    } else {String message = 'Essa viga apresenta uma tensão cortante de ${cisalhamento.toStringAsFixed(2)}KN/cm²\n'
        'enquanto o maior permitido é de ${fvd.toStringAsFixed(2)}KN/cm²\n'
        'Resultado: NÃO PASSOU';
    return message;}
  }

  void botao() {
    double compri = double.parse(_compriVigaController.text) * 100;
    double larg = double.parse(_largVigaController.text);
    double str = double.parse(_strVigaController.text);
    double alt = double.parse(_altVigaController.text);
    String message = calculeVigaHi(alt, larg, compri);
    alt = alturaIdeal(alt, larg, compri);
    double maxMoment = str * (compri / 100 * compri / 100) / 8;
    double momentInercia = (larg * (alt * alt * alt) / 12);
    String segurancaM = verifSegurancaM(maxMoment, momentInercia, alt);
    String segurancaV = VerifiSegurancaV(str,compri,alt,larg);


    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaCalculos2(
          comprimento: compri,
          altura: alt,
          largura: larg,
          carga: str,
          message: message,
          maxMoment: maxMoment,
          momentInercia: momentInercia,
          segurancaM: segurancaM,
          segurancaV: segurancaV,
        ),
      ),
    );
  }

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Passo 1',
                style: CsStyle.caminho,
              ),
              const Text(
                'Selecione o tipo de apoio das vigas:',
                style: CsStyle.descricao,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: DropdownButtonFormField(
                    value: _selectedVal,
                    items: _tipoDeApoioLista
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ))
                        .toList(),
                    dropdownColor: Colors.brown,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: 'Tipo de apoio da viga',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                    onChanged: (val) {
                      setState(() {
                        _selectedVal = val as String;
                      });
                    }),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Passo 2',
                style: CsStyle.caminho,
              ),
              const Text(
                'Digite as medidas da viga',
                style: CsStyle.descricao,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: TextField(
                  controller: _compriVigaController,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelStyle: TextStyle(color: Colors.white),
                    suffixStyle: TextStyle(color: Colors.white),
                    suffixText: 'Metros',
                    labelText: 'Comprimento da viga',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: TextField(
                  controller: _largVigaController,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    suffixText: 'Centímetros',
                    labelStyle: TextStyle(color: Colors.white),
                    suffixStyle: TextStyle(color: Colors.white),
                    labelText: 'Largura da viga',
                    hintText: 'Recomendado: 6 cm',
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: TextField(
                  controller: _altVigaController,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    suffixText: 'Centímetros',
                    labelStyle: TextStyle(color: Colors.white),
                    suffixStyle: TextStyle(color: Colors.white),
                    labelText: 'Altura da viga',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: TextField(
                  controller: _strVigaController,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    suffixText: 'KN/m',
                    labelStyle: TextStyle(color: Colors.white),
                    suffixStyle: TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: 'Sugestão 4.5KN/m',
                    labelText: 'Carga distribuída sobre a viga',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Passo 3',
                style: CsStyle.caminho,
              ),
              const Text(
                'Clique no botão abaixo',
                style: CsStyle.descricao,
              ),
              ElevatedButton(
                onPressed: botao,
                child: const Text('Realizar calculos'),
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Color.fromRGBO(230, 164, 97, 1),
                  fixedSize: const Size(140, 60),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
