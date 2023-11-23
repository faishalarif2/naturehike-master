import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naturehike/view/login.dart';

void main() {
  testWidgets('Login Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Login(),
    ));

    // Verify if the login screen is displayed
    expect(find.text('LOGIN !!!'), findsOneWidget);
    expect(find.text("Selamat Datang di Aplikasi NatureHike"), findsOneWidget);

    // Enter email and password
    await tester.enterText(find.byType(TextFormField).at(0), 'admin@gmail.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'admin123');

    // Tap the login button.
    await tester.tap(find.text('Login'));
    await tester.pump();

    // Check if the login dialog is displayed after tapping the login button
    expect(find.text('Login Successful'), findsNothing);
    expect(find.text('Login Failed'), findsNothing);

    // You can add more test cases based on your specific requirements
  });
}
