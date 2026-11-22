
class Booking {
  // The unique ID for the booking.
  // SQLite will generate this automatically.
  final int? id;

  // The booking number for the customer.
  final int bookingNumber;

  // A description of what was booked.
  final String summary;

  // The total price of the booking.
  final double total;

  // The date the booking was made.
  final String date;

  // Constructor used to create a Booking object.
  const Booking({
    this.id,
    required this.bookingNumber,
    required this.summary,
    required this.total,
    required this.date,
  });

  // Converts a Booking object into a Map.
  // SQLite uses this Map to save booking information.
  Map<String, Object?> toMap() {
    final Map<String, Object?> data = <String, Object?>{
      'booking_number': bookingNumber,
      'summary': summary,
      'total': total,
      'date': date,
    };

    // Only include the ID if the booking already has one.
    if (id != null) {
      data['id'] = id;
    }

    return data;
  }

  // Converts a Map from SQLite back into a Booking object.
  factory Booking.fromMap(Map<String, Object?> map) {
    // Read each value from the database Map.
    final int bookingNumber = map['booking_number'] as int;
    final String summary = map['summary'] as String;
    final num totalNumber = map['total'] as num;

    // Convert the stored number into a double.
    final double total = totalNumber.toDouble();

    final String date = map['date'] as String;

    // Create and return a Booking using the stored values.
    return Booking(
      id: map['id'] as int?,
      bookingNumber: bookingNumber,
      summary: summary,
      total: total,
      date: date,
    );
  }
}
