# Southsea Cinema — Flutter Coursework

A mobile-friendly cinema booking application developed using **Flutter and Dart** for coursework at the **University of Portsmouth**.

This project supports the Programming Applications and Programming Languages (M30235) and User Experience Design and Implementation (M32605) modules.

## Project Overview

Southsea Cinema is a Flutter application that allows customers to browse movies, select cinema tickets, manage their basket and complete bookings.

The project was developed progressively through the weekly coursework worksheets. It demonstrates Flutter user interface design, Dart programming, navigation, local JSON data, SQLite persistence, accessibility features, automated testing and debugging.

Reference website: [Southsea Cinema](https://southseacinema.savoysystems.co.uk/SouthseaCinema.dll/)

## Features

### Movie Listings
- Display movies on the home screen.
- Load movie information asynchronously from a local JSON asset.
- Show movie details using reusable movie cards.
- Display loading indicators and error messages when appropriate.

### Ticket Basket
- Add movie tickets to the basket.
- Display selected movies and ticket quantities.
- Calculate individual ticket subtotals.
- Calculate the total ticket quantity and booking price.
- Remove tickets from the basket.
- Complete checkout.

### SQLite Booking History
- Save completed bookings in a local SQLite database.
- Generate booking numbers.
- Store booking summaries, prices and dates.
- Display previous bookings in the Basket screen.
- Clear the current basket after a successful checkout.

### Customer Settings
- Enter customer name, address and email.
- Enable or disable newsletter preferences.
- Display confirmation when customer settings are saved.

### Accessibility
- Provide a Bigger text switch.
- Increase app text size by 20% when enabled.
- Save the font-size preference using `shared_preferences`.
- Restore the preference when reopening the application.
- Preserve device accessibility text scaling.

### Navigation and Styling
- Use named routes to navigate between screens.
- Provide a shared navigation drawer.
- Use reusable buttons and widgets.
- Maintain a consistent cinema-themed interface.
- Support scrollable layouts.

## Technologies Used

| Technology | Purpose |
|---|---|
| Flutter | User interface development |
| Dart | Application programming |
| Material Design | Interface components and styling |
| JSON | Local movie data |
| SQLite / sqflite | Booking persistence |
| shared_preferences | Saving accessibility preferences |
| flutter_test | Automated widget testing |
| Git and GitHub | Version control |

## Getting Started

### Prerequisites

Before running the application, install:

- Flutter SDK
- Dart SDK
- Visual Studio Code with Flutter and Dart extensions
- Google Chrome
- Git

### Clone the Repository

```bash
git clone https://github.com/tnmr1/southsea_cinema.git
cd southsea_cinema
```

### Install Dependencies

Run:

```bash
flutter pub get
```

This installs the packages listed in `pubspec.yaml`.

### Run the Application

To run the project in Chrome:

```bash
flutter run -d chrome
```

The application will launch in a browser.

## How to Use the App

1. Open the Southsea Cinema application.
2. Browse the available movies on the Home screen.
3. Select a movie and add tickets to your basket.
4. Open **My Basket** to review your selected tickets.
5. Check the ticket quantities and calculated prices.
6. Select **Checkout** to complete a booking.
7. View your previous bookings under **Past Bookings**.
8. Open **Settings** to enter customer details or enable Bigger text.

## Testing

The application uses automated Flutter tests to check important functionality.

### Run All Tests

```bash
flutter test
```

### Run the Settings Tests

```bash
flutter test test/settings_view_test.dart
```

### Run the Basket Tests

```bash
flutter test test/basket_view_test.dart
```

### Run the Database Tests

```bash
flutter test test/database/cinema_db_test.dart
```

### Run Static Analysis

```bash
dart analyze
```

Static analysis checks the Dart project for potential programming problems and warnings.

### Testing Areas

Tests cover functionality including:

- Widget rendering
- Customer settings
- Newsletter preference
- Bigger text switch
- Basket functionality
- Booking checkout
- SQLite database operations
- Booking history

## Debugging

Flutter's debugging tools were used to investigate and correct problems during development.

### Breakpoints

A breakpoint was placed inside `basket_view.dart` to investigate a deliberately incorrect ticket subtotal.

The debugger was used to pause execution and inspect the calculated value.

For example:

- Correct subtotal: £15.00
- Deliberately incorrect subtotal: £16.00
- Cause: An additional £1 was added during the calculation.

The calculation was corrected after identifying the problem.

### Flutter Widget Inspector

Flutter DevTools and Widget Inspector were used to examine the interface's widget tree and investigate layouts.

Important widgets include:

- `Scaffold`
- `ListView`
- `Card`
- `Column`
- `Text`
- `SwitchListTile`

These tools help identify widget relationships and potential layout problems.

## Project Structure

```text
southsea_cinema/
├── lib/
│   ├── main.dart
│   ├── constants.dart
│   ├── database/
│   │   └── cinema_db.dart
│   ├── models/
│   │   ├── movie.dart
│   │   ├── basket_item.dart
│   │   ├── booking.dart
│   │   └── user_settings.dart
│   ├── repositories/
│   │   ├── movie_repository.dart
│   │   └── basket_repository.dart
│   ├── views/
│   │   ├── home_view.dart
│   │   ├── basket_view.dart
│   │   └── settings_view.dart
│   └── widgets/
│       ├── nav_drawer.dart
│       ├── movie_card.dart
│       └── primary_button.dart
├── test/
│   ├── widget_test.dart
│   ├── settings_view_test.dart
│   ├── basket_view_test.dart
│   └── database/
│       └── cinema_db_test.dart
├── pubspec.yaml
└── README.md
```

The project separates the user interface, models, repositories and database logic to improve organisation and maintainability.

## Coursework Development

The application has been developed through the weekly Flutter coursework worksheets.

| Worksheets | Main Development Areas |
|---|---|
| 1–2 | Flutter setup and fundamentals |
| 3–4 | Dart, widgets and interface development |
| 5–6 | Customer settings, navigation and testing |
| 7 | SQLite booking history and widget tests |
| 8 | Accessibility, debugging, testing and documentation |

## Assessment and Demonstrations

This project forms part of the University of Portsmouth coursework.

The original assessment uses five live demonstration opportunities, with the best four demo marks counting towards Item 1.

During demonstrations, students may be asked to:

- Run the application.
- Demonstrate implemented functionality.
- Explain important Flutter and Dart concepts.
- Discuss their own code.
- Demonstrate testing and debugging.

Refer to the official Moodle module materials and assessment guide for the full marking criteria, demo dates and submission requirements.

## Submission

The coursework is maintained in a public GitHub repository.

Repository: [Southsea Cinema on GitHub](https://github.com/tnmr1/southsea_cinema)

The repository contains the Flutter source code, automated tests and project documentation.

## Further Development

Possible future improvements include:

- Additional accessibility options.
- More detailed booking information.
- Improved test coverage.
- Enhanced booking management.
- Further database relationships.

## Author

University of Portsmouth Flutter coursework project.

Developed using Flutter, Dart and GitHub.