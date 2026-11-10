import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/basket_item.dart';
import 'package:southsea_cinema/repositories/basket_repository.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

// Displays the customer's selected cinema tickets
class BasketView extends StatefulWidget {
  const BasketView({super.key});

  @override
  State<BasketView> createState() => _BasketViewState();
}

// State class manages changes to the basket
class _BasketViewState extends State<BasketView> {
  // Access the shared basket repository
  final BasketRepository _basket = BasketRepository.instance;

  // Remove an item from the basket
  void _removeItem(int index) {
    setState(() {
      _basket.removeItem(index);
    });
  }

  // Complete temporary checkout
  void _checkout() {
    // Clear all tickets from the basket
    setState(() {
      _basket.clear();
    });

    // Display checkout confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Checkout completed successfully'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the current basket contents
    final List<BasketItem> items = _basket.getItems();

    return Scaffold(
      // Uses the shared AppBarTheme
      appBar: AppBar(
        title: const Text(appTitle),
      ),

      // Keep the existing navigation drawer
      drawer: const NavDrawer(),

      // Display empty message or basket contents
      body: items.isEmpty
          ? const Center(
              child: Text(
                'Your basket is empty',
                style: TextStyle(
                  color: cinemaFontWhite,
                  fontSize: 20,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Basket page heading
                  const Text(
                    'My Basket',
                    style: cinemaHeaderStyle,
                  ),

                  const SizedBox(height: 20),

                  // Display each selected movie
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final BasketItem item = items[index];

                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Movie title
                                Text(
                                  item.movie.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                // Number of tickets
                                Text(
                                  'Tickets: ${item.quantity}',
                                  style: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                // Total price for this movie
                                Text(
                                  '£${item.lineTotal.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),

                                const SizedBox(height: 12),

                                // Remove tickets from the basket
                                PrimaryButton(
                                  label: 'Remove',
                                  onPressed: () {
                                    _removeItem(index);
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Display total ticket quantity
                  Text(
                    'Total tickets: ${_basket.getTotalItems()}',
                    style: const TextStyle(
                      color: cinemaFontWhite,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Display total ticket price
                  Text(
                    'Total: £${_basket.getTotalDue().toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: cinemaFontWhite,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Complete temporary checkout
                  PrimaryButton(
                    label: 'Checkout',
                    onPressed: _checkout,
                  ),
                ],
              ),
            ),
    );
  }
}

// StatelessWidget	Changed to StatefulWidget
// BasketRepository.instance	Connects to your shared basket
// ListView.builder	Displays selected tickets
// BasketItem.lineTotal	Shows the price per basket entry
// _removeItem()	Removes tickets and updates the screen
// getTotalItems()	Displays the total number of tickets
// getTotalDue()	Calculates the total cost
// _checkout()	Clears the basket
// SnackBar	Displays checkout confirmation
