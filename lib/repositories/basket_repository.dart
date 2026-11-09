
import 'package:southsea_cinema/models/basket_item.dart';

// Shared repository for cinema tickets
class BasketRepository {
  // Private constructor
  BasketRepository._internal();

  // Single shared instance
  static final BasketRepository instance =
      BasketRepository._internal();

  // Stores all basket items
  final List<BasketItem> _items = [];

  // Returns an unmodifiable list of basket items
  List<BasketItem> getItems() {
    return List<BasketItem>.unmodifiable(_items);
  }

  // Adds tickets to the basket
  void addItem(BasketItem item) {
    _items.add(item);
  }

  // Removes a basket item using its index
  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
    }
  }

  // Calculates the total number of tickets
  int getTotalItems() {
    int total = 0;

    for (final BasketItem item in _items) {
      total += item.quantity;
    }

    return total;
  }

  // Getter for total ticket quantity
  int get totalItemCount {
    return getTotalItems();
  }

  // Calculates the total ticket price
  double getSubtotal() {
    double sum = 0.0;

    for (final BasketItem item in _items) {
      sum += item.lineTotal;
    }

    return sum;
  }

  // Returns the total cost of all tickets
  double getTotalDue() {
    return getSubtotal();
  }

  // Clears all tickets from the basket
  void clear() {
    _items.clear();
  }
}

// Understanding the repository
// Method	Purpose
// BasketRepository.instance	Accesses the shared basket
// addItem()	Adds tickets
// getItems()	Returns basket contents
// removeItem()	Removes a basket entry
// getTotalItems()	Counts all tickets
// getSubtotal()	Calculates the ticket subtotal
// getTotalDue()	Returns the amount payable
// clear()	Empties the basket

// The Sandwich Shop example includes a delivery fee. I've left that out because your cinema exercise asks for ticket totals and does not specify a delivery charge.
// Why use a singleton?
// A singleton ensures that the home page, movie listing page and basket page can all access the same repository instance.
// Without shared state, adding tickets on one screen might not make them available on another.