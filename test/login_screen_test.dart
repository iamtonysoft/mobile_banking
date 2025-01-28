import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_banking/screens/login/login_screen.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('Login Screen Tests', () {
    testWidgets('Test login with credentials', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoginScreen(),
        ),
      );

      await tester.enterText(find.byType(TextField).first, 'username');
      await tester.enterText(find.byType(TextField).last, 'password');

      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();

      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('Test login with empty credentials', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoginScreen(),
        ),
      );

      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();

      expect(find.text('Username and password cannot be empty.'), findsOneWidget);
    });
  });
}
