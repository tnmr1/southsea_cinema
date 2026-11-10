import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/views/settings_view.dart';

void main() {
  // Check that the settings form displays correctly
  testWidgets('SettingsView displays form fields and switch',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SettingsView(),
      ),
    );

    expect(find.text('Customer Profile'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(3));
    expect(find.byType(Switch), findsOneWidget);
    expect(find.text('Save Settings'), findsOneWidget);
  });

  // Check that customer settings can be updated
  testWidgets('Saving customer settings displays confirmation',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SettingsView(),
      ),
    );

    // Find the text fields
    final Finder nameField = find.widgetWithText(TextField, 'Full name');

    final Finder addressField =
        find.widgetWithText(TextField, 'Delivery address');

    final Finder emailField = find.widgetWithText(TextField, 'Email address');

    // Enter fictional customer details
    await tester.enterText(nameField, 'Alex Smith');
    await tester.enterText(
      addressField,
      '10 Elm Road, Portsmouth',
    );
    await tester.enterText(
      emailField,
      'alex@example.com',
    );

    // Check the newsletter switch starts off
    final Finder switchFinder = find.byType(Switch);

    expect(
      tester.widget<Switch>(switchFinder).value,
      isFalse,
    );

    // Turn on the newsletter switch
    await tester.tap(switchFinder);
    await tester.pump();

    expect(
      tester.widget<Switch>(switchFinder).value,
      isTrue,
    );

    // Tap Save Settings
    await tester.ensureVisible(find.text('Save Settings'));
    await tester.tap(find.text('Save Settings'));
    await tester.pump();

    // Check the confirmation message
    expect(
      find.text('Settings saved for Alex Smith'),
      findsOneWidget,
    );
  });
}
