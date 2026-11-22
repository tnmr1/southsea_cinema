
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Worksheet 8: In-memory storage for testing SharedPreferencesAsync.
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/views/settings_view.dart';

void main() {
  // Worksheet 8: Reset all preferences before each test.
  setUp(() {
    // Mock the original SharedPreferences API for Bigger text.
    SharedPreferences.setMockInitialValues({});

    // Mock SharedPreferencesAsync for Dark mode.
    // This prevents the "instance must be set" error.
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();

    // Give every test the same starting settings.
    biggerTextEnabled.value = false;
    cinemaThemeMode.value = ThemeMode.dark;
  });

  // Test 1: Check the settings form displays correctly.
  testWidgets(
    'SettingsView displays form fields and switches',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SettingsView(),
        ),
      );

      // Check the customer profile heading.
      expect(find.text('Customer Profile'), findsOneWidget);

      // Check all three customer information fields.
      expect(find.byType(TextField), findsNWidgets(3));

      // Newsletter, Bigger text and Dark mode.
      expect(find.byType(Switch), findsNWidgets(3));

      // Check all settings labels.
      expect(
        find.text('Receive newsletter and offers'),
        findsOneWidget,
      );
      expect(find.text('Bigger text'), findsOneWidget);
      expect(find.text('Dark mode'), findsOneWidget);

      // Check the Save Settings button.
      expect(find.text('Save Settings'), findsOneWidget);
    },
  );

  // Test 2: Check customer settings can be saved.
  testWidgets(
    'Saving customer settings displays confirmation',
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

      // Newsletter is the first Switch widget.
      final Finder newsletterSwitch =
          find.byType(Switch).first;

      // Check newsletter starts switched off.
      expect(
        tester.widget<Switch>(newsletterSwitch).value,
        isFalse,
      );

      // Turn newsletter on.
      await tester.tap(newsletterSwitch);
      await tester.pump();

      expect(
        tester.widget<Switch>(newsletterSwitch).value,
        isTrue,
      );

      // Save the profile.
      await tester.ensureVisible(
        find.text('Save Settings'),
      );

      await tester.tap(find.text('Save Settings'));
      await tester.pump();

      // Check the confirmation message.
      expect(
        find.text('Settings saved for Alex Smith'),
        findsOneWidget,
      );
    },
  );

  // Test 3: Worksheet 8 Bigger text accessibility.
  testWidgets(
    'Bigger text switch can be turned on and off',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SettingsView(),
        ),
      );

      // Find the Bigger text setting.
      final Finder biggerTextTile =
          find.widgetWithText(SwitchListTile, 'Bigger text');

      // Check the setting starts switched off.
      expect(
        tester.widget<SwitchListTile>(biggerTextTile).value,
        isFalse,
      );

      // Turn Bigger text on.
      await tester.ensureVisible(biggerTextTile);
      await tester.tap(biggerTextTile);
      await tester.pump();

      expect(
        tester.widget<SwitchListTile>(biggerTextTile).value,
        isTrue,
      );
      expect(biggerTextEnabled.value, isTrue);

      // Turn Bigger text off again.
      await tester.tap(biggerTextTile);
      await tester.pump();

      expect(
        tester.widget<SwitchListTile>(biggerTextTile).value,
        isFalse,
      );
      expect(biggerTextEnabled.value, isFalse);
    },
  );

  // Test 4: Worksheet 8 Light/Dark mode.
  testWidgets(
    'Dark mode switch can be turned on and off',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SettingsView(),
        ),
      );

      // Find the Dark mode setting.
      final Finder darkModeTile =
          find.widgetWithText(SwitchListTile, 'Dark mode');

      // The app starts in dark mode.
      expect(
        tester.widget<SwitchListTile>(darkModeTile).value,
        isTrue,
      );

      // Turn Dark mode off.
      await tester.ensureVisible(darkModeTile);
      await tester.tap(darkModeTile);
      await tester.pump();

      // Check the switch and theme notifier.
      expect(
        tester.widget<SwitchListTile>(darkModeTile).value,
        isFalse,
      );
      expect(cinemaThemeMode.value, ThemeMode.light);

      // Turn Dark mode back on.
      await tester.tap(darkModeTile);
      await tester.pump();

      expect(
        tester.widget<SwitchListTile>(darkModeTile).value,
        isTrue,
      );
      expect(cinemaThemeMode.value, ThemeMode.dark);

      // Check that the final preference was saved.
      final SharedPreferencesAsync prefs =
          SharedPreferencesAsync();

      expect(await prefs.getBool('darkMode'), isTrue);
    },
  );
}
