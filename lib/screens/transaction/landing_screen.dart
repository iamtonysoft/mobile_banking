import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_banking/components/background.dart';
import '../../components/navbar.dart';
import '../../constants.dart';
import 'send_money_screen.dart';
import 'transaction_history_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  LandingScreenState createState() => LandingScreenState();
}

class LandingScreenState extends State<LandingScreen> {
  bool isBalanceVisible = false;
  String accountNumber = '000012348888';
  int _selectedIndex = 0; // To track selected index for bottom navigation

  void toggleBalanceVisibility() {
    setState(() {
      isBalanceVisible = !isBalanceVisible;
    });
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final formattedBalance = NumberFormat('#,##0.00', 'en_US').format(balance);

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: Text('Mobile Banking')),
      body: SafeArea(
        child: Background(
          child: Column(
            children: [
              Padding(
                padding: kDefaultPadding,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color: Color(0xFFE3D8F1),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Account Number',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            PopupMenuButton<int>(
                              onSelected: (item) {
                                if (item == 1) {
                                  // Navigate to Send Money Screen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => SendMoneyScreen()),
                                  );
                                } else if (item == 2) {
                                  // Navigate to Transaction History Screen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => TransactionHistoryScreen()),
                                  );
                                }
                              },
                              itemBuilder: (context) => [
                                PopupMenuItem<int>(value: 1, child: Text('Send Money')),
                                PopupMenuItem<int>(value: 2, child: Text('Transaction History')),
                              ],
                              icon: Icon(Icons.more_vert, color: Colors.black),
                            ),
                          ],
                        ),
                        Text(accountNumber, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        SizedBox(height: 8),
                        Text('Balance', style: TextStyle(fontSize: 18)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              isBalanceVisible ? 'PHP $formattedBalance' : '*************',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 2),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
                              child: IconButton(
                                icon: Icon(
                                  isBalanceVisible ? Icons.visibility_off : Icons.visibility,
                                  color: kPrimaryColor1,
                                ),
                                onPressed: toggleBalanceVisibility,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(  // Use the new BottomNavBar widget
        selectedIndex: _selectedIndex,
        onItemTapped: onItemTapped,
      ),
    );
  }
}
