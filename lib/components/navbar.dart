import 'package:flutter/material.dart';
import 'package:mobile_banking/screens/transaction/landing_screen.dart';
import '../screens/transaction/send_money_screen.dart';
import '../screens/transaction/transaction_history_screen.dart';
import '../screens/login/login_screen.dart'; // Import your login screen
import '../../constants.dart';  // Make sure this path is correct for your project

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({super.key, required this.selectedIndex, required this.onItemTapped});

  void navigateToLandingScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LandingScreen()),
    );
  }

  void navigateToSendMoneyScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SendMoneyScreen()),
    );
  }

  void navigateToTransactionHistoryScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TransactionHistoryScreen()),
    );
  }

  void navigateToLoginScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()), // Replace with your actual login screen
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                navigateToLoginScreen(context); // Navigate to login screen
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        onItemTapped(index);

        // Navigate based on selected index
        if (index == 0) {
          navigateToLandingScreen(context);
        } else if (index == 1) {
          navigateToSendMoneyScreen(context);
        } else if (index == 2) {
          navigateToTransactionHistoryScreen(context);
        } else if (index == 3) {
          _showLogoutDialog(context);
        }
      },
      selectedItemColor: kPrimaryColor1,  // Set selected item color for both icon and label
      unselectedItemColor: kPrimaryColor1,  // Set unselected item color for both icon and label
      selectedLabelStyle: TextStyle(
        color: kPrimaryColor1,  // Set color for selected label
      ),
      unselectedLabelStyle: TextStyle(
        color: kPrimaryColor1,  // Set color for unselected label
      ),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.send),
          label: 'Send Money',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.logout),
          label: 'Logout',
        ),
      ],
    );
  }
}
