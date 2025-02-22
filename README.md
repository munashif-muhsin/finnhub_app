# Finnhub App

A Flutter application that provides real-time financial market data using the Finnhub API. The app supports both Forex and Cryptocurrency market data visualization.

## Features

- Real-time market data streaming
- Support for Forex and Crypto markets
- Exchange symbol browsing
- Dynamic exchange selection
- Real-time price ticking

## Project Structure

```
lib/
├── features/
│   ├── common/          # Shared widgets and utilities
│   ├── exchange_symbols/ # Exchange and symbols feature
│   ├── home/            # Main navigation and home screen
│   └── tick/            # Real-time price ticking feature
├── theme/               # App theming and styling
└── utils/              # Utility functions and constants
```

## Setup

1. Clone the repository
2. Make a copy of `.sample.env` file as `.env` in the env/ directory and fill in your Finnhub API credentials:
   ```
   API_KEY=<your_finnhub_api_key>
   BASE_URL=https://finnhub.io/api/v1
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run --dart-define=envFile=.env
   ```

## Requirements

- Flutter 3.27.3

## Environment Configuration

The app supports multiple environments through `.env` files:

- `.env.dev` - Development environment
- `.env` - Production environment

To run with a specific environment:
```bash
flutter run --dart-define=envFile=.env.dev
```

## Testing

Run tests using:
```bash
flutter test
```

## Architecture

The app follows a clean architecture approach with:
- BLoC pattern for state management
- Repository pattern for data access
- Feature-first directory structure
- Clean separation of concerns

For detailed architecture and design decisions, see [Design Decisions](/docs/design-decisions.md).

## Dependencies

- flutter_bloc: State management
- dio: HTTP client
- bloc_test: Testing BLoC components
- flutter_dotenv: Environment configuration
