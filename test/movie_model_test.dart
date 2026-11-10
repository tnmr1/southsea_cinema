
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';

void main() {
  group('Movie model tests', () {
    // Test 1: Check that Movie stores correct information
    test('creates Movie instance with given properties', () {
      const Movie movie = Movie(
        id: 'iron-man',
        title: 'Iron Man',
        synopsis: 'A superhero film about Iron Man.',
        ageRating: '12A',
        screeningTime: '18:00',
        ticketPrice: 7.50,
        posterImagePath: 'assets/images/iron man.jpeg',
      );

      expect(movie.id, 'iron-man');
      expect(movie.title, 'Iron Man');
      expect(movie.synopsis, 'A superhero film about Iron Man.');
      expect(movie.ageRating, '12A');
      expect(movie.screeningTime, '18:00');
      expect(movie.ticketPrice, 7.50);
      expect(
        movie.posterImagePath,
        'assets/images/iron man.jpeg',
      );
    });

    // Test 2: Check formatted ticket prices
    test('formats ticket price correctly', () {
      const Movie wholePriceMovie = Movie(
        id: 'whole-price',
        title: 'Test Movie',
        synopsis: 'Test description',
        ageRating: '12A',
        screeningTime: '18:00',
        ticketPrice: 5.00,
        posterImagePath: 'assets/images/captain.jpg',
      );

      const Movie pencePriceMovie = Movie(
        id: 'pence-price',
        title: 'Test Movie 2',
        synopsis: 'Test description',
        ageRating: '12A',
        screeningTime: '20:00',
        ticketPrice: 7.50,
        posterImagePath: 'assets/images/iron man.jpeg',
      );

      expect(wholePriceMovie.formattedPrice, '£5.00');
      expect(pencePriceMovie.formattedPrice, '£7.50');
    });

    // Test 3: Convert JSON into Movie and back
    test('converts Movie from and to JSON', () {
      final Map<String, dynamic> json = {
        'id': 'iron-man',
        'title': 'Iron Man',
        'synopsis': 'A superhero film about Iron Man.',
        'ageRating': '12A',
        'screeningTime': '18:00',
        'ticketPrice': 7.50,
        'posterImagePath': 'assets/images/iron man.jpeg',
      };

      // Convert JSON map into Movie
      final Movie movie = Movie.fromJson(json);

      // Check all movie properties
      expect(movie.id, 'iron-man');
      expect(movie.title, 'Iron Man');
      expect(
        movie.synopsis,
        'A superhero film about Iron Man.',
      );
      expect(movie.ageRating, '12A');
      expect(movie.screeningTime, '18:00');
      expect(movie.ticketPrice, 7.50);
      expect(
        movie.posterImagePath,
        'assets/images/iron man.jpeg',
      );

      // Convert Movie back into a map
      expect(movie.toJson(), json);
    });

    // Test 4: Check whole-number JSON prices
    test('converts whole-number ticket price to double', () {
      final Map<String, dynamic> json = {
        'id': 'test-movie',
        'title': 'Test Movie',
        'synopsis': 'Test description',
        'ageRating': 'PG',
        'screeningTime': '14:00',
        'ticketPrice': 5,
        'posterImagePath': 'assets/images/captain.jpg',
      };

      final Movie movie = Movie.fromJson(json);

      expect(movie.ticketPrice, 5.0);
      expect(movie.ticketPrice, isA<double>());
      expect(movie.formattedPrice, '£5.00');
    });
  });
}

// have we added?
// Test	Purpose
// Test 1	Checks the original Movie properties
// Test 2	Checks ticket price formatting
// Test 3	Checks JSON conversion in both directions
// Test 4	Checks whole-number prices become doubles