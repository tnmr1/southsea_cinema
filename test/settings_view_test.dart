
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/views/settings_view.dart';

void main() {
  // Test 1: Check that the settings form displays correctly.
  testWidgets('SettingsView displays form fields and switches',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SettingsView(),
      ),
    );

    // Check the customer profile heading.
    expect(find.text('Customer Profile'), findsOneWidget);

    // Check all three text fields.
    expect(find.byType(TextField), findsNWidgets(3));

    // Worksheet 8: There are now two switches.
    expect(find.byType(Switch), findsNWidgets(2));

    // Check the newsletter option.
    expect(
      find.text('Receive newsletter and offers'),
      findsOneWidget,
    );

    // Check the new accessibility option.
    expect(find.text('Bigger text'), findsOneWidget);

    // Check the save button.
    expect(find.text('Save Settings'), findsOneWidget);
  });

  // Test 2: Check that customer settings can be saved.
  testWidgets('Saving customer settings displays confirmation',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SettingsView(),
      ),
    );

    // Find the customer information fields.
    final Finder nameField =
        find.widgetWithText(TextField, 'Full name');

    final Finder addressField =
        find.widgetWithText(TextField, 'Delivery address');

    final Finder emailField =
        find.widgetWithText(TextField, 'Email address');

    // Enter fictional customer information.
    await tester.enterText(nameField, 'Alex Smith');

    await tester.enterText(
      addressField,
      '10 Elm Road, Portsmouth',
    );

    await tester.enterText(
      emailField,
      'alex@example.com',
    );

    // Find only the original newsletter switch.
    // The Bigger text switch is a separate accessibility setting.
    final Finder newsletterSwitch = find
        .byType(Switch)
        .first;

    // Check the newsletter starts switched off.
    expect(
      tester.widget<Switch>(newsletterSwitch).value,
      isFalse,
    );

    // Turn on the newsletter.
    await tester.tap(newsletterSwitch);
    await tester.pump();

    // Check the newsletter is now on.
    expect(
      tester.widget<Switch>(newsletterSwitch).value,
      isTrue,
    );

    // Save the customer settings.
    await tester.ensureVisible(find.text('Save Settings'));
    await tester.tap(find.text('Save Settings'));
    await tester.pump();

    // Check the confirmation message.
    expect(
      find.text('Settings saved for Alex Smith'),
      findsOneWidget,
    );
  });

  // Test 3: Worksheet 8 accessibility switch.
  testWidgets('Bigger text switch can be turned on and off',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SettingsView(),
      ),
    );

    // Find the new Bigger text switch.
    final Finder biggerTextTile =
        find.widgetWithText(SwitchListTile, 'Bigger text');

    // Check the setting starts switched off.
    expect(
      tester.widget<SwitchListTile>(biggerTextTile).value,
      isFalse,
    );

    // Turn on Bigger text.
    await tester.tap(biggerTextTile);
    await tester.pump();

    expect(
      tester.widget<SwitchListTile>(biggerTextTile).value,
      isTrue,
    );

    // Turn Bigger text off again.
    await tester.tap(biggerTextTile);
    await tester.pump();

    expect(
      tester.widget<SwitchListTile>(biggerTextTile).value,
      isFalse,
    );
  });
}

