
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/views/home_view.dart';
import 'package:southsea_cinema/views/basket_view.dart';
import 'package:southsea_cinema/views/settings_view.dart';

void main() {
  runApp(const SouthseaCinemaApp());
}

// Worksheet 8: Stores the Bigger text preference.
// ValueNotifier updates the app when this value changes.
final ValueNotifier<bool> biggerTextEnabled = ValueNotifier<bool>(false);

// Increase text size while preserving the device's
// existing accessibility text scaling.
class CinemaTextScaler extends TextScaler {
  const CinemaTextScaler(this.deviceScaler, this.multiplier);

  final TextScaler deviceScaler;
  final double multiplier;

  @override
  double scale(double fontSize) {
    // Apply the device's scaling first, then our extra scaling.
    return deviceScaler.scale(fontSize) * multiplier;
  }

  // Work out the font size that produces this scaled value.
  @override
  double get textScaleFactor {
    return scale(1.0);
  }
}

class SouthseaCinemaApp extends StatefulWidget {
  const SouthseaCinemaApp({super.key});

  @override
  State<SouthseaCinemaApp> createState() => _SouthseaCinemaAppState();
}

class _SouthseaCinemaAppState extends State<SouthseaCinemaApp> {
  @override
  void initState() {
    super.initState();

    // Load the saved font-size preference when the app starts.
    _loadBiggerTextPreference();
  }

  Future<void> _loadBiggerTextPreference() async {
    final SharedPreferences prefs =
        await SharedPreferences.getInstance();

    // False means normal text size for new users.
    biggerTextEnabled.value =
        prefs.getBool('biggerText') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    // Rebuild MaterialApp when Bigger text changes.
    return ValueListenableBuilder<bool>(
      valueListenable: biggerTextEnabled,
      builder: (context, isBiggerText, child) {
        return MaterialApp(
          title: appTitle,
          debugShowCheckedModeBanner: false,

          // Keep the existing Southsea Cinema theme.
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: cinemaBackground,
            colorScheme: ColorScheme.fromSeed(
              seedColor: cinemaBrand,
              primary: cinemaBrand,
              surface: cinemaSurface,
            ),

            // Shared app bar theme.
            appBarTheme: const AppBarTheme(
              backgroundColor: cinemaSurface,
              iconTheme: IconThemeData(color: cinemaBrand),
              titleTextStyle: cinemaHeaderStyle,
              elevation: 0,
            ),
          ),

          // Worksheet 8: Apply text scaling across the app.
          builder: (context, child) {
            final MediaQueryData mediaQuery = MediaQuery.of(context);

            // Increase text size by 20% when enabled.
            final double multiplier = isBiggerText ? 1.2 : 1.0;

            return MediaQuery(
              data: mediaQuery.copyWith(
                textScaler: CinemaTextScaler(
                  mediaQuery.textScaler,
                  multiplier,
                ),
              ),
              child: child ?? const SizedBox.shrink(),
            );
          },

          // Keep all existing navigation routes.
          initialRoute: '/',
          routes: {
            '/': (context) => const HomeView(),
            '/basket': (context) => const BasketView(),
            '/settings': (context) => const SettingsView(),
          },
        );
      },
    );
  }
}
