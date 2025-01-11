import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class CurrencyService {
 static const String apiUrl = 'https://v6.exchangerate-api.com/v6/ca34392c43abf9b88cfd86fd/latest/';

  Future<Map<String, dynamic>> fetchRates(String baseCurrency) async {
    final response = await http.get(Uri.parse('$apiUrl$baseCurrency'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }
}
