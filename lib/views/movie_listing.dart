
import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/models/movie.dart';

// StatefulWidget because ticket quantity can change
// Displays the selected movie's booking page
class MovieListing extends StatefulWidget {
  // Stores the selected movie
  final Movie movie;

  const MovieListing({
    super.key,
    required this.movie,
  });

  @override
  State<MovieListing> createState() => _MovieListingState();
}

// State class stores changing data
class _MovieListingState extends State<MovieListing> {
  // Current selected ticket quantity
  int _ticketQuantity = 1;

  // Feedback message shown after booking
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

      // Container holds the selected movie listing
      body: Container(
        color: cinemaBackground,

        // Column arranges widgets vertically
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Movie title and description
              Container(
                child: Column(
                  children: [
                    // Displays the selected movie title
                    Text(
                      widget.movie.title,
                      style: cinemaHeaderStyle,
                    ),

                    const SizedBox(height: 12),

                    // Displays the selected movie synopsis
                    Text(
                      widget.movie.synopsis,
                      style: const TextStyle(
                        color: cinemaFontMuted,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Displays the selected movie's screening details
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Screening time from the Movie model
                  Text(
                    widget.movie.screeningTime,
                    style: const TextStyle(
                      color: cinemaFontWhite,
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Age rating from the Movie model
                  Text(
                    widget.movie.ageRating,
                    style: const TextStyle(
                      color: cinemaBrand,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Ticket quantity dropdown
              DropdownMenu<int>(
                initialSelection: _ticketQuantity,

                onSelected: (int? value) {
                  // Checks the selected value is not null
                  if (value != null) {
                    setState(() {
                      _ticketQuantity = value;
                    });
                  }
                },

                // Ticket quantities from 1 to 5
                dropdownMenuEntries: const [
                  DropdownMenuEntry(value: 1, label: '1'),
                  DropdownMenuEntry(value: 2, label: '2'),
                  DropdownMenuEntry(value: 3, label: '3'),
                  DropdownMenuEntry(value: 4, label: '4'),
                  DropdownMenuEntry(value: 5, label: '5'),
                ],
              ),

              const SizedBox(height: 20),

              // LayoutBuilder checks available screen width
              LayoutBuilder(
                builder: (context, constraints) {
                  // Wide screen uses a Row
                  if (constraints.maxWidth > 600) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Displays selected ticket quantity
                        Text(
                          'Tickets selected: $_ticketQuantity',
                          style: const TextStyle(
                            color: cinemaFontWhite,
                          ),
                        ),

                        const SizedBox(width: 16),

                        // Adds selected tickets to the order
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _feedbackMessage =
                                  '$_ticketQuantity ticket(s) added to your order';
                            });
                          },
                          child: const Text('Add to order'),
                        ),

                        const SizedBox(width: 16),

                        // Displays booking feedback
                        Text(
                          _feedbackMessage,
                          style: const TextStyle(
                            color: cinemaBrand,
                          ),
                        ),
                      ],
                    );
                  } else {
                    // Narrow screen uses a Column
                    return Column(
                      children: [
                        // Displays selected ticket quantity
                        Text(
                          'Tickets selected: $_ticketQuantity',
                          style: const TextStyle(
                            color: cinemaFontWhite,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Adds selected tickets to the order
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _feedbackMessage =
                                  '$_ticketQuantity ticket(s) added to your order';
                            });
                          },
                          child: const Text('Add to order'),
                        ),

                        const SizedBox(height: 16),

                        // Displays booking feedback
                        Text(
                          _feedbackMessage,
                          style: const TextStyle(
                            color: cinemaBrand,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
