
import 'package:southsea_cinema/models/movie.dart';

// Represents one movie and its ticket quantity
class BasketItem {
  final Movie movie;
  final int quantity;

  const BasketItem({
    required this.movie,
    required this.quantity,
  });

  // Total price for this basket item
  double get lineTotal {
    return movie.ticketPrice * quantity;
  }
}

// What does this do?
// A Movie stores information about a film.

// A BasketItem stores the selected film and the number of tickets the customer wants.

// For example, if Iron Man costs £7.50:
// Quantity	Line total
// 1 ticket	£7.50
// 2 tickets	£15.00
// 3 tickets	£22.50

// The lineTotal getter calculates this automatically.

