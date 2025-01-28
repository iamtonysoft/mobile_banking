import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_banking/screens/transaction/send_money_screen.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('Send Money Screen Tests', () {
    testWidgets('Send Money with blank fields', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SendMoneyScreen(),
        ),
      );

      await tester.enterText(find.byType(TextField).first, '');
      await tester.enterText(find.byType(TextField).last, '');

      await tester.tap(find.byType(TextButton));
      await tester.pumpAndSettle();

      expect(find.text('Please enter the account/reference number'), findsOneWidget);
      expect(find.text('Please enter the amount'), findsOneWidget);
    });
  });
}
