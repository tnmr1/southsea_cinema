
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

  // Constructor to initialise movie details
  const Movie({
    required this.id,
    required this.title,
    required this.synopsis,
    required this.ageRating,
    required this.screeningTime,
    required this.ticketPrice,
    required this.posterImagePath,
  });

  // Create a Movie from a JSON map
  factory Movie.fromJson(Map<String, dynamic> json) {
    final String id = json['id'] as String;
    final String title = json['title'] as String;
    final String synopsis = json['synopsis'] as String;
    final String ageRating = json['ageRating'] as String;
    final String screeningTime =
        json['screeningTime'] as String;

    final num priceNumber = json['ticketPrice'] as num;
    final double ticketPrice = priceNumber.toDouble();

    final String posterImagePath =
        json['posterImagePath'] as String;

    return Movie(
      id: id,
      title: title,
      synopsis: synopsis,
      ageRating: ageRating,
      screeningTime: screeningTime,
      ticketPrice: ticketPrice,
      posterImagePath: posterImagePath,
    );
  }

  // Convert a Movie into a JSON-compatible map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{
      'id': id,
      'title': title,
      'synopsis': synopsis,
      'ageRating': ageRating,
      'screeningTime': screeningTime,
      'ticketPrice': ticketPrice,
      'posterImagePath': posterImagePath,
    };

    return data;
  }

  // Format ticket price with £ and two decimal places
  String get formattedPrice =>
      '£${ticketPrice.toStringAsFixed(2)}';
}


// factory Movie.fromJson()	Creates a Movie from JSON data
// Map<String, dynamic>	Holds JSON fields and their values
// as String	Checks that a value is text
// as num	Accepts whole-number or decimal prices
// .toDouble()	Converts ticket prices to double
// toJson()	Converts the Movie back into a map

// Your existing constructor, properties and formattedPrice getter remain available.

