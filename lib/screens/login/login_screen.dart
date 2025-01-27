import 'package:flutter/material.dart';
import 'package:mobile_banking/components/background.dart';
import 'package:mobile_banking/components/rounded_button.dart';
import 'package:mobile_banking/components/rounded_input_field.dart';
import 'package:mobile_banking/components/rounded_password_field.dart';
import '../../api_service.dart';
import '../transaction/landing_screen.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false; // Track loading state

  Future<void> _login(BuildContext context) async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      _showErrorDialog(context, "Username and password cannot be empty.");
      return;
    }

    setState(() {
      _isLoading = true; // Set loading state to true while waiting for the request
    });

    try {
      bool loginSuccess = await loginUser(username, password);

      if (loginSuccess) {
        navigateToLandingScreen(context);
      } else {
        _showErrorDialog(context, "Failed to login. Please try again.");
      }
    } catch (e) {
      _showErrorDialog(context, "Error: $e");
    } finally {
      setState(() {
        _isLoading = false; // Reset loading state once the request is complete
      });
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void navigateToLandingScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LandingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: _isLoading
            ? Center( // Center the loading screen
          child: CircularProgressIndicator(),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/smartphone.png",
              height: size.height * 0.15,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Username",
              controller: _usernameController,
            ),
            RoundedPasswordField(
              hintText: "Password",
              controller: _passwordController,
            ),
            RoundedButton(
              text: "Login",
              press: () {
                _login(context);
              },
            ),
            SizedBox(height: size.height * 0.03),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
