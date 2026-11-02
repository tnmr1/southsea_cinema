import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

void main() {
  group('MovieRepository unit tests', () {
    // Test 1: Check that two movies are returned
    test('getMovies returns two movies', () {
      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = repository.getMovies();

      expect(movies.length, 2);
    });

    // Test 2: Check the movie details
    test('getMovies contains valid movies', () {
      final MovieRepository repository = MovieRepository();
      final List<Movie> movies = repository.getMovies();

      final Movie ironMan = movies[0];
      expect(ironMan.id, 'iron-man');
      expect(ironMan.title, 'Iron Man');
      expect(ironMan.ticketPrice, 7.50);
      expect(ironMan.posterImagePath, isNotEmpty);

      final Movie captainAmerica = movies[1];
      expect(captainAmerica.id, 'captain-america');
      expect(captainAmerica.title, 'Captain America');
      expect(captainAmerica.ticketPrice, 7.50);
      expect(captainAmerica.posterImagePath, isNotEmpty);
    });

    // Test 3: Find a movie using an existing ID
    test('getMovieById returns matching movie', () {
      final MovieRepository repository = MovieRepository();
      final Movie? movie = repository.getMovieById('iron-man');

      expect(movie, isNotNull);
      expect(movie?.title, 'Iron Man');
      expect(movie?.ticketPrice, 7.50);
    });

    // Test 4: Check what happens when an ID does not exist
    test('getMovieById returns null for missing ID', () {
      final MovieRepository repository = MovieRepository();
      final Movie? movie = repository.getMovieById('non-existent');

      expect(movie, isNull);
    });
  });
}

// What each test checks
// Test 	Purpose
// 1	    Repository returns exactly two movies
// 2	    Both movies have the expected details
// 3	    An existing ID returns the correct movie
// 4	    A missing ID returns null
