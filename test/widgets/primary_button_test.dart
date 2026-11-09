
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

void main() {
  // Check that the button displays its label
  testWidgets('PrimaryButton displays its label',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryButton(
            label: 'BOOK NOW',
            onPressed: () {},
          ),
        ),
      ),
    );

    expect(find.text('BOOK NOW'), findsOneWidget);
  });

  // Check that the button responds when tapped
  testWidgets('PrimaryButton invokes onPressed when tapped',
      (WidgetTester tester) async {
    bool wasPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PrimaryButton(
            label: 'BOOK NOW',
            onPressed: () {
              wasPressed = true;
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('BOOK NOW'));
    await tester.pump();

    expect(wasPressed, isTrue);
  });
}

// What do the tests check?
// Test	Expected result
// Label test	Finds exactly one BOOK NOW button label
// Callback test	wasPressed becomes true after tapping