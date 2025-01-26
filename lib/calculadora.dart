import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final String _vol = 'Vol';
  final String _del = 'Del';
  String _exp = '';
  String _res = '';

  void _pb(String valor) {
    setState(() {
      if (valor == 'Del') {
        _exp = '';
        _res = '';
      } else if (valor == '=') {
        _cr();
      } else if (valor == 'Vol') {
        _exp = _exp.substring(0, _exp.length - 1);
      } else {
        _exp += valor;
      }
    });
  }

  void _cr() {
    try {
      _res = _ava(_exp).toString();
    } catch (e) {
      _res = 'Cálculo inválido';
      debugPrint('Cálculo inválido');
    }
    setState(() {
      _res = _ava(_exp).toString();
    });
  }

  double _ava(String exp) {
    exp = exp.replaceAll('x', '*');
    exp = exp.replaceAll('÷', '/');
    ExpressionEvaluator evaluator = const ExpressionEvaluator();
    double res = evaluator.eval(Expression.parse(exp), {});
    return res;
  }

  Widget _bt(String valor) {
    return TextButton(
      child: Text(
        valor,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onPressed: () => _pb(valor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Text(
            _exp,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        Expanded(
          child: Text(
            _res,
            style: const TextStyle(fontSize: 25),
          ),
        ),
        Expanded(
          flex: 4,
          child: GridView.count(
            childAspectRatio: 1.2,
            crossAxisCount: 4,
            children: [
              _bt('7'),
              _bt('8'),
              _bt('9'),
              _bt('÷'),
              _bt('4'),
              _bt('5'),
              _bt('6'),
              _bt('x'),
              _bt('1'),
              _bt('2'),
              _bt('3'),
              _bt('-'),
              _bt('0'),
              _bt('.'),
              _bt('='),
              _bt('+'),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                child: _bt(_del),
              ),
            ),
            Expanded(
              child: _bt(_vol),
            ),
          ],
        ),
      ],
    );
  }
}
