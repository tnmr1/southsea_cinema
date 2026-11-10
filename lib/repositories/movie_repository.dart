import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:southsea_cinema/models/movie.dart';

// Repository responsible for providing movie data
class MovieRepository {
  // Stores the most recently loaded movies
  List<Movie>? _cachedMovies;

  // Returns the available movies
  List<Movie> getMovies() {
    // Return the loaded JSON movies if available
    final List<Movie>? cachedMovies = _cachedMovies;

    if (cachedMovies != null) {
      return cachedMovies;
    }

    // Original data for existing synchronous tests
    return [
      const Movie(
        id: 'iron-man',
        title: 'Iron Man',
        synopsis: 'A superhero film about Iron Man.',
        ageRating: '12A',
        screeningTime: '18:00',
        ticketPrice: 7.50,
        posterImagePath: 'assets/images/iron man.jpeg',
      ),
      const Movie(
        id: 'captain-america',
        title: 'Captain America',
        synopsis: 'A superhero film about Captain America.',
        ageRating: '12A',
        screeningTime: '20:00',
        ticketPrice: 7.50,
        posterImagePath: 'assets/images/captain.jpg',
      ),
    ];
  }

  // Finds a movie using its unique ID
  Movie? getMovieById(String id) {
    for (final Movie movie in getMovies()) {
      if (movie.id == id) {
        return movie;
      }
    }

    return null;
  }

  // Load movie data from the bundled JSON asset
  Future<List<Movie>> loadMoviesFromAsset({
    String assetPath = 'assets/data/movies.json',
  }) async {
    // Read the JSON file as text
    final String jsonString = await rootBundle.loadString(assetPath);

    // Decode the JSON text
    final dynamic decodedData = jsonDecode(jsonString);

    // Convert decoded data into a list
    final List<dynamic> jsonList = decodedData as List<dynamic>;

    final List<Movie> loadedMovies = [];

    // Convert each JSON object into a Movie
    for (final dynamic item in jsonList) {
      final Map<String, dynamic> itemMap = item as Map<String, dynamic>;

      final Movie movie = Movie.fromJson(itemMap);

      loadedMovies.add(movie);
    }

    // Cache the loaded movies
    _cachedMovies = loadedMovies;

    return loadedMovies;
  }
}
