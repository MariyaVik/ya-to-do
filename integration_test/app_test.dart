import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ya_to_do/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('Settings test', () {
    testWidgets('Change locale to en', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final Finder settingsIconButton = find.byIcon(Icons.settings);

      await tester.tap(settingsIconButton);
      await tester.pumpAndSettle();

      final Finder enLocale = find.widgetWithText(ListTile, 'English').first;

      await tester.tap(enLocale);
      await tester.pumpAndSettle();

      final Finder closeIconButton = find.byIcon(Icons.close);

      await tester.tap(closeIconButton);
      await tester.pumpAndSettle();

      expect(find.text('My to-do'), findsOneWidget);
    });
    testWidgets('Change locale to ru', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final Finder settingsIconButton = find.byIcon(Icons.settings);

      await tester.tap(settingsIconButton);
      await tester.pumpAndSettle();

      final Finder enLocale = find.widgetWithText(ListTile, 'Русский');

      await tester.tap(enLocale);
      await tester.pumpAndSettle();

      final Finder closeIconButton = find.byIcon(Icons.close);

      await tester.tap(closeIconButton);
      await tester.pumpAndSettle();

      expect(find.text('Мои дела'), findsOneWidget);
    });
  });
}
