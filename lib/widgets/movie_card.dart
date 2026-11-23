
import 'package:flutter/material.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/views/movie_listing.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

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
    // Theme-aware colours for light and dark modes
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

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
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Movie age rating
                      Text(
                        movie.ageRating,
                        style: TextStyle(
                          color: colorScheme.onSurface,
                        ),
                      ),

                      // Movie description
                      Text(
                        movie.synopsis,
                        style: TextStyle(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),

                      // Movie screening time
                      Text(
                        movie.screeningTime,
                        style: TextStyle(
                          color: colorScheme.onSurface,
                        ),
                      ),
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
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),

                // Opens booking page for selected movie
                PrimaryButton(
                  label: 'BOOK NOW',
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Component summary:
// StatelessWidget - Displays the movie passed to it
// final Movie movie - Stores the movie data
// required this.movie - Requires a movie when creating the card
// Card - Displays movie information
// Padding - Adds spacing inside the card
// Row - Arranges the poster and text horizontally
// Column - Arranges movie details vertically
// Image.asset - Loads the movie poster
// Expanded - Prevents text overflow
// ColorScheme - Provides theme-aware text colours
// onSurface - Readable text on the card surface
// onSurfaceVariant - Softer colour for the movie description
// PrimaryButton - Opens the booking page
