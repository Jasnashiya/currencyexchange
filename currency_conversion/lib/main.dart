import 'package:flutter/material.dart';
import 'currency_service.dart';
import 'ConvertedAmountPage.dart'; 

void main() {
  runApp(CurrencyConverterApp());
}

class CurrencyConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CurrencyConverter(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  String fromCurrency = 'USD';
  String toCurrency = 'INR';
  double amount = 1.0;
  double convertedAmount = 0.0;
  CurrencyService service = CurrencyService();

  void convert() async {
    var rates = await service.fetchRates(fromCurrency);
    setState(() {
      convertedAmount = amount * (rates['conversion_rates'][toCurrency] ?? 1.0);
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConvertedAmountPage(amount: convertedAmount, currency: toCurrency),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome to Currency Converter',
          style: TextStyle(
            color: Colors.green,
            fontSize: 24.0,
          ),
        ),
        centerTitle: true, // Center the title
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://www.google.com/imgres?q=currency%20image%20to%20sett%20background&imgurl=https%3A%2F%2Fmedia.istockphoto.com%2Fid%2F1307161919%2Fphoto%2Fpiggy-bank-woman-at-the-background-home-setting-savings-for-retirement-or-rainy-days-concept.jpg%3Fs%3D612x612%26w%3D0%26k%3D20%26c%3D9e9i4_cbMqKnxzr0CtpyVdFzOxiLj5ppw8FNRuZ3k34%3D&imgrefurl=https%3A%2F%2Fwww.istockphoto.com%2Fphotos%2Fmoney-set-aside&docid=SALdZupV7QuTOM&tbnid=EVMEE7srSR_mdM&vet=12ahUKEwj4kpPtie2KAxX7d2wGHd1iBP4QM3oECH4QAA..i&w=612&h=408&hcb=2&ved=2ahUKEwj4kpPtie2KAxX7d2wGHd1iBP4QM3oECH4QAA'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter the Amount',
                  labelStyle: TextStyle(
                    color: Colors.blue,
                    fontSize: 30.0,
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  amount = double.tryParse(value) ?? 1.0;
                },
              ),
              DropdownButton<String>(
                value: fromCurrency,
                onChanged: (String? newValue) {
                  setState(() {
                    fromCurrency = newValue!;
                  });
                },
                items: <String>['USD', 'INR', 'EUR', 'GBP', 'JPY']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              DropdownButton<String>(
                value: toCurrency,
                onChanged: (String? newValue) {
                  setState(() {
                    toCurrency = newValue!;
                  });
                },
                items: <String>['USD', 'INR', 'EUR', 'GBP', 'JPY']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              ElevatedButton(
                onPressed: convert,
                child: Text('Submit To Convert'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
