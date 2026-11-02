// Model class to store information about a movie
class Movie {
  // Unique ID used to identify each movie
  final String id;

  // Movie details displayed in the app
  final String title;
  final String synopsis;
  final String ageRating;
  final String screeningTime;

  // Price of one ticket
  final double ticketPrice;

  // Path to the movie's poster image
  final String posterImagePath;

  // Constructor to initialise all movie details
  const Movie({
    required this.id,
    required this.title,
    required this.synopsis,
    required this.ageRating,
    required this.screeningTime,
    required this.ticketPrice,
    required this.posterImagePath,
  });

  // Returns the ticket price with £ and two decimal places
  String get formattedPrice => '£${ticketPrice.toStringAsFixed(2)}';
}

// Movie() is the constructor used to create a Movie object.
// required means every value must be provided when creating a movie.
// this.id assigns the supplied ID to the object's id field.
// const allows Movie objects to be created as constants when their values are constant.
