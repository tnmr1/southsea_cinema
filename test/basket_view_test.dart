import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/views/basket_view.dart';

// Sample movie for testing
const Movie testMovie = Movie(
  id: 'iron-man',
  title: 'Iron Man',
  synopsis: 'A superhero film about Iron Man.',
  ageRating: '12A',
  screeningTime: '18:00',
  ticketPrice: 7.50,
  posterImagePath: 'assets/images/iron man.jpeg',
);

void main() {
  // Clear the shared basket before every test
  setUp(() {
    BasketRepository.instance.clear();
  });

  group('BasketView widget tests', () {
    // Test 1: Empty basket message
    testWidgets('displays empty basket message', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: BasketView(),
        ),
      );

      expect(
        find.text('Your basket is empty'),
        findsOneWidget,
      );
    });

    // Test 2: Display selected tickets
    testWidgets('displays basket items and total', (WidgetTester tester) async {
      // Add two Iron Man tickets
      BasketRepository.instance.addItem(
        const BasketItem(
          movie: testMovie,
          quantity: 2,
        ),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: BasketView(),
        ),
      );

      // Check movie title
      expect(find.text('Iron Man'), findsOneWidget);

      // Check ticket quantity
      expect(find.text('Tickets: 2'), findsOneWidget);

      // Check total price
      expect(
        find.text('Total: £15.00'),
        findsOneWidget,
      );
    });

    // Test 3: Remove tickets
    testWidgets('removes tickets from basket', (WidgetTester tester) async {
      BasketRepository.instance.addItem(
        const BasketItem(
          movie: testMovie,
          quantity: 1,
        ),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: BasketView(),
        ),
      );

      // Tap the Remove button
      await tester.tap(find.text('Remove'));
      await tester.pump();

      // Basket should now be empty
      expect(
        find.text('Your basket is empty'),
        findsOneWidget,
      );

      expect(
        BasketRepository.instance.getItems(),
        isEmpty,
      );
    });

    // Test 4: Checkout clears basket
    testWidgets('checkout clears basket', (WidgetTester tester) async {
      BasketRepository.instance.addItem(
        const BasketItem(
          movie: testMovie,
          quantity: 3,
        ),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: BasketView(),
        ),
      );

      // Tap Checkout
      await tester.tap(find.text('Checkout'));
      await tester.pump();

      // Check that the basket is empty
      expect(
        BasketRepository.instance.getItems(),
        isEmpty,
      );

      expect(
        find.text('Your basket is empty'),
        findsOneWidget,
      );

      // Check confirmation message
      expect(
        find.text('Checkout completed successfully'),
        findsOneWidget,
      );
    });
  });
}

// Empty basket	Displays "Your basket is empty"
// Display tickets	Shows the correct movie, quantity and total
// Remove tickets	Removes the selected item
// Checkout	Clears the basket and displays confirmation

// Why do we use setUp()?
// Your basket repository is a singleton.

// That means it stores its contents between tests unless we clear them.
// setUp(() {
//   BasketRepository.instance.clear();
// });

// This ensures every test starts with an empty basket.
