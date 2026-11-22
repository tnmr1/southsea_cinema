
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

// Worksheet 8: Stores the selected light/dark theme.
// The cinema starts in dark mode until a saved preference is loaded.
final ValueNotifier<ThemeMode> cinemaThemeMode =
    ValueNotifier<ThemeMode>(ThemeMode.dark);

// Increase text size while preserving the device's
// existing accessibility text scaling.
class CinemaTextScaler extends TextScaler {
  const CinemaTextScaler(this.deviceScaler, this.multiplier);

  final TextScaler deviceScaler;
  final double multiplier;

  @override
  double scale(double fontSize) {
    // Apply device scaling first, then our extra scaling.
    return deviceScaler.scale(fontSize) * multiplier;
  }

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

    // Load saved accessibility and theme preferences.
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    // Keep the existing Bigger text preference.
    final SharedPreferences prefs =
        await SharedPreferences.getInstance();

    biggerTextEnabled.value =
        prefs.getBool('biggerText') ?? false;

    // Worksheet 8: Use SharedPreferencesAsync for theme mode.
    final SharedPreferencesAsync asyncPrefs =
        SharedPreferencesAsync();

    final bool savedDarkMode =
        await asyncPrefs.getBool('darkMode') ?? true;

    // Restore the user's saved light/dark mode.
    cinemaThemeMode.value =
        savedDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    // Rebuild when the theme preference changes.
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: cinemaThemeMode,
      builder: (context, selectedThemeMode, child) {
        // Rebuild when the Bigger text preference changes.
        return ValueListenableBuilder<bool>(
          valueListenable: biggerTextEnabled,
          builder: (context, isBiggerText, child) {
            return MaterialApp(
              title: appTitle,
              debugShowCheckedModeBanner: false,

              // Worksheet 8: Switch between light and dark mode.
              themeMode: selectedThemeMode,

              // New light theme.
              theme: ThemeData.light().copyWith(
                scaffoldBackgroundColor: const Color(0xFFF5F5F5),

                colorScheme: ColorScheme.fromSeed(
                  seedColor: cinemaBrand,
                  brightness: Brightness.light,
                ),

                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black87,
                  iconTheme: IconThemeData(
                    color: Colors.black87,
                  ),
                  elevation: 0,
                ),
              ),

              // Keep the existing dark cinema theme.
              darkTheme: ThemeData.dark().copyWith(
                scaffoldBackgroundColor: cinemaBackground,

                colorScheme: ColorScheme.fromSeed(
                  seedColor: cinemaBrand,
                  brightness: Brightness.dark,
                  primary: cinemaBrand,
                  surface: cinemaSurface,
                ),

                appBarTheme: const AppBarTheme(
                  backgroundColor: cinemaSurface,
                  iconTheme: IconThemeData(
                    color: cinemaBrand,
                  ),
                  titleTextStyle: cinemaHeaderStyle,
                  elevation: 0,
                ),
              ),

              // Worksheet 8: Apply text scaling across the app.
              builder: (context, child) {
                final MediaQueryData mediaQuery =
                    MediaQuery.of(context);

                // Increase text size by 20% when enabled.
                final double multiplier =
                    isBiggerText ? 1.2 : 1.0;

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

              // Preserve all existing navigation routes.
              initialRoute: '/',
              routes: {
                '/': (context) => const HomeView(),
                '/basket': (context) => const BasketView(),
                '/settings': (context) => const SettingsView(),
              },
            );
          },
        );
      },
    );
  }
}
