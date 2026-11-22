
import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/database/cinema_db.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/models/booking.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

// Displays the customer's selected cinema tickets.
class BasketView extends StatefulWidget {
  const BasketView({super.key});

  @override
  State<BasketView> createState() => _BasketViewState();
}

// State class manages changes to the basket.
class _BasketViewState extends State<BasketView> {
  // Access the shared basket repository.
  final BasketRepository _basket = BasketRepository.instance;

  // Access the shared SQLite cinema database.
  final CinemaDatabase _cinemaDb = CinemaDatabase.instance;

  // Prevent customers from checking out twice at once.
  bool _isCheckingOut = false;

  // Stores previous cinema bookings.
  List<Booking> _pastBookings = [];

  // Shows whether previous bookings are loading.
  bool _isLoadingBookings = true;

  // Runs when the basket page opens.
  @override
  void initState() {
    super.initState();

    // Load previous bookings from SQLite.
    _loadBookings();
  }

  // Reads previous bookings from SQLite.
  Future<void> _loadBookings() async {
    try {
      // Get all bookings, highest booking number first.
      final List<Booking> bookings = await _cinemaDb.getAllBookings();

      // Stop if the page has been closed.
      if (!mounted) {
        return;
      }

      // Update the saved bookings shown on the screen.
      setState(() {
        _pastBookings = bookings;
        _isLoadingBookings = false;
      });
    } catch (error) {
      // Stop if the page has been closed.
      if (!mounted) {
        return;
      }

      // Stop the loading message if reading fails.
      setState(() {
        _isLoadingBookings = false;
      });
    }
  }

  // Remove an item from the basket.
  void _removeItem(int index) {
    // Do not change the basket during checkout.
    if (_isCheckingOut) {
      return;
    }

    setState(() {
      _basket.removeItem(index);
    });
  }

  // Complete checkout and save the booking to SQLite.
  Future<void> _checkout() async {
    // Do not checkout if the basket is empty or already saving.
    if (_basket.getItems().isEmpty || _isCheckingOut) {
      return;
    }

    // Show that checkout is in progress.
    setState(() {
      _isCheckingOut = true;
    });

    try {
      // Get the next available booking number.
      final int bookingNumber = await _cinemaDb.nextBookingNumber();

      // Get the current basket contents.
      final List<BasketItem> items = _basket.getItems();

      // Create a description of the booked cinema tickets.
      final String summary = items.map((item) {
        return '${item.quantity} x ${item.movie.title}';
      }).join(', ');

      // Create a Booking object using the basket details.
      final Booking booking = Booking(
        bookingNumber: bookingNumber,
        summary: summary,
        total: _basket.getTotalDue(),
        date: DateTime.now().toString(),
      );

      // Save the booking permanently in SQLite.
      await _cinemaDb.insertBooking(booking);

      // Stop if the page has been closed.
      if (!mounted) {
        return;
      }

      // Clear the basket only after saving succeeds.
      setState(() {
        _basket.clear();
      });

      // Show the booking number in the confirmation.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Checkout completed! Booking number: $bookingNumber',
          ),
        ),
      );

      // Reload the booking history so the new booking appears.
      await _loadBookings();
    } catch (error) {
      // Stop if the page has been closed.
      if (!mounted) {
        return;
      }

      // Show an error message if checkout fails.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not save booking. Please try again.'),
        ),
      );
    } finally {
      // Allow checkout again after saving finishes.
      if (mounted) {
        setState(() {
          _isCheckingOut = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the current basket contents.
    final List<BasketItem> items = _basket.getItems();

    return Scaffold(
      // Uses the shared AppBarTheme.
      appBar: AppBar(
        title: const Text(appTitle),
      ),

      // Keep the existing navigation drawer.
      drawer: const NavDrawer(),

      // Allow the basket and booking history to scroll.
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Basket page heading.
            const Text(
              'My Basket',
              style: cinemaHeaderStyle,
            ),

            const SizedBox(height: 20),

            // Show a message when the basket is empty.
            if (items.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Your basket is empty',
                    style: TextStyle(
                      color: cinemaFontWhite,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),

            // Display each selected movie in the basket.
            for (int index = 0; index < items.length; index++)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Movie title.
                      Text(
                        items[index].movie.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Number of tickets.
                      Text(
                        'Tickets: ${items[index].quantity}',
                        style: const TextStyle(
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // ORIGINAL CODE: Commented out for Worksheet 8.
                      // Text(
                      //   '£${items[index].lineTotal.toStringAsFixed(2)}',
                      //   style: const TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.black87,
                      //   ),
                      // ),

                      // Worksheet 8: Display the temporary incorrect subtotal.
                      finalPriceText(items[index]),

                      const SizedBox(height: 12),

                      // Remove tickets from the basket.
                      PrimaryButton(
                        label: 'Remove',
                        onPressed: () {
                          _removeItem(index);
                        },
                      ),
                    ],
                  ),
                ),
              ),

            // Show totals and checkout only when tickets exist.
            if (items.isNotEmpty) ...[
              const SizedBox(height: 16),

              // Display total ticket quantity.
              Text(
                'Total tickets: ${_basket.getTotalItems()}',
                style: const TextStyle(
                  color: cinemaFontWhite,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 8),

              // Display total ticket price.
              Text(
                'Total: £${_basket.getTotalDue().toStringAsFixed(2)}',
                style: const TextStyle(
                  color: cinemaFontWhite,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // Save the booking when checkout is pressed.
              PrimaryButton(
                label: _isCheckingOut ? 'Saving...' : 'Checkout',
                onPressed: _checkout,
              ),
            ],

            const SizedBox(height: 30),

            // Heading for previous cinema bookings.
            const Text(
              'Past Bookings',
              style: cinemaHeaderStyle,
            ),

            const SizedBox(height: 16),

            // Show a loading message while reading SQLite.
            if (_isLoadingBookings)
              const Center(
                child: CircularProgressIndicator(),
              )
            // Show a message when no past bookings exist.
            else if (_pastBookings.isEmpty)
              const Text(
                'No past bookings yet',
                style: TextStyle(
                  color: cinemaFontWhite,
                  fontSize: 16,
                ),
              )
            else
              // Display each saved booking.
              for (final Booking booking in _pastBookings)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Display the booking number.
                        Text(
                          'Booking #${booking.bookingNumber}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Display the booked cinema tickets.
                        Text(
                          booking.summary,
                          style: const TextStyle(
                            color: Colors.black87,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Display the booking total.
                        Text(
                          'Total: £${booking.total.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Display the booking date.
                        Text(
                          'Date: ${booking.date}',
                          style: const TextStyle(
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  // Worksheet 8: Temporary method for the breakpoint exercise.
  Widget finalPriceText(BasketItem item) {
    // Correct subtotal for the selected movie tickets.
    final double correctTotal = item.lineTotal;

  // Worksheet 8: Fixed the incorrect £1 calculation.
// The displayed subtotal now matches the actual price.
final double displayedTotal = correctTotal;

    // Display the incorrect subtotal for debugging.
    return Text(
      '£${displayedTotal.toStringAsFixed(2)}',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}
