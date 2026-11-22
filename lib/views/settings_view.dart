
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/main.dart';
import 'package:southsea_cinema/models/user_settings.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

// Customer profile settings screen
class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  // Controllers for customer information
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _emailController;

  // Newsletter preference
  bool _receiveNewsletter = false;

  // Worksheet 8: Read the current accessibility preference.
  bool _biggerText = biggerTextEnabled.value;

  // Confirmation message
  String _confirmationMessage = '';

  @override
  void initState() {
    super.initState();

    // Create controllers for the profile form.
    _nameController = TextEditingController();
    _addressController = TextEditingController();
    _emailController = TextEditingController();

    // Keep this screen in sync when the saved setting loads.
    biggerTextEnabled.addListener(_updateBiggerText);
  }

  // Update the switch when the global preference changes.
  void _updateBiggerText() {
    if (!mounted) return;

    setState(() {
      _biggerText = biggerTextEnabled.value;
    });
  }

  // Worksheet 8: Change and save the Bigger text preference.
  Future<void> _changeBiggerText(bool value) async {
    // Update the switch and all app screens immediately.
    setState(() {
      _biggerText = value;
    });

    biggerTextEnabled.value = value;

    // Store the user's choice on the device.
    final SharedPreferences prefs =
        await SharedPreferences.getInstance();

    await prefs.setBool('biggerText', value);
  }

  @override
  void dispose() {
    // Stop listening when the screen closes.
    biggerTextEnabled.removeListener(_updateBiggerText);

    // Release the text controllers.
    _nameController.dispose();
    _addressController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  // Save the customer's existing profile settings.
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

    // Display a confirmation message.
    setState(() {
      _confirmationMessage = 'Settings saved for ${settings.name}';
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

            // Customer email address.
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

              // Read the current preference.
              value: _biggerText,

              // Update the whole app and save the choice.
              onChanged: _changeBiggerText,
            ),

            const SizedBox(height: 20),

            // Save customer profile button.
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                label: 'Save Settings',
                onPressed: _saveSettings,
              ),
            ),

            // Show confirmation after saving.
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
