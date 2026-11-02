import 'package:flutter/material.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/views/movie_listing.dart';

// Reusable widget for displaying one movie
class MovieCard extends StatelessWidget {
  // The movie this card will display
  final Movie movie;

  // Constructor requires a Movie object
  const MovieCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Displays movie poster and information side by side
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Loads the poster from assets/images
                Image.asset(
                  movie.posterImagePath,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),

                const SizedBox(width: 16),

                // Expanded allows text to wrap without overflowing
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Movie title
                      Text(
                        movie.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Movie age rating
                      Text(movie.ageRating),

                      // Movie description
                      Text(
                        movie.synopsis,
                        style: const TextStyle(
                          color: Colors.black54,
                        ),
                      ),

                      // Movie screening time
                      Text(movie.screeningTime),
                    ],
                  ),
                ),
              ],
            ),

            // Space between movie details and booking section
            const SizedBox(height: 16),

            // Displays ticket price and booking button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '£${movie.ticketPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Opens booking page for selected movie
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MovieListing(movie: movie);
                        },
                      ),
                    );
                  },
                  child: const Text('BOOK NOW'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// StatelessWidget	The card displays the movie passed to it
// final Movie movie	Stores the Movie object for this card
// required this.movie	A Movie must be supplied when creating the card
// build (BuildContext context)	Describes the widget's interface
// Card	Provides the card's Material surface
// Column	Arranges the card's contents vertically
// children: []	An empty list that we'll fill with movie details

// Card	Displays information inside a card
// Padding	Creates space inside the card
// Row	Arranges the poster and text horizontally
// Image.asset	Loads the movie poster
// BoxFit.cover	Fills the image area without distorting the image
// SizedBox(width: 16)	Adds a gap between the poster and text
// Expanded	Prevents text from overflowing horizontally
// Column	Places the movie details vertically
// movie.title	Gets the title from the Movie object
