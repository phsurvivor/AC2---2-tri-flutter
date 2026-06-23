  double calcularValorBruto(valorCarro, valorSeguro, valorGps, dias, motorista, taxaMotorista) {
    double valorDiario = valorCarro + valorSeguro + valorGps;

    double total = valorDiario * dias;

    if (motorista) {
      total += taxaMotorista;
    }

    return total;
  }
  double calcularDesconto(valorCarro, valorSeguro, valorGps, dias, motorista, taxaMotorista, desconto) {
    return calcularValorBruto(valorCarro, valorSeguro, valorGps, dias, motorista, taxaMotorista) * desconto;
  }

    double calcularValorFinal(valorCarro, valorSeguro, valorGps, dias, motorista, taxaMotorista, desconto) {
    return calcularValorBruto(valorCarro, valorSeguro, valorGps, dias, motorista, taxaMotorista) - calcularDesconto(valorCarro, valorSeguro, valorGps, dias, motorista, taxaMotorista, desconto);
  }


  String categoriaCliente(valorCarro, valorSeguro, valorGps, dias, motorista, taxaMotorista, desconto) {
    double valor = calcularValorFinal(valorCarro, valorSeguro, valorGps, dias, motorista, taxaMotorista, desconto);

    if (valor <= 1000) {
      return 'Cliente Bronze';
    } else if (valor <= 3000) {
      return 'Cliente Prata';
    } else if (valor <= 5000) {
      return 'Cliente Ouro';
    } else {
      return 'Cliente Platinum';
    }
  }

  String nomeVeiculo(carroSelecionado) {
    switch (carroSelecionado) {
      case 'carroEco':
        return 'Carro Econômico';
      case 'SUV':
        return 'SUV';
      case 'CarroLux':
        return 'Carro de Luxo';
      default:
        return 'Não informado';
    }
  }

