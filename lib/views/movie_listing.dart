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
  // ADDED FOR EXERCISE 3: Current selected ticket quantity
  int _ticketQuantity = 1;

  // ADDED FOR EXERCISE 4: Feedback message shown after booking
  String _feedbackMessage = '';

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
        // CHANGED FOR EXERCISE 5: Use cinema background colour
        color: cinemaBackground,

        // ADDED: Padding so the text is not touching the edge
        padding: const EdgeInsets.all(16),

        // ADDED: Column arranges content vertically
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ADDED: Movie title
            // CHANGED FOR EXERCISE 5: Styled movie title
            const Text(
              'The Dark Knight',
              style: TextStyle(
                color: cinemaFontWhite,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            // ADDED: Space between title and description
            const SizedBox(height: 12),

            // ADDED: Short movie description
            // CHANGED FOR EXERCISE 5: Styled description
            const Text(
              'Batman faces a dangerous criminal mastermind who throws Gotham City into chaos.',
              style: TextStyle(
                color: cinemaFontMuted,
              ),
            ),

            // ADDED FOR EXERCISE 2: Space before movie details
            const SizedBox(height: 16),

            // ADDED FOR EXERCISE 2: Row arranges movie details horizontally
            // CHANGED FOR EXERCISE 5: Styled movie details
            const Row(
              children: [
                Text(
                  '152 mins',
                  style: TextStyle(color: cinemaFontWhite),
                ),
                SizedBox(width: 20),
                Text(
                  '12A',
                  style: TextStyle(color: cinemaBrand),
                ),
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
            // CHANGED FOR EXERCISE 5: Styled selected quantity text
            Text(
              'Tickets selected: $_ticketQuantity',
              style: const TextStyle(
                color: cinemaFontWhite,
              ),
            ),

            // ADDED FOR EXERCISE 4: Space before booking button
            const SizedBox(height: 16),

            // ADDED FOR EXERCISE 4: Add selected tickets to order
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _feedbackMessage =
                      '$_ticketQuantity ticket(s) added to your order';
                });
              },
              child: const Text('Add to order'),
            ),

            // ADDED FOR EXERCISE 4: Space before feedback
            const SizedBox(height: 12),

            // ADDED FOR EXERCISE 4: Visual feedback for the user
            // CHANGED FOR EXERCISE 5: Styled feedback message
            Text(
              _feedbackMessage,
              style: const TextStyle(
                color: cinemaBrand,
              ),
            ),
          ],
        ),
      ),
    );
  }
}