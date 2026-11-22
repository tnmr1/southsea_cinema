
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/models/user_settings.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

// Customer profile settings screen.
class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  // Controllers for customer information.
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _emailController;

  // Existing newsletter preference.
  bool _receiveNewsletter = false;

  // Worksheet 8: Current accessibility preference.
  bool _biggerText = biggerTextEnabled.value;

  // Worksheet 8: Current dark mode preference.
  bool _darkMode = cinemaThemeMode.value == ThemeMode.dark;

  // Confirmation message.
  String _confirmationMessage = '';

  @override
  void initState() {
    super.initState();

    // Create controllers for the customer profile.
    _nameController = TextEditingController();
    _addressController = TextEditingController();
    _emailController = TextEditingController();

    // Keep the switches in sync with global preferences.
    biggerTextEnabled.addListener(_updateBiggerText);
    cinemaThemeMode.addListener(_updateDarkMode);
  }

  // Update the Bigger text switch when its value changes.
  void _updateBiggerText() {
    if (!mounted) return;

    setState(() {
      _biggerText = biggerTextEnabled.value;
    });
  }

  // Update the Dark mode switch when its value changes.
  void _updateDarkMode() {
    if (!mounted) return;

    setState(() {
      _darkMode = cinemaThemeMode.value == ThemeMode.dark;
    });
  }

  // Worksheet 8: Change and save Bigger text.
  Future<void> _changeBiggerText(bool value) async {
    // Update the switch and the whole application.
    setState(() {
      _biggerText = value;
    });

    biggerTextEnabled.value = value;

    // Save the preference on the device.
    final SharedPreferences prefs =
        await SharedPreferences.getInstance();

    await prefs.setBool('biggerText', value);
  }

  // Worksheet 8: Change and save Light/Dark mode.
  Future<void> _changeDarkMode(bool value) async {
    // Update the current switch.
    setState(() {
      _darkMode = value;
    });

    // Rebuild MaterialApp with the selected theme.
    cinemaThemeMode.value =
        value ? ThemeMode.dark : ThemeMode.light;

    // Save the preference using SharedPreferencesAsync.
    final SharedPreferencesAsync prefs =
        SharedPreferencesAsync();

    await prefs.setBool('darkMode', value);
  }

  @override
  void dispose() {
    // Stop listening when leaving this screen.
    biggerTextEnabled.removeListener(_updateBiggerText);
    cinemaThemeMode.removeListener(_updateDarkMode);

    // Release text field controllers.
    _nameController.dispose();
    _addressController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  // Save existing customer profile settings.
  void _saveSettings() {
    final String name = _nameController.text.trim();
    final String address = _addressController.text.trim();
    final String email = _emailController.text.trim();

    // Create the customer settings model.
    final UserSettings settings = UserSettings(
      name: name,
      address: address,
      email: email,
      receiveNewsletter: _receiveNewsletter,
    );

    // Display confirmation after saving.
    setState(() {
      _confirmationMessage =
          'Settings saved for ${settings.name}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Shared cinema app bar.
      appBar: AppBar(
        title: const Text(appTitle),
      ),

      // Keep the existing navigation drawer.
      drawer: const NavDrawer(),

      // Scrollable customer settings screen.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Customer profile heading.
            const Text(
              'Customer Profile',
              style: cinemaHeaderStyle,
            ),

            const SizedBox(height: 20),

            // Customer full name.
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Full name',
                hintText: 'Enter your name',
              ),
            ),

            const SizedBox(height: 16),

            // Customer address.
            TextField(
              controller: _addressController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Delivery address',
                hintText: 'Enter your address',
              ),
            ),

            const SizedBox(height: 16),

            // Customer email.
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email address',
                hintText: 'Enter your email',
              ),
            ),

            const SizedBox(height: 16),

            // Existing newsletter preference.
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Receive newsletter and offers',
                  ),
                ),
                Switch(
                  value: _receiveNewsletter,
                  onChanged: (bool value) {
                    setState(() {
                      _receiveNewsletter = value;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Worksheet 8: Accessibility setting.
            SwitchListTile(
              title: const Text('Bigger text'),
              subtitle: const Text(
                'Increase text size for easier reading',
              ),
              value: _biggerText,
              onChanged: _changeBiggerText,
            ),

            const SizedBox(height: 8),

            // Worksheet 8: Light/Dark mode setting.
            SwitchListTile(
              title: const Text('Dark mode'),
              subtitle: const Text(
                'Use the dark Southsea Cinema theme',
              ),
              secondary: const Icon(Icons.dark_mode),
              value: _darkMode,
              onChanged: _changeDarkMode,
            ),

            const SizedBox(height: 20),

            // Existing save customer profile button.
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                label: 'Save Settings',
                onPressed: _saveSettings,
              ),
            ),

            // Display confirmation after saving.
            if (_confirmationMessage.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                _confirmationMessage,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: cinemaBrand,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
