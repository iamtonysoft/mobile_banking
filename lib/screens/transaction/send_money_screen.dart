import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_banking/components/background.dart';
import 'package:mobile_banking/screens/transaction/transaction_history_screen.dart';
import '../../api_service.dart';
import '../../components/navbar.dart';
import '../../components/rounded_button.dart';
import '../../constants.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  SendMoneyScreenState createState() => SendMoneyScreenState();
}

class SendMoneyScreenState extends State<SendMoneyScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool _isLoading = false; // Track loading state
  int _selectedIndex = 1;  // Set the default selected index to 1 (Send Money)

  Future<void> _sendMoney() async {
    if (_formKey.currentState?.validate() ?? false) {
      final accountNumber = _accountController.text;
      final amount = double.parse(_amountController.text);

      if (amount > balance) {
        _showSnackBar('Insufficient balance');
        return;
      }

      setState(() {
        _isLoading = true; // Set loading state to true while waiting for the request
      });

      try {
        bool success = await sendMoneyRequest(accountNumber, amount);

        if (success) {
          setState(() {
            balance -= amount; // Update balance after successful transaction
          });

          _showSnackBar('Money Sent Successfully');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => TransactionHistoryScreen()),
          );
        } else {
          _showSnackBar('Failed to send money. Please try again');
        }
      } catch (e) {
        _showSnackBar('Error: $e');
      } finally {
        setState(() {
          _isLoading = false; // Reset loading state once the request is complete
        });
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  // Handle item taps for the BottomNavBar
  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate based on the selected index
    if (index == 1) {
      // If "Send Money" is tapped, stay on the SendMoneyScreen
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TransactionHistoryScreen()),
      );
    } else if (index == 3) {
      // Implement logout functionality here if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: Text('Send Money')),
      body: Background(
        child: Padding(
          padding: kDefaultPaddingInput,
          child: _isLoading
              ? Center( // Show loading indicator while request is active
            child: CircularProgressIndicator(),
          )
              : Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _accountController,
                  decoration: const InputDecoration(
                    labelText: 'Account/Reference Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  maxLength: 16,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the account/reference number';
                    } else if (value.length < 12 || value.length > 16) {
                      return 'Account number must be between 12 to 16 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the amount';
                    } else if (double.tryParse(value) == null) {
                      return 'Please enter a valid amount';
                    } else if (value.contains('.') && value.split('.')[1].length > 2) {
                      return 'Amount can have only up to 2 decimal places';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Center(
                  child: RoundedButton(
                    text: "Send",
                    press: _sendMoney,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(  // Use the BottomNavBar widget
        selectedIndex: _selectedIndex,  // Set the initial selected index to 1
        onItemTapped: onItemTapped,     // Pass the onItemTapped callback
      ),
    );
  }
}
