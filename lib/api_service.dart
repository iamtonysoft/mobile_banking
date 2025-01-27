import 'dart:convert';
import 'package:http/http.dart' as http;

Future<bool> loginUser(String username, String password) async {
  try {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      return true; // Successfully logged in
    } else {
      return false; // Login failed
    }
  } catch (e) {
    throw Exception('Error: $e'); // Handle any errors
  }
}

Future<bool> sendMoneyRequest(String accountNumber, double amount) async {
  try {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({
        'title': 'Send Money',
        'body': 'Account Number: $accountNumber, Amount: $amount',
        'userId': 10,
      }),
    );

    if (response.statusCode == 201) {
      return true; // Money sent successfully
    } else {
      return false; // Failed to send money
    }
  } catch (e) {
    throw Exception('Failed to send money: $e'); // Return error if there's an exception
  }
}

Future<List<dynamic>> fetchTransactions() async {
  try {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load transactions');
    }
  } catch (e) {
    throw Exception('Error fetching transactions: $e');
  }
}