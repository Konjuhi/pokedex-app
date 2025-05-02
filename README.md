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

The app follows a layered architecture for scalability and maintainability.

- **Core**  
  The `core/` directory provides shared logic, utilities, and foundational services that are used across multiple features. It's designed to be stable and independent of feature-specific code.

  ```
  lib/core/
  ├── api/             # Base API services, Dio client setup, interceptors
  ├── common_widgets/  # Reusable UI widgets (buttons, loaders, cards, etc.)
  ├── constants/       # App-wide constants like spacing, breakpoints, durations
  ├── database/        # Sembast local database setup and helper classes
  ├── exceptions/      # Global exception handling (e.g., AppException, Failure)
  ├── extensions/      # Dart/Flutter extensions (e.g., on BuildContext, AsyncValue)
  ├── localization/    # Localization support (if needed)
  ├── router/          # App-wide routing using GoRouter with guards and keys
  ├── settings/        # App settings and user preferences (e.g., theme settings)
  ├── theme/           # Tokens-based theming (light/dark mode, colors, text styles)
  └── core.dart        # Barrel file for exporting core dependencies
  ```

  ### Design Tokens
  The app uses a **tokens-based theming system** to support easy brand switching and maintain a clean separation of design concerns.

  #### Purpose
  Design tokens abstract color and typography into structured interfaces, enabling brand flexibility (e.g., `PokemonLightTokens`, `PokemonDarkTokens`).

  #### Using the Tokens System

  **Step 1: Wrap your App**
  ```dart
  TokensProvider(
    tokens: PokemonLightTokens(),
    child: MyApp(),
  )
  ```

  **Step 2: Access tokens in widgets**
  ```dart
  context.colors.primary;
  context.textStyles.bodyMedium;
  ```

  This system enables brand theming without manually passing colors or styles everywhere.

- **Features**  
  Feature-specific code organized by domain. Each feature contains its own layers (data, presentation) and logic.

  - **Auth**:
    - Handles user login, logout, and authentication state
    - Includes screens, controllers (e.g., `authController`), and local persistence for credentials

  - **Pokemon**:
    - Manages Pokémon-related features like search, display, saving, and deletion
    - Uses PokéAPI for fetching data
    - Implements custom widgets (e.g., `PokemonCard`) and business logic

## Video Record

The app supports splash screens and custom launcher icons using `flutter_native_splash` and `flutter_launcher_icons`. It includes:

- Light and dark splash screens
- Tinted icons for dark/light modes

```markdown
![Image](https://github.com/user-attachments/assets/baaec570-c459-4513-a38a-01488e3edc2f)
```




  
