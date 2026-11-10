import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/user_settings.dart';

void main() {
  group('UserSettings model tests', () {
    // Test default settings
    test('creates settings with default values', () {
      const UserSettings settings = UserSettings();

      expect(settings.name, isEmpty);
      expect(settings.address, isEmpty);
      expect(settings.email, isEmpty);
      expect(settings.receiveNewsletter, isFalse);
    });

    // Test configured settings
    test('stores customer profile information', () {
      const UserSettings settings = UserSettings(
        name: 'Alex Smith',
        address: '10 Elm Road, Portsmouth',
        email: 'alex@example.com',
        receiveNewsletter: true,
      );

      expect(settings.name, 'Alex Smith');
      expect(settings.address, '10 Elm Road, Portsmouth');
      expect(settings.email, 'alex@example.com');
      expect(settings.receiveNewsletter, isTrue);
    });
  });
}

// What do these tests check?
// Test	Purpose
// Default values	Checks that text fields start empty and newsletter is off
// Configured values	Checks that the model stores supplied customer information
