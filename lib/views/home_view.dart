
import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';

// Home page displaying all available movies
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // Create the movie repository
    final MovieRepository repository = MovieRepository();

    // Get the list of movies from the repository
    final List<Movie> movies = repository.getMovies();

    return Scaffold(
      // Uses the shared AppBarTheme from main.dart
      appBar: AppBar(
        title: const Text(appTitle),
      ),

      // Keep the existing navigation drawer
      drawer: const NavDrawer(),

      // Display movies in a scrollable list
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          // Create a card for each movie
          return MovieCard(
            movie: movies[index],
          );
        },
      ),
    );
  }
  
}
