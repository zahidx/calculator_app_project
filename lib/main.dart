import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String expression = '';
  String result = '';

  void append(String value) {
    setState(() {
      expression += value;
    });
  }

  void evaluate() {
    try {
      Parser parser = Parser();
      Expression exp = parser.parse(expression);
      ContextModel contextModel = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, contextModel);
      setState(() {
        result = eval.toString();
      });
    } catch (e) {
      setState(() {
        result = 'Error';
      });
    }
  }

  void clear() {
    setState(() {
      if (expression.isNotEmpty) {
        expression = expression.substring(0, expression.length - 1);
        result = '';
      }
    });
  }

  void allClear() {
    setState(() {
      expression = '';
      result = '';
    });
  }

  Widget buildButton(String value, Color color, Function onPressed) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: color,
            padding: EdgeInsets.all(16.0),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
              side: BorderSide.none,
            ),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.white,
            ),
          ),
          onPressed: () => onPressed(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double displayHeightRatio = 0.4;
    double buttonPanelHeightRatio = 0.6;

    if (screenHeight < 600) {
      displayHeightRatio = 0.35;
      buttonPanelHeightRatio = 0.65;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0B344F),
        title: Text('Calculator'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            flex: (screenHeight * displayHeightRatio).toInt(),
            child: Container(
              color: Colors.black,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, right: 20.0),
                      child: Text(
                        expression,
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding:
                      const EdgeInsets.only(bottom: 20.0, right: 20.0, left: 20.0),
                      child: Text(
                        result.endsWith('.0')
                            ? result.substring(0, result.length - 2)
                            : result,
                        style: TextStyle(
                          fontSize: 60.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(
              maxHeight: screenHeight * buttonPanelHeightRatio,
            ),
            color: Colors.grey[200], // Set the desired background color here
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      buildButton('^', Color(0xFF0B344F), () => append('^')),
                      buildButton('√', Color(0xFF0B344F), () => append('sqrt(')),
                      buildButton('X', Color(0xFF0B344F), () => clear()),
                      buildButton('C', Color(0xFF0B344F), () => allClear()),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton('( ', Color(0xFF0B344F), () => append('(')),
                      buildButton(' )', Color(0xFF0B344F), () => append(')')),
                      buildButton('6', Color(0xFF0B344F), () => append('6')),
                      buildButton('*', Color(0xFF0B344F), () => append('*')),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton('1', Color(0xFF0B344F), () => append('1')),
                      buildButton('2', Color(0xFF0B344F), () => append('2')),
                      buildButton('3', Color(0xFF0B344F), () => append('3')),
                      buildButton('÷', Color(0xFF0B344F), () => append('/')),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton('4', Color(0xFF0B344F), () => append('4')),
                      buildButton('5', Color(0xFF0B344F), () => append('5')),
                      buildButton('6', Color(0xFF0B344F), () => append('6')),
                      buildButton('+', Color(0xFF0B344F), () => append('+')),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton('7', Color(0xFF0B344F), () => append('7')),
                      buildButton('8', Color(0xFF0B344F), () => append('8')),
                      buildButton('9', Color(0xFF0B344F), () => append('9')),
                      buildButton('-', Color(0xFF0B344F), () => append('-')),
                    ],
                  ),
                  Row(
                    children: [
                      buildButton('0', Color(0xFF0B344F), () => append('0')),
                      buildButton('00', Color(0xFF0B344F), () => append('00')),
                      buildButton('.', Color(0xFF0B344F), () => append('.')),
                      buildButton('=', Colors.blue[800]!, () => evaluate()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

