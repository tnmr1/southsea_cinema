import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';

// Sample movie used for testing
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
  // Clear the shared basket before each test
  setUp(() {
    BasketRepository.instance.clear();
  });

  group('BasketRepository tests', () {
    // Test 1: Empty basket
    test('starts with an empty basket', () {
      final BasketRepository basket = BasketRepository.instance;

      expect(basket.getItems().length, 0);
      expect(basket.getTotalItems(), 0);
      expect(basket.totalItemCount, 0);
      expect(basket.getSubtotal(), 0.0);
      expect(basket.getTotalDue(), 0.0);
    });

    // Test 2: Adding tickets
    test('adds tickets and calculates total', () {
      final BasketRepository basket = BasketRepository.instance;

      const BasketItem item = BasketItem(
        movie: testMovie,
        quantity: 2,
      );

      basket.addItem(item);

      expect(basket.getItems().length, 1);
      expect(basket.getTotalItems(), 2);
      expect(basket.getSubtotal(), 15.0);
      expect(basket.getTotalDue(), 15.0);
    });

    // Test 3: Removing tickets
    test('removes basket items correctly', () {
      final BasketRepository basket = BasketRepository.instance;

      const BasketItem item = BasketItem(
        movie: testMovie,
        quantity: 1,
      );

      basket.addItem(item);

      expect(basket.getItems().length, 1);

      basket.removeItem(0);

      expect(basket.getItems().length, 0);
      expect(basket.getTotalDue(), 0.0);
    });

    // Test 4: Clearing the basket
    test('clears all basket items', () {
      final BasketRepository basket = BasketRepository.instance;

      const BasketItem item = BasketItem(
        movie: testMovie,
        quantity: 3,
      );

      basket.addItem(item);
      expect(basket.getTotalItems(), 3);

      basket.clear();

      expect(basket.getItems(), isEmpty);
      expect(basket.getTotalItems(), 0);
      expect(basket.getTotalDue(), 0.0);
    });
  });
}
