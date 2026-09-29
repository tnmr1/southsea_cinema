import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
// changed: StatefulWidget because ticket quanity can change
class MovieListing extends StatefulWidget {
  const MovieListing({super.key});
  @override
  State<MovieListing> createState() => _MovieListingState();
}
// added: state class stores chnging data
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
      // added: container to hold the movie listing content
      body: Container(
        // changed for ex5: use cinema background colour
        color: cinemaBackground,
        // added: padding so the text isnt touching the edge
        padding: const EdgeInsets.all(16),
        // added for ex6: LayoutBuilder checks avaliable screen width
        child: LayoutBuilder(
          builder: (context, constraints) {
            // added for exercise 6: wide screen layout
            if (constraints.maxWidth > 600) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // added for exercise 6: left side for movie info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // added: movie title
                        // changed for exercise 5: styled movie title
                        const Text(
                          'The Dark Knight',
                          style: TextStyle(
                            color: cinemaFontWhite,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // added: space between title and description
                        const SizedBox(height: 12),
                        // added: short movie description
                        // changed for exercise 5: styled description
                        const Text(
                          'Batman faces a dangerous criminal mastermind who throws Gotham City into chaos.',
                          style: TextStyle(
                            color: cinemaFontMuted,
                          ),
                        ),
                        // added for exercise 2: space before movie details
                        const SizedBox(height: 16),
                        // added for exercise 2: row arranges movie details horizontaly
                        // changed for exercise 5: styled movie details
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
                      ],
                    ),
                  ),
                  // added for exercise 6: space between sections
                  const SizedBox(width: 40),
                  // added for exercise 6: right side for booking controls
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // added for exercise 3: ticket quanity dropdown
                        DropdownMenu<int>(
                          initialSelection: 1,
                          // added: runs when a quanity is selected
                          onSelected: (int? value) {
                            // added: check a value was actually selected
                            if (value != null) {
                              // added: update state so Flutter rebuilds the screen
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
                        // added: space before selected quanity text
                        const SizedBox(height: 12),
                        // added: shows the current selected quanity
                        // changed for exercise 5: styled selected quanity text
                        Text(
                          'Tickets selected: $_ticketQuantity',
                          style: const TextStyle(
                            color: cinemaFontWhite,
                          ),
                        ),
                        // added for exercise 4: space before booking button
                        const SizedBox(height: 16),
                        // added for exercise 4: add selected tickets to order
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _feedbackMessage =
                                  '$_ticketQuantity ticket(s) added to your order';
                            });
                          },
                          child: const Text('Add to order'),
                        ),
                        // added for exercise 4: space before feedback
                        const SizedBox(height: 12),
                        // added for exercise 4: visual feedbak for the user
                        // changed for exercise 5: styled feedback mesage
                        Text(
                          _feedbackMessage,
                          style: const TextStyle(
                            color: cinemaBrand,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            // added for exercise 6: narrow/mobile screen layout
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // added: movie title
                // changed for exercise 5: styled movie title
                const Text(
                  'The Dark Knight',
                  style: TextStyle(
                    color: cinemaFontWhite,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // added: space between title and description
                const SizedBox(height: 12),
                // added: short movie description
                // changed for exercise 5: styled description
                const Text(
                  'Batman faces a dangerous criminal mastermind who throws Gotham City into chaos.',
                  style: TextStyle(
                    color: cinemaFontMuted,
                  ),
                ),
                // added for exercise 2: space before movie details
                const SizedBox(height: 16),
                // added for exercise 2: row arranges movie details horizontaly
                // changed for exercise 5: styled movie details
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
                // added for exercise 3: ticket quanity dropdown
                DropdownMenu<int>(
                  initialSelection: 1,
                  // added: runs when a quanity is selected
                  onSelected: (int? value) {
                    // added: check a value was actually selected
                    if (value != null) {
                      // added: update state so Flutter rebuilds the screen
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
                // added: space before selected quanity text
                const SizedBox(height: 12),
                // added: shows the current selected quanity
                // changed for exercise 5: styled selected quanity text
                Text(
                  'Tickets selected: $_ticketQuantity',
                  style: const TextStyle(
                    color: cinemaFontWhite,
                  ),
                ),
                // added for exercise 4: space before booking button
                const SizedBox(height: 16),
                // added for exercise 4: add selected tickets to order
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _feedbackMessage =
                          '$_ticketQuantity ticket(s) added to your order';
                    });
                  },
                  child: const Text('Add to order'),
                ),
                // added for exercise 4: space before feedback
                const SizedBox(height: 12),
                // added for exercise 4: visual feedbak for the user
                // changed for exercise 5: styled feedback mesage
                Text(
                  _feedbackMessage,
                  style: const TextStyle(
                    color: cinemaBrand,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}