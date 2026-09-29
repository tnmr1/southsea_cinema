import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

// CHANGED: StatefulWidget because ticket quantity can change
class MovieListing extends StatefulWidget {
  const MovieListing({super.key});

  @override
  State<MovieListing> createState() => _MovieListingState();
}

// ADDED: State class stores changing data
class _MovieListingState extends State<MovieListing> {
  // ADDED: Current selected ticket quantity
  int _ticketQuantity = 1;

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
        // ADDED: Padding so the text is not touching the edge
        padding: const EdgeInsets.all(16),

        // ADDED: Column arranges content vertically
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ADDED: Movie title
            const Text('The Dark Knight'),

            // ADDED: Space between title and description
            const SizedBox(height: 12),

            // ADDED: Short movie description
            const Text(
              'Batman faces a dangerous criminal mastermind who throws Gotham City into chaos.',
            ),

            // ADDED FOR EXERCISE 2: Space before movie details
            const SizedBox(height: 16),

            // ADDED FOR EXERCISE 2: Row arranges movie details horizontally
            const Row(
              children: [
                Text('152 mins'),
                SizedBox(width: 20),
                Text('12A'),
              ],
            ),

            // ADDED FOR EXERCISE 3: Space before dropdown
            const SizedBox(height: 20),

            // ADDED FOR EXERCISE 3: Ticket quantity dropdown
            DropdownMenu<int>(
              initialSelection: 1,

              // ADDED: Runs when a quantity is selected
              onSelected: (int? value) {
                // ADDED: Check that a value was actually selected
                if (value != null) {
                  // ADDED: Update state so Flutter rebuilds the screen
                  setState(() {
                    _ticketQuantity = value;
                  });
                }
              },

              // ADDED: Ticket quantities from 1 to 5
              dropdownMenuEntries: const [
                DropdownMenuEntry(value: 1, label: '1'),
                DropdownMenuEntry(value: 2, label: '2'),
                DropdownMenuEntry(value: 3, label: '3'),
                DropdownMenuEntry(value: 4, label: '4'),
                DropdownMenuEntry(value: 5, label: '5'),
              ],
            ),

            // ADDED: Space before selected quantity text
            const SizedBox(height: 12),

            // ADDED: Shows the current selected quantity
            Text('Tickets selected: $_ticketQuantity'),
          ],
        ),
      ),
    );
  }
}