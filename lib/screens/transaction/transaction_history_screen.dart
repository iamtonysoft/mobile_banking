import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import '../../api_service.dart';
import '../../components/navbar.dart';

class Transaction {
  final String accountNumber;
  final double amount;
  final DateTime dateTime;

  Transaction({
    required this.accountNumber,
    required this.amount,
    required this.dateTime,
  });
}

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  TransactionHistoryScreenState createState() =>
      TransactionHistoryScreenState();
}

class TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  List<Transaction> transactions = [];
  int _selectedIndex = 2; // Set the default selected index to 2 (Transaction History)

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  Future<void> _fetchTransactions() async {
    try {
      final data = await fetchTransactions();

      setState(() {
        transactions = data
            .where((json) => json['userId'] == 10)
            .map((json) {
          return Transaction(
            accountNumber: _generateRandomAccountNumber(),
            amount: _generateRandomAmount(),
            dateTime: DateTime.now(),
          );
        }).toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching transactions: $e')),
      );
    }
  }

  String _generateRandomAccountNumber() {
    Random rand = Random();
    int length = rand.nextInt(5) + 12;
    String accountNumber = '';
    for (int i = 0; i < length; i++) {
      accountNumber += rand.nextInt(10).toString();
    }
    return accountNumber;
  }

  double _generateRandomAmount() {
    Random rand = Random();
    double amount = rand.nextDouble() * 1000;
    return double.parse(amount.toStringAsFixed(2));
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('yyyy-dd-MM hh:mm a').format(dateTime);
  }

  // Handle item taps for the BottomNavBar
  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate based on the selected index
    if (index == 1) {
      // Implement Send Money navigation logic if needed
    } else if (index == 2) {
      // We're already on the TransactionHistoryScreen
    } else if (index == 3) {
      // Implement logout functionality here if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: Text('Transaction History')),
      body: transactions.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text('Reference: ${transaction.accountNumber}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Amount: PHP ${transaction.amount.toStringAsFixed(2)}'),
                  Text('Date & Time: ${_formatDateTime(transaction.dateTime)}'),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(  // Use the BottomNavBar widget
        selectedIndex: _selectedIndex,  // Set the initial selected index to 2
        onItemTapped: onItemTapped,     // Pass the onItemTapped callback
      ),
    );
  }
}
