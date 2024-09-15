import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  double _num1 = 0.0;
  double _num2 = 0.0;
  String _history = '';
  String _display = '0';
  String _operation = '';
  bool _isSecondNumber =
      false; 

  void _buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _num1 = 0.0;
        _num2 = 0.0;
        _display = '0';
        _history = '';
        _operation = '';
        _isSecondNumber = false;
      } else if (buttonText == '⌫') {
        if (_display.isNotEmpty) {
          _display = _display.length > 1
              ? _display.substring(0, _display.length - 1)
              : '0';
        }
      } else if (buttonText == '+' ||
          buttonText == '-' ||
          buttonText == '×' ||
          buttonText == '÷') {
        _num1 = double.tryParse(_display) ?? 0.0;
        _operation = buttonText;
        _history = _display + ' ' + _operation;
        _isSecondNumber = true;
        _display = '0';
      } else if (buttonText == '=') {
        _num2 = double.tryParse(_display) ?? 0.0;
        if (_operation == '+') {
          _display = (_num1 + _num2).toString();
        } else if (_operation == '-') {
          _display = (_num1 - _num2).toString();
        } else if (_operation == '×') {
          _display = (_num1 * _num2).toString();
        } else if (_operation == '÷') {
          if (_num2 != 0) {
            _display = (_num1 / _num2).toString();
          } else {
            _display = 'Error';
          }
        }
        _operation = '';
        _history = '';
        _isSecondNumber = false;
      } else {
        if (_isSecondNumber) {
          // Entering second number
          if (_display == '0') {
            _display = buttonText;
          } else {
            _display += buttonText;
          }
        } else {
          // Entering first number
          if (_display == '0') {
            _display = buttonText;
          } else {
            _display += buttonText;
          }
        }
      }
    });
  }

  Widget _buildButton(String text, Color color, Color textColor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () => _buttonPressed(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 24, color: textColor),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Display calculator name at the top
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'MY Calculator',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Display section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _history,
                    style: const TextStyle(fontSize: 24, color: Colors.white70),
                  ),
                  Text(
                    _display,
                    style: const TextStyle(fontSize: 48, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Button section
            Column(
              children: [
                Row(
                  children: [
                    _buildButton('C', Colors.grey, Colors.black),
                    _buildButton('⌫', Colors.grey, Colors.black),
                    _buildButton('÷', Colors.orange, Colors.white),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('7', Colors.grey[850]!, Colors.white),
                    _buildButton('8', Colors.grey[850]!, Colors.white),
                    _buildButton('9', Colors.grey[850]!, Colors.white),
                    _buildButton('×', Colors.orange, Colors.white),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('4', Colors.grey[850]!, Colors.white),
                    _buildButton('5', Colors.grey[850]!, Colors.white),
                    _buildButton('6', Colors.grey[850]!, Colors.white),
                    _buildButton('-', Colors.orange, Colors.white),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('1', Colors.grey[850]!, Colors.white),
                    _buildButton('2', Colors.grey[850]!, Colors.white),
                    _buildButton('3', Colors.grey[850]!, Colors.white),
                    _buildButton('+', Colors.orange, Colors.white),
                  ],
                ),
                Row(
                  children: [
                    _buildButton('0', Colors.grey[850]!, Colors.white),
                    _buildButton('.', Colors.grey[850]!, Colors.white),
                    _buildButton('=', Colors.orange, Colors.white),
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
