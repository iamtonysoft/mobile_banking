import 'package:flutter/material.dart';
import 'package:mobile_banking/screens/login/login_screen.dart';
import 'package:mobile_banking/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobile Banking',
      theme: ThemeData(
        primaryColor: kPrimaryColor1,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Lato', fontSize: 16),
          bodyMedium: TextStyle(fontFamily: 'Lato', fontSize: 14),
          headlineLarge: TextStyle(fontFamily: 'Lato', fontSize: 32),
          headlineMedium: TextStyle(fontFamily: 'Lato', fontSize: 28),
          headlineSmall: TextStyle(fontFamily: 'Lato', fontSize: 24),
          titleLarge: TextStyle(fontFamily: 'Lato', fontSize: 20),
          titleMedium: TextStyle(fontFamily: 'Lato', fontSize: 18),
          titleSmall: TextStyle(fontFamily: 'Lato', fontSize: 16),
          labelLarge: TextStyle(fontFamily: 'Lato', fontSize: 18),
          labelMedium: TextStyle(fontFamily: 'Lato', fontSize: 16),
          labelSmall: TextStyle(fontFamily: 'Lato', fontSize: 14),
        ),
      ),
      home: LoginScreen(),
    );
  }
}
