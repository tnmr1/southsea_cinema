import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/views/home_view.dart';

void main() {
  // Group tests for the Southsea Cinema application
  group('App smoke tests', () {
    // Test that the application displays the home page
    testWidgets('App displays HomeView', (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());

      expect(find.byType(HomeView), findsOneWidget);
    });

    // Test that movie cards display their information
    testWidgets('Displays movie cards and booking buttons',
        (WidgetTester tester) async {
      await tester.pumpWidget(const SouthseaCinemaApp());

      // Check both movie titles
      expect(find.text('Iron Man'), findsOneWidget);
      expect(find.text('Captain America'), findsOneWidget);

      // Check the ticket prices
      expect(find.text('£7.50'), findsNWidgets(2));

      // Check that there are two booking buttons
      expect(find.text('BOOK NOW'), findsNWidgets(2));
    });
  });
}

// testWidgets()	Creates a widget test
// WidgetTester tester	Provides tools for interacting with widgets
// pumpWidget()	Builds the app in the test environment
// find.byType(HomeView)	Finds the home page widget
// find.text()	Searches for text displayed on screen
// findsOneWidget	Expects exactly one match
// findsNWidgets(2)	Expects exactly two matches
