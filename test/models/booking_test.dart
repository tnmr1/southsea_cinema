
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/booking.dart';

void main() {
  // Sample booking used for testing.
  const Booking booking = Booking(
    bookingNumber: 1004,
    summary: '2 x Adult Tickets',
    total: 16.50,
    date: '01/01/2026 09:05',
  );

  // Test 1: Check that a new booking converts into a Map.
  test('New bookings omit database ids and convert to map', () {
    // A new booking should not have a database ID yet.
    expect(booking.id, isNull);

    // Check that the Map contains the correct booking details.
    expect(booking.toMap(), <String, Object?>{
      'booking_number': 1004,
      'summary': '2 x Adult Tickets',
      'total': 16.50,
      'date': '01/01/2026 09:05',
    });
  });

  // Test 2: Check that a database Map becomes a Booking.
  test('A database map converts back into a booking', () {
    // Example booking row returned by SQLite.
    final Map<String, Object?> row = <String, Object?>{
      'id': 7,
      'booking_number': 1010,
      'summary': '1 x Student Ticket',
      'total': 6.0,
      'date': '02/01/2026 10:20',
    };

    // Convert the Map back into a Booking object.
    final Booking restored = Booking.fromMap(row);

    // Check that all booking details are correct.
    expect(restored.id, 7);
    expect(restored.bookingNumber, 1010);
    expect(restored.summary, '1 x Student Ticket');
    expect(restored.total, 6.0);
    expect(restored.date, '02/01/2026 10:20');

    // Check that converting it back produces the same Map.
    expect(restored.toMap(), row);
  });

  // Test 3: Check that whole-number prices become doubles.
  test('Whole-number SQLite totals become doubles', () {
    // Create a Map and change the total to an integer.
    final Map<String, Object?> row = booking.toMap();
    row['total'] = 6;

    // Convert the Map into a Booking.
    final Booking restored = Booking.fromMap(row);

    // Check that the total is stored as a double.
    expect(restored.total, 6.0);
    expect(restored.total, isA<double>());
  });
}
