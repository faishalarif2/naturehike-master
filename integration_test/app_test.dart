import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naturehike/view/login.dart';
import 'package:integration_test/integration_test.dart';
import 'package:naturehike/main.dart ' as app;

void main (){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Login Test',(){
    testWidgets('Verify Correct Username and Password to Login Screen', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));

      await tester.enterText(find.byType(TextFormField).at(0), 'admin@gmail.com');
      await Future.delayed(const Duration(seconds: 2));

      await tester.enterText(find.byType(TextFormField).at(1), 'admin123');
      await Future.delayed(const Duration(seconds: 2));

      await tester.tap(find.byType(ElevatedButton));
      await Future.delayed(const Duration(seconds: 2));

      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));
      expect(find.byType(Login), findsOneWidget);
      },
    );
  });
}