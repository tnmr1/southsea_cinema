//import	Gives access to your Movie model
// MovieRepository	Class responsible for providing movie data
// List<Movie>	A list containing Movie objects
// getMovies()	Method that returns the movies
// return [];	An empty list until we add movie details
import 'package:southsea_cinema/models/movie.dart';

// Repository responsible for providing movie data
class MovieRepository {
  // Returns a list of movies
  // Returns the movies available at Southsea Cinema
  List<Movie> getMovies() {
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
    // Go through each movie in the repository
    for (final movie in getMovies()) {
      // Check if the movie ID matches
      if (movie.id == id) {
        return movie;
      }
    }

    // Return null if no matching movie is found
    return null;
  }
}

// Movie?	Returns a Movie or null
// String id	The unique ID we're searching for
// getMovies()	Gets the repository's list of movies
// for (final movie in getMovies())	Checks each movie in the list
// movie.id == id	Checks whether the IDs match
// return movie	Returns the matching Movie
// return null	No matching Movie was found
