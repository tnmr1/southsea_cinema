
import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';

void main() {
  // Initialise Flutter services for loading JSON assets
  TestWidgetsFlutterBinding.ensureInitialized();

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

      // Check Iron Man
      final Movie ironMan = movies[0];

      expect(ironMan.id, 'iron-man');
      expect(ironMan.title, 'Iron Man');
      expect(ironMan.ticketPrice, 7.50);
      expect(ironMan.posterImagePath, isNotEmpty);

      // Check Captain America
      final Movie captainAmerica = movies[1];

      expect(captainAmerica.id, 'captain-america');
      expect(captainAmerica.title, 'Captain America');
      expect(captainAmerica.ticketPrice, 7.50);
      expect(captainAmerica.posterImagePath, isNotEmpty);
    });

    // Test 3: Find a movie using an existing ID
    test('getMovieById returns matching movie', () {
      final MovieRepository repository = MovieRepository();

      final Movie? movie =
          repository.getMovieById('iron-man');

      expect(movie, isNotNull);
      expect(movie?.title, 'Iron Man');
      expect(movie?.ticketPrice, 7.50);
    });

    // Test 4: Check what happens when an ID does not exist
    test('getMovieById returns null for missing ID', () {
      final MovieRepository repository = MovieRepository();

      final Movie? movie =
          repository.getMovieById('non-existent');

      expect(movie, isNull);
    });

    // Test 5: Load movies from the JSON asset
    test('loadMoviesFromAsset reads the bundled JSON movies',
        () async {
      final MovieRepository repository = MovieRepository();

      // Load movie data from assets/data/movies.json
      final List<Movie> movies =
          await repository.loadMoviesFromAsset();

      // Check that both movies are loaded
      expect(movies.length, 2);

      // Check the movie IDs
      expect(movies[0].id, 'iron-man');
      expect(movies[1].id, 'captain-america');

      // Check movie information
      expect(movies[0].title, 'Iron Man');
      expect(movies[1].title, 'Captain America');

      // Check ticket prices
      expect(movies[0].ticketPrice, 7.50);
      expect(movies[1].ticketPrice, 7.50);

      // Check that the repository cached the loaded movies
      expect(repository.getMovies(), movies);
    });
  });
}

// Test summary:
//
// Test 1: Repository returns exactly two movies
// Test 2: Both movies have the expected information
// Test 3: Existing ID returns the correct movie
// Test 4: Missing ID returns null
// Test 5: JSON asset loads both movies correctly
