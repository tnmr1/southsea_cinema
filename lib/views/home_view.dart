import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/movie_repository.dart';
import 'package:southsea_cinema/widgets/movie_card.dart';

// Home page displaying all available movies
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

// State class manages asynchronous movie loading
class _HomeViewState extends State<HomeView> {
  // List of movies loaded from JSON
  List<Movie> _movies = [];

  // Tracks whether movies are still loading
  bool _loading = true;

  // Stores an error message if loading fails
  String _errorMessage = '';

  // Load movies when the screen first opens
  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  // Asynchronously load movies from the JSON asset
  Future<void> _loadMovies() async {
    try {
      // Create the movie repository
      final MovieRepository repository = MovieRepository();

      // Wait for the movies to load from JSON
      final List<Movie> movies = await repository.loadMoviesFromAsset();

      // Check that the widget is still active
      if (!mounted) {
        return;
      }

      // Update the screen with loaded movies
      setState(() {
        _movies = movies;
        _loading = false;
      });
    } catch (error) {
      // Check that the widget is still active
      if (!mounted) {
        return;
      }

      // Display an error if loading fails
      setState(() {
        _errorMessage = 'Could not load movies: $error';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Uses shared AppBarTheme from main.dart
      appBar: AppBar(
        title: const Text(appTitle),
      ),

      // Keep the existing navigation drawer
      drawer: const NavDrawer(),

      // Display loading, error or movie list
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _errorMessage.isNotEmpty
              ? Center(
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(
                      color: cinemaFontWhite,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: _movies.length,
                  itemBuilder: (context, index) {
                    // Create a card for each loaded movie
                    return MovieCard(
                      movie: _movies[index],
                    );
                  },
                ),
    );
  }
}

// the changes
// Component	What it does
// StatefulWidget	Allows the home page to update after loading
// _movies	Stores movies loaded from JSON
// _loading	Tracks whether loading is in progress
// _errorMessage	Stores an error if loading fails
// initState()	Starts loading when the screen opens
// Future<void>	Represents the asynchronous loading operation
// await	Waits for the JSON asset to load
// mounted	Checks that the widget still exists before updating
// setState()	Rebuilds the screen with loaded movies
// CircularProgressIndicator	Displays a loading indicator
// ListView.builder	Displays the loaded movie cards
