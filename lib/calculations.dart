String calculeVigaHi(double alt, double larg, double compr) {
  print('a altura da viga é de ${alt}cm');
  if (larg <= 6) {
    double high = compr / 25;
    int alturaIdeal = high.ceil();
    if (alturaIdeal > alt) {
      String retorno =
          ('A altura da viga escolhida para este projeto foi muito baixa,'
              ' recomenda-se uma viga de no mínimo ${alturaIdeal}cm para este projeto');
      return retorno;
    } else if (alturaIdeal == alt) {
      String retorno = ('A altura da viga está adequada para o projeto.');
      return retorno;
    } else {
      String retorno = 'A viga está superdimensionada para este projeto, '
          'visando reduzir custos, o ideal seria uma viga de ${alturaIdeal}cm';
      return retorno;
    }
  } else {
    double high = compr / 16;
    int alturaIdeal = high.ceil();
    if (alturaIdeal > alt) {
      String retorno =
          ('A altura da viga escolhida para este projeto foi muito baixa,'
              ' recomenda-se uma viga de no mínimo ${alturaIdeal}cm para este projeto');
      return retorno;
    } else if (alturaIdeal == alt) {
      String retorno = ('A altura da viga está adequada para o projeto.');
      return retorno;
    } else {
      String retorno = 'A viga está superdimensionada para este projeto, '
          'visando reduzir custos, o ideal seria uma viga de ${alturaIdeal}cm';
      return retorno;
    }
  }
}

double alturaIdeal(double alt, double larg, double compr) {
  if (larg <= 6){
    double alturaIdeal = compr / 25;
    return alturaIdeal;
  } else {
    double alturaIdeal = compr / 16;
    return alturaIdeal;
  }

}
