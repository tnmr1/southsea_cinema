import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/database/cinema_db.dart';
import 'package:southsea_cinema/models/booking.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // Set up SQLite so database tests can run on the computer.
  sqfliteFfiInit();

  // Get the shared cinema database helper.
  final CinemaDatabase cinemaDb = CinemaDatabase.instance;

  // Create a fresh database before each test.
  setUp(() async {
    // Open a temporary database stored in memory.
    final Database db = await databaseFactoryFfi.openDatabase(
      inMemoryDatabasePath,
    );

    // Create the bookings table.
    await cinemaDb.createTables(db, 1);

    // Tell CinemaDatabase to use the test database.
    cinemaDb.setDatabase(db);
  });

  // Close the database after each test.
  tearDown(() async {
    await cinemaDb.close();
  });

  // Test 1: Check that a new database starts empty.
  test('New database has no bookings', () async {
    // Read all bookings from the database.
    final List<Booking> bookings = await cinemaDb.getAllBookings();

    // There should be no bookings yet.
    expect(bookings, isEmpty);
  });

  // Test 2: Check that bookings can be saved and retrieved.
  test('Can save and retrieve a booking', () async {
    // Create a sample cinema booking.
    const Booking booking = Booking(
      bookingNumber: 1001,
      summary: '2 x Adult Tickets',
      total: 16.50,
      date: '22/11/2026 14:00',
    );

    // Save the booking to SQLite.
    final int id = await cinemaDb.insertBooking(booking);

    // Check that SQLite generated an ID.
    expect(id, greaterThan(0));

    // Read the saved bookings.
    final List<Booking> bookings = await cinemaDb.getAllBookings();

    // Check that one booking was saved.
    expect(bookings.length, 1);

    // Check that the saved booking has the correct details.
    expect(bookings.first.bookingNumber, 1001);
    expect(bookings.first.summary, '2 x Adult Tickets');
    expect(bookings.first.total, 16.50);
  });

  // Test 3: Check that booking numbers increase correctly.
  test('Generates the next booking number', () async {
    // An empty database should start with booking 1001.
    expect(await cinemaDb.nextBookingNumber(), 1001);

    // Save a booking numbered 1003.
    const Booking booking = Booking(
      bookingNumber: 1003,
      summary: '1 x Student Ticket',
      total: 6.00,
      date: '22/11/2026 15:00',
    );

    await cinemaDb.insertBooking(booking);

    // The next booking number should now be 1004.
    expect(await cinemaDb.nextBookingNumber(), 1004);
  });

  // Test 4: Check that bookings appear newest first.
  test('Bookings are returned in descending order', () async {
    // Create the first booking.
    const Booking firstBooking = Booking(
      bookingNumber: 1001,
      summary: '1 x Adult Ticket',
      total: 8.00,
      date: '01/01/2026 10:00',
    );

    // Create the second booking.
    const Booking secondBooking = Booking(
      bookingNumber: 1003,
      summary: '2 x Student Tickets',
      total: 12.00,
      date: '03/01/2026 12:00',
    );

    // Create the third booking.
    const Booking thirdBooking = Booking(
      bookingNumber: 1002,
      summary: '1 x Student Ticket',
      total: 6.00,
      date: '02/01/2026 11:00',
    );

    // Save the bookings in mixed order.
    await cinemaDb.insertBooking(firstBooking);
    await cinemaDb.insertBooking(secondBooking);
    await cinemaDb.insertBooking(thirdBooking);

    // Retrieve all saved bookings.
    final List<Booking> bookings = await cinemaDb.getAllBookings();

    // Check that all three bookings were saved.
    expect(bookings.length, 3);

    // The highest booking number must appear first.
    expect(bookings[0].bookingNumber, 1003);
    expect(bookings[1].bookingNumber, 1002);
    expect(bookings[2].bookingNumber, 1001);
  });
}
