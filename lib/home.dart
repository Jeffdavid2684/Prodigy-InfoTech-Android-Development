import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'iOS-like Calculator',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.yellow,
      ),
      home: const HomeCalculator(),
    );
  }
}

class HomeCalculator extends StatefulWidget {
  const HomeCalculator({Key? key}) : super(key: key);

  @override
  State<HomeCalculator> createState() => _HomeCalculatorState();
}

class _HomeCalculatorState extends State<HomeCalculator> {
  String expression = "";
  String result = "0";

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        expression = "";
        result = "0";
      } else if (buttonText == "=") {
        try {
          final exp = Expression.parse(expression.replaceAll('X', '*'));
          final evaluator = const ExpressionEvaluator();
          final evalResult = evaluator.eval(exp, {});
          result = evalResult.toString();
        } catch (e) {
          result = "Error";
        }
      } else {
        if (expression == "0" && buttonText != ".") {
          expression = buttonText;
        } else {
          expression += buttonText;
        }
      }
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: Container(

        margin: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.grey[850],
            padding: const EdgeInsets.all(20.0),
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.yellow,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Jefferson Calculator',style: TextStyle(color: Colors.yellow),),
        backgroundColor: Colors.black12,
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 12.0,
              ),
              child: Text(
                expression,
                style: const TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 12.0,
              ),
              child: Text(
                result,
                style: const TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow,
                ),
              ),
            ),
            const Expanded(
              child: Divider(),
            ),
            Column(
              children: [
                Row(
                  children: [
                    buildButton("7"),
                    buildButton("8"),
                    buildButton("9"),
                    buildButton("/"),
                  ],
                ),
                Row(
                  children: [
                    buildButton("4"),
                    buildButton("5"),
                    buildButton("6"),
                    buildButton("X"),
                  ],
                ),
                Row(
                  children: [
                    buildButton("1"),
                    buildButton("2"),
                    buildButton("3"),
                    buildButton("-"),
                  ],
                ),
                Row(
                  children: [
                    buildButton("."),
                    buildButton("0"),
                    buildButton("00"),
                    buildButton("+"),
                  ],
                ),
                Row(
                  children: [
                    buildButton("C"),
                    buildButton("="),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
