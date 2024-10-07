import 'package:flutter/material.dart';
import 'package:teste/telas/telacalculos.dart';

class BoasVindas extends StatefulWidget {
  const BoasVindas({Key? key}) : super(key: key);

  @override
  State<BoasVindas> createState() => _BoasVindasState();
}

class _BoasVindasState extends State<BoasVindas> {
  void teste() {
    print('entrou');
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Bem-vindo! O presente aplicativo visa auxiliar de forma facil '
                    'e pratica o dimensionamento de vigas de madeira feitas de '
                    'eucalipto, mais especificamente da classe C40 da NBR 7190/1997.'
                    '\nPrimeiramente, devemos escolher o tipo de apoio a qual a viga está apoiada.'
                    ' Este passo é importante pra determinar o tipo de calculo a ser feito, '
                    'após isso, passamos as informações de tamanho da viga.'
                    '\nO aplicativo então, faz um pré-dimensionamento da viga com base numa média necessária de altura'
                    ' para cruzar determinados tamanhos de vão, com base na largura da viga essa média é alterada, então fique '
                    'de olho.'
                    '\n Após isso, são calculadas todas as forças, resistencias e esforços sobre o material. '
                    'Os diagramas de esforços internos também são desenhados e por fim, o sistema calcula a segurança da'
                    ' viga para as tensões de compressão, tração e cortante, dizendo assim se a viga suportará determinada carga'
                    ' a qual ela estará submetida.',
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TelaCalculos(),
                  ),
                );
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                backgroundColor: Color.fromRGBO(230, 164, 97, 1),
                fixedSize: const Size(180, 60),
              ),
              child: const Text(
                'Vamos começar!',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
