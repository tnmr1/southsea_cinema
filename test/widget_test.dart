
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/views/home_view.dart';

void main() {
  // Clear cached JSON assets before each test
  setUp(() {
    rootBundle.clear();
  });

  // Group tests for the Southsea Cinema application
  group('App smoke tests', () {
    // Test 1: Check that the application displays HomeView
    testWidgets('App displays HomeView',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const SouthseaCinemaApp(),
      );

      // Wait for asynchronous movie loading
      await tester.pumpAndSettle();

      // Check that HomeView is displayed
      expect(
        find.byType(HomeView),
        findsOneWidget,
      );
    });

    // Test 2: Check movie cards and booking buttons
    testWidgets('Displays movie cards and booking buttons',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const SouthseaCinemaApp(),
      );

      // Wait for JSON loading to complete
      await tester.pumpAndSettle();

      // Check both movie titles
      expect(
        find.text('Iron Man'),
        findsOneWidget,
      );

      expect(
        find.text('Captain America'),
        findsOneWidget,
      );

      // Check ticket prices
      expect(
        find.text('£7.50'),
        findsNWidgets(2),
      );

      // Check booking buttons
      expect(
        find.text('BOOK NOW'),
        findsNWidgets(2),
      );
    });
  });
}

// Step 2: What changed?
// We've added:
// import 'package:flutter/services.dart';


// And:
// setUp(() {
//   rootBundle.clear();
// });


// The setUp() function runs before each test.

// This ensures that each test starts with cleared asset-read cache state.

// Your pumpAndSettle() calls remain because Worksheet 6 requires the tests to wait for asynchronous movie loading.