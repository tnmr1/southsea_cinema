import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: cinemaBackground,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              color: cinemaSurface,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      appTitle,
                      style: cinemaHeaderStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: cinemaBrand),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),

            // Home navigation link
            const DrawerTile(
              title: 'Home',
              route: '/',
            ),

            // Navigate to the basket screen
            const DrawerTile(
              title: 'My Basket',
              route: '/basket',
            ),

            // Navigate to the settings screen
            const DrawerTile(
              title: 'My Settings',
              route: '/settings',
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable navigation tile
class DrawerTile extends StatelessWidget {
  final String title;
  final String? route;

  const DrawerTile({
    super.key,
    required this.title,
    this.route,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(color: cinemaFontWhite),
      ),
      onTap: () {
        // Close the navigation drawer
        Navigator.pop(context);

        // Navigate to the selected route
        if (route != null) {
          Navigator.pushNamed(context, route!);
        }
      },
    );
  }
}

// How navigation works
// Drawer option	Route	Destination
// Home	/	Cinema home page
// My Basket	/basket	Basket page
// My Settings	/settings	Settings page
