import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';

void main() {
  // Group tests related to the Movie model
  group('Movie model tests', () {
    // Check that a Movie stores the correct information
    test('creates Movie instance with given properties', () {
      const movie = Movie(
        id: 'iron-man',
        title: 'Iron Man',
        synopsis: 'A superhero film about Iron Man.',
        ageRating: '12A',
        screeningTime: '18:00',
        ticketPrice: 7.50,
        posterImagePath: 'assets/images/iron man.jpeg',
      );

      // Check each property matches the supplied value
      expect(movie.id, 'iron-man');
      expect(movie.title, 'Iron Man');
      expect(movie.synopsis, 'A superhero film about Iron Man.');
      expect(movie.ageRating, '12A');
      expect(movie.screeningTime, '18:00');
      expect(movie.ticketPrice, 7.50);
      expect(movie.posterImagePath, 'assets/images/iron man.jpeg');
    });

    // Test that formattedPrice displays two decimal places
    test('formats ticket price correctly', () {
      // Movie with a whole-pound ticket price
      const wholePriceMovie = Movie(
        id: 'whole-price',
        title: 'Test Movie',
        synopsis: 'Test description',
        ageRating: '12A',
        screeningTime: '18:00',
        ticketPrice: 5.00,
        posterImagePath: 'assets/images/captain.jpg',
      );

      // Movie with a price containing pence
      const pencePriceMovie = Movie(
        id: 'pence-price',
        title: 'Test Movie 2',
        synopsis: 'Test description',
        ageRating: '12A',
        screeningTime: '20:00',
        ticketPrice: 7.50,
        posterImagePath: 'assets/images/iron man.jpeg',
      );

      // Check both prices are formatted correctly
      expect(wholePriceMovie.formattedPrice, '£5.00');
      expect(pencePriceMovie.formattedPrice, '£7.50');
    });
  });
}

// Code	Meaning
// main()	Starting point for the tests
// group()	Groups related tests together
// test()	Defines an individual test
// const Movie(...)	Creates a sample Movie object
// expect(actual, expected)	Checks that the actual value matches the expected value
