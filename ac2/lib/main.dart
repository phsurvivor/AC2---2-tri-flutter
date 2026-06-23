import 'package:flutter/material.dart';
import 'widgets/texts.dart';
import 'funçoes/calculos.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaLocadora(),
    ),
  );
}

class TelaLocadora extends StatefulWidget {
  const TelaLocadora({super.key});

  @override
  State<TelaLocadora> createState() => _TelaLocadoraState();
}

class _TelaLocadoraState extends State<TelaLocadora> {

  String carroSelecionado = 'carroEco';

  double valorCarro = 120;
  bool seguro = false;
  double valorSeguro = 0;

  bool gps = false;
  double valorGps = 0;

  bool motorista = false;
  double taxaMotorista = 0;

  double dias = 1;
  double desconto = 0;

  void alterarCarro(String novoCarro) {
    setState(() {
      carroSelecionado = novoCarro;

      if (novoCarro == 'carroEco') {
        valorCarro = 120;
      } else if (novoCarro == 'SUV') {
        valorCarro = 180;
      } else {
        valorCarro = 300;
      }
    });
  }

  void alternarSeguro(bool valor) {
    setState(() {
      seguro = valor;
      valorSeguro = seguro ? 40 : 0;
    });
  }

  void alternarGps(bool valor) {
    setState(() {
      gps = valor;
      valorGps = gps ? 15 : 0;
    });
  }

  void alternarMotorista(bool valor) {
    setState(() {
      motorista = valor;
      taxaMotorista = motorista ? 100 : 0;
    });
  }

  void alterarDias(double value) {
    setState(() {
      dias = value;

      if (value >= 15) {
        desconto = 0.10;
      } else if (value >= 7) {
        desconto = 0.05;
      } else {
        desconto = 0;
      }
    });
  }

  void finalizarReserva() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Resumo da Reserva'),
          content: SingleChildScrollView(
            child: Text(
              '''
Veículo: ${nomeVeiculo(carroSelecionado)}
Dias: ${dias.toStringAsFixed(0)}

Seguro: ${seguro ? "Sim" : "Não"}
GPS: ${gps ? "Sim" : "Não"}
Motorista adicional: ${motorista ? "Sim" : "Não"}

Valor bruto: R\$ ${calcularValorBruto(valorCarro, valorSeguro, valorGps, dias, motorista, taxaMotorista).toStringAsFixed(2)}
Desconto: R\$ ${calcularDesconto(valorCarro, valorSeguro, valorGps, dias, motorista, taxaMotorista, desconto).toStringAsFixed(2)}
Valor final: R\$ ${calcularValorFinal(valorCarro, valorSeguro, valorGps, dias, motorista, taxaMotorista, desconto).toStringAsFixed(2)}

Categoria: ${categoriaCliente(valorCarro, valorSeguro, valorGps, dias, motorista, taxaMotorista, desconto)}
''',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Reserva realizada com sucesso!',
                    ),
                  ),
                );
              },
              child: const Text('Confirmar Reserva'),
            ),
          ],
        );
      },
    );
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
        appBar: AppBar(
          title: const Text('Locadora'),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 20,
              ),
              child: Column(
                children: [
                  Text_custom('Monte sua locação'),

                  Text_custom('Escolha seu veiculo',),

                  SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(
                        value: 'carroEco',
                        label: Text('Econômico'),
                      ),
                      ButtonSegment(
                        value: 'SUV',
                        label: Text('SUV'),
                      ),
                      ButtonSegment(
                        value: 'CarroLux',
                        label: Text('Luxo'),
                      ),
                    ],
                    selected: {carroSelecionado},
                    onSelectionChanged: (valor) {
                      alterarCarro(valor.first);
                    },
                  ),

                  const SizedBox(height: 20),

                  CheckboxListTile(
                    title: const Text(
                      'Adicionar Seguro Completo (+R\$40/dia)',
                    ),
                    value: seguro,
                    onChanged: (valor) {
                      alternarSeguro(valor!);
                    },
                  ),

                  CheckboxListTile(
                    title: const Text(
                      'Adicionar GPS (+R\$15/dia)',
                    ),
                    value: gps,
                    onChanged: (valor) {
                      alternarGps(valor!);
                    },
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Motorista Adicional (+R\$100)',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 20),
                      Switch(
                        value: motorista,
                        onChanged: (value) {
                          alternarMotorista(value);
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  Text_custom( 'Quantidade de dias: ${dias.toStringAsFixed(0)}'),

                  Slider(
                    min: 1,
                    max: 30,
                    divisions: 29,
                    value: dias,
                    label: dias.toStringAsFixed(0),
                    onChanged: alterarDias,
                  ),

                  const SizedBox(height: 20),

                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Text(
                            'Resumo da Locação',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 15),

                          Text('Veículo: ${nomeVeiculo(carroSelecionado)}'),
                          Text(
                            'Dias: ${dias.toStringAsFixed(0)}',
                          ),
                          Text(
                            'Seguro: ${seguro ? "Sim" : "Não"}',
                          ),
                          Text(
                            'GPS: ${gps ? "Sim" : "Não"}',
                          ),
                          Text(
                            'Motorista adicional: ${motorista ? "Sim" : "Não"}',
                          ),

                          const Divider(height: 30),

                          Text(
                            'Valor Bruto: R\$ ${calcularValorBruto(valorCarro, valorSeguro, valorGps, dias, motorista, taxaMotorista).toStringAsFixed(2)}',
                          ),

                          Text(
                            'Desconto: R\$ ${calcularDesconto(valorCarro, valorSeguro, valorGps, dias, motorista, taxaMotorista, desconto).toStringAsFixed(2)} (${(desconto * 100).toStringAsFixed(0)}%)',
                          ),

                          Text_custom('Valor Final: R\$ ${calcularValorFinal(valorCarro, valorSeguro, valorGps, dias, motorista, taxaMotorista, desconto).toStringAsFixed(2)}'),
 
                          const SizedBox(height: 15),

                          Text(
                            categoriaCliente(valorCarro, valorSeguro, valorGps, dias, motorista, taxaMotorista, desconto),
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  ElevatedButton.icon(
                    onPressed: finalizarReserva,
                    icon: const Icon(Icons.check),
                    label: const Text('Finalizar Reserva'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}