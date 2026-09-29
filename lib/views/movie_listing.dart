import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

// changed: StatefulWidget because ticket quanity can change
class MovieListing extends StatefulWidget {
  const MovieListing({super.key});

  @override
  State<MovieListing> createState() => _MovieListingState();
}

// added: state class stores changing data
class _MovieListingState extends State<MovieListing> {
  // added for exercise 3: current selected ticket quanity
  int _ticketQuantity = 1;

  // added for exercise 4: feedback mesage shown after booking
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

      // added for exercise 1: container holds movie listing
      body: Container(
        // changed for exercise 5: use cinema background colour
        color: cinemaBackground,

        // added for exercise 2: column arranges widgets verticaly
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // added for exercise 1: title and description container
              Container(
                child: Column(
                  children: [
                    // added for exercise 1: movie title
                    const Text(
                      'The Dark Knight',
                      style: cinemaHeaderStyle,
                    ),

                    const SizedBox(height: 12),

                    // added for exercise 1: short movie description
                    const Text(
                      'Batman faces a dangerous criminal mastermind who throws Gotham City into chaos.',
                      style: TextStyle(
                        color: cinemaFontMuted,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // added for exercise 2: row arranges movie details horizontaly
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '152 mins',
                    style: TextStyle(
                      color: cinemaFontWhite,
                    ),
                  ),

                  const SizedBox(width: 16),

                  Text(
                    '12A',
                    style: TextStyle(
                      color: cinemaBrand,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // added for exercise 3: ticket quanity dropdown
              DropdownMenu<int>(
                initialSelection: 1,

                // added: runs when a quanity is selected
                onSelected: (int? value) {
                  // added: checks value isnt null
                  if (value != null) {
                    // added: setState updates the screen
                    setState(() {
                      _ticketQuantity = value;
                    });
                  }
                },

                // added: ticket quantities from 1 to 5
                dropdownMenuEntries: const [
                  DropdownMenuEntry(value: 1, label: '1'),
                  DropdownMenuEntry(value: 2, label: '2'),
                  DropdownMenuEntry(value: 3, label: '3'),
                  DropdownMenuEntry(value: 4, label: '4'),
                  DropdownMenuEntry(value: 5, label: '5'),
                ],
              ),

              const SizedBox(height: 20),

              // added for exercise 6: checks avaliable screen width
              LayoutBuilder(
                builder: (context, constraints) {
                  // added for exercise 6: wide screen uses a row
                  if (constraints.maxWidth > 600) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // added: shows selected ticket quanity
                        Text(
                          'Tickets selected: $_ticketQuantity',
                          style: const TextStyle(
                            color: cinemaFontWhite,
                          ),
                        ),

                        const SizedBox(width: 16),

                        // added for exercise 4: add tickets to order button
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

                        // added for exercise 4: visual feedbak
                        Text(
                          _feedbackMessage,
                          style: const TextStyle(
                            color: cinemaBrand,
                          ),
                        ),
                      ],
                    );
                  } else {
                    // added for exercise 6: narrow screen uses a column
                    return Column(
                      children: [
                        // added: shows selected ticket quanity
                        Text(
                          'Tickets selected: $_ticketQuantity',
                          style: const TextStyle(
                            color: cinemaFontWhite,
                          ),
                        ),

                        const SizedBox(height: 16),

                        // added for exercise 4: add tickets to order button
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

                        // added for exercise 4: visual feedbak
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