import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/database/cinema_db.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/models/booking.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/views/basket_view.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// Sample movie used in the basket tests.
const Movie testMovie = Movie(
  id: 'iron-man',
  title: 'Iron Man',
  synopsis: 'A superhero film about Iron Man.',
  ageRating: '12A',
  screeningTime: '18:00',
  ticketPrice: 7.50,
  posterImagePath: 'assets/images/iron man.jpeg',
);

// Wait for an expected widget to appear on the screen.
// This is more reliable than using a fixed 500ms delay.
Future<void> waitForWidget(
  WidgetTester tester,
  Finder finder,
) async {
  // Check repeatedly until the widget appears.
  for (int attempt = 0; attempt < 40; attempt++) {
    // Rebuild the screen.
    await tester.pump();

    // Stop waiting when the widget appears.
    if (finder.evaluate().isNotEmpty) {
      return;
    }

    // Allow real asynchronous SQLite operations to run.
    await tester.runAsync(() async {
      await Future<void>.delayed(
        const Duration(milliseconds: 50),
      );
    });
  }

  // Fail clearly if the widget never appeared.
  expect(finder, findsOneWidget);
}

void main() {
  // Initialise SQLite for the test environment.
  sqfliteFfiInit();

  // Access the shared cinema database.
  final CinemaDatabase cinemaDb = CinemaDatabase.instance;

  // Create a fresh database before every test.
  setUp(() async {
    // Clear tickets left from another test.
    BasketRepository.instance.clear();

    // Create a temporary SQLite database in memory.
    final Database db = await databaseFactoryFfi.openDatabase(
      inMemoryDatabasePath,
    );

    // Create the bookings table.
    await cinemaDb.createTables(db, 1);

    // Use this temporary database during the test.
    cinemaDb.setDatabase(db);
  });

  // Clean up after every test.
  tearDown(() async {
    // Close the temporary database.
    await cinemaDb.close();

    // Clear any remaining basket tickets.
    BasketRepository.instance.clear();
  });

  group('BasketView widget tests', () {
    // Test 1: Empty basket message.
    testWidgets('displays empty basket message', (WidgetTester tester) async {
      // Open the basket screen.
      await tester.pumpWidget(
        const MaterialApp(
          home: BasketView(),
        ),
      );

      // Check the empty basket message.
      expect(
        find.text('Your basket is empty'),
        findsOneWidget,
      );

      // Check the booking history heading.
      expect(
        find.text('Past Bookings'),
        findsOneWidget,
      );
    });

    // Test 2: Display selected tickets and total.
    testWidgets('displays basket items and total', (WidgetTester tester) async {
      // Add two Iron Man tickets.
      BasketRepository.instance.addItem(
        const BasketItem(
          movie: testMovie,
          quantity: 2,
        ),
      );

      // Open the basket screen.
      await tester.pumpWidget(
        const MaterialApp(
          home: BasketView(),
        ),
      );

      // Check the selected movie.
      expect(find.text('Iron Man'), findsOneWidget);

      // Check the ticket quantity.
      expect(find.text('Tickets: 2'), findsOneWidget);

      // Check the total price.
      expect(
        find.text('Total: £15.00'),
        findsOneWidget,
      );
    });

    // Test 3: Remove tickets from the basket.
    testWidgets('removes tickets from basket', (WidgetTester tester) async {
      // Add one ticket.
      BasketRepository.instance.addItem(
        const BasketItem(
          movie: testMovie,
          quantity: 1,
        ),
      );

      // Open the basket screen.
      await tester.pumpWidget(
        const MaterialApp(
          home: BasketView(),
        ),
      );

      // Press Remove.
      await tester.tap(find.text('Remove'));

      // Rebuild the screen.
      await tester.pump();

      // Check that the basket is empty.
      expect(
        find.text('Your basket is empty'),
        findsOneWidget,
      );

      // Check that the repository is empty.
      expect(
        BasketRepository.instance.getItems(),
        isEmpty,
      );
    });

    // Test 4: Checkout clears the basket after saving.
    testWidgets('checkout clears basket', (WidgetTester tester) async {
      // Add three Iron Man tickets.
      BasketRepository.instance.addItem(
        const BasketItem(
          movie: testMovie,
          quantity: 3,
        ),
      );

      // Open the basket screen.
      await tester.pumpWidget(
        const MaterialApp(
          home: BasketView(),
        ),
      );

      // Press Checkout.
      await tester.tap(find.text('Checkout'));

      // Wait until the checkout has cleared the basket.
      await waitForWidget(
        tester,
        find.text('Your basket is empty'),
      );

      // Check that the basket repository is empty.
      expect(
        BasketRepository.instance.getItems(),
        isEmpty,
      );

      // Check that the confirmation message appears.
      expect(
        find.textContaining(
          'Checkout completed! Booking number:',
        ),
        findsOneWidget,
      );
    });

    // Test 5: Display saved bookings in the history.
    testWidgets('displays past bookings', (WidgetTester tester) async {
      // Insert a sample booking using real asynchronous SQLite.
      await tester.runAsync(() async {
        await cinemaDb.insertBooking(
          const Booking(
            bookingNumber: 1001,
            summary: '2 x Iron Man',
            total: 15.00,
            date: '22/11/2026 17:00',
          ),
        );
      });

      // Open the basket screen.
      await tester.pumpWidget(
        const MaterialApp(
          home: BasketView(),
        ),
      );

      // Wait until the saved booking appears on the screen.
      await waitForWidget(
        tester,
        find.text('Booking #1001'),
      );

      // Check the booking history heading.
      expect(
        find.text('Past Bookings'),
        findsOneWidget,
      );

      // Check the booking number.
      expect(
        find.text('Booking #1001'),
        findsOneWidget,
      );

      // Check the saved movie details.
      expect(
        find.text('2 x Iron Man'),
        findsOneWidget,
      );

      // Check the saved booking total.
      expect(
        find.text('Total: £15.00'),
        findsOneWidget,
      );
    });

    // Test 6: Checkout saves a booking to SQLite.
    testWidgets('checkout saves booking to SQLite',
        (WidgetTester tester) async {
      // Add two cinema tickets.
      BasketRepository.instance.addItem(
        const BasketItem(
          movie: testMovie,
          quantity: 2,
        ),
      );

      // Open the basket screen.
      await tester.pumpWidget(
        const MaterialApp(
          home: BasketView(),
        ),
      );

      // Press Checkout.
      await tester.tap(find.text('Checkout'));

      // Wait for checkout to finish.
      await waitForWidget(
        tester,
        find.text('Your basket is empty'),
      );

      // Read SQLite bookings outside Flutter's simulated time.
      final List<Booking>? bookings = await tester.runAsync(() async {
        return await cinemaDb.getAllBookings();
      });

      // Check that exactly one booking was saved.
      expect(bookings, isNotNull);
      expect(bookings!.length, 1);

      // Check the booking number.
      expect(bookings.first.bookingNumber, 1001);

      // Check the saved movie details.
      expect(bookings.first.summary, '2 x Iron Man');

      // Check the booking total.
      expect(bookings.first.total, 15.00);
    });
  });
}
