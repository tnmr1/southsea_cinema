import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
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

  // Confirmation message
  String _confirmationMessage = '';

  // Initialise the text controllers
  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _addressController = TextEditingController();
    _emailController = TextEditingController();
  }

  // Dispose of controllers when the screen closes
  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  // Save the customer's profile settings
  void _saveSettings() {
    final String name = _nameController.text.trim();
    final String address = _addressController.text.trim();
    final String email = _emailController.text.trim();

    // Create the UserSettings model
    final UserSettings settings = UserSettings(
      name: name,
      address: address,
      email: email,
      receiveNewsletter: _receiveNewsletter,
    );

    // Display confirmation
    setState(() {
      _confirmationMessage = 'Settings saved for ${settings.name}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Shared cinema app bar
      appBar: AppBar(
        title: const Text(appTitle),
      ),

      // Keep navigation drawer
      drawer: const NavDrawer(),

      // Scrollable customer profile form
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Form heading
            const Text(
              'Customer Profile',
              style: cinemaHeaderStyle,
            ),

            const SizedBox(height: 20),

            // Customer full name
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Full name',
                hintText: 'Enter your name',
              ),
            ),

            const SizedBox(height: 16),

            // Customer address
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

            // Customer email address
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

            // Newsletter preference
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

            const SizedBox(height: 20),

            // Save settings button
            SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                label: 'Save Settings',
                onPressed: _saveSettings,
              ),
            ),

            // Display confirmation after saving
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

// StatefulWidget	Allows form values to change
// TextEditingController	Reads the text entered by the customer
// initState()	Creates the controllers
// dispose()	Releases the controllers
// TextField	Displays editable input fields
// Switch	Controls the newsletter preference
// SingleChildScrollView	Prevents overflow when the keyboard appears
// UserSettings	Holds the customer profile values
// _saveSettings()	Reads the form and displays confirmation

// Why do we use initState() and dispose()?
// Flutter text controllers need to be managed throughout the widget's lifecycle.
// - initState() creates the controllers when the settings screen first opens.
// - dispose() releases them when the screen is removed.
// This is exactly the controller lifecycle described in your Worksheet 5.
