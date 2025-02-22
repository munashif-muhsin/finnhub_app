# Finnhub App

A Flutter application that utilizes the Finnhub API for financial market data.

## Setup

1. Clone the repository
2. Create a `.env` file in the root directory with the following content:
   ```
   API_KEY=<API Key here>
   BASE_URL=<Base URL here>
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run --dart-define=envFile=.env
   ```

## Environment Configuration

The app supports multiple environments through `.env` files. You can create different environment files (e.g., `.env.dev`, `.env.prod`) and specify which one to use when running the app:

```bash
flutter run --dart-define=envFile=.env.dev
```
