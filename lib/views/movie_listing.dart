import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatelessWidget {
  const MovieListing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle, style: cinemaHeaderStyle),
        backgroundColor: cinemaSurface,
        iconTheme: const IconThemeData(color: cinemaBrand),
        elevation: 0,
      ),
      drawer: const NavDrawer(),

      // ADDED: Container to hold the movie listing content
      body: Container(

        // ADDED: Padding so the text is not touching the edge of the screen
        padding: const EdgeInsets.all(16),

        // ADDED: Column to arrange the content vertically
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            // ADDED: Movie title
            Text('The Dark Knight'),

            // ADDED: Space between the title and description
            SizedBox(height: 12),

            // ADDED: Short movie description
            Text(
              'Batman faces a dangerous criminal mastermind who throws Gotham City into chaos.',
            ),

            // added for ex2 : space befroe movie details
            SizedBox(height: 16),

            // added for ex2 : row to arrange movie detials horizontally
            Row(
              children: [
                // ADDED: Movie runtime
                Text('152 mins'),

                // ADDED: Space between runtime and age rating
                SizedBox(width: 20),

                // ADDED: Age rating
                Text('12A'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}