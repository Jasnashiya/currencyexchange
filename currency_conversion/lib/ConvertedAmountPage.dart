import 'package:flutter/material.dart';

class ConvertedAmountPage extends StatelessWidget {
  final double amount;
  final String currency;

  ConvertedAmountPage({required this.amount, required this.currency});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.amberAccent,
        title: Text('Converted Amount',
        style: TextStyle(
           color: Colors.green,
            fontSize: 30.0,
        ),
        ),
      
        centerTitle: true, // Center the title
      ),
      body: Container(
  color: const Color.fromARGB(255, 83, 149, 196), // Change this to any color you like
  child: Center(
    child: Text(
      'Converted Amount is: $amount $currency',
      style: TextStyle(
        color: const Color.fromARGB(255, 5, 7, 5),
        fontSize: 30.0,
      ),
    ),
  ),
),

    );
  }
}
