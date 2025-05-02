# Pokédex App

A Flutter mobile application that allows users to search for Pokémon, view their details, and save them to a personal Pokédex.

## Features

- **Login Screen**: Simple login mechanism with local user storage
- **Search Screen**: 
  - Search Pokémon by name
  - "Surprise Me!" button to show 10 random Pokémon
  - Add Pokémon to your personal Pokédex
  - Results cached across app sessions
- **My Pokédex Screen**:
  - View all saved Pokémon
  - Remove Pokémon from the collection
  - Reorder Pokémon with drag-and-drop (persistent order)
- **Other Features**:
  - Logout functionality
  - Unit and widget tests

## Technical Implementation

- **State Management**: Flutter Riverpod for reactive and testable state management
- **Local Storage**: Sembast NoSQL database for local data persistence
- **API Integration**: PokéAPI integration for Pokémon data
- **Routing**: GoRouter for navigation
- **UI Components**: Material Design with custom widgets

## Getting Started

### Prerequisites

- Flutter SDK (version 3.7.0 or higher)
- Dart SDK (version 3.0.0 or higher)
- Android Studio / VS Code with Flutter plugins

### Installation

1. Clone this repository
2. Run `flutter pub get` to install dependencies
3. Generate code with `flutter pub run build_runner build --delete-conflicting-outputs`
4. Run the app with `flutter run`

### Default Login

- Username: `user`
- Password: `password`

## Tests

Run tests with:

```
flutter test
```

## Libraries Used

- Flutter Riverpod & Hooks Riverpod
- Sembast
- GoRouter
- Dio
- Freezed
- Cached Network Image
- Path Provider
- Flutter Hooks

## Architecture

The app follows a layered architecture:

- **Core**: Base components, utilities, and shared widgets
- **Features**: Feature-specific code organized by domain
  - **Auth**: Authentication related code
  - **Pokemon**: Pokemon-related features with data, domain, and presentation layers
