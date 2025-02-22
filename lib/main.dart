import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'theme/app_theme.dart';
import 'utils/api_url.dart';
import 'utils/router/router.dart';
import 'utils/router/routes.dart';

/// This is used to setup the API urls based on the endpoint
late ApiUrls apiUrls;

/// Global navigation key that provides access to NavigatorState
/// This enables navigation from anywhere in the app without context
final navigatorKey = GlobalKey<NavigatorState>();

/// Entry point of the application
/// Initializes environment variables, error handling, and runs the app
void main() async {
  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Get sensitive keys from .env file
      // (Alternative) We can also use Flavors & --dart-define combination instead of .env
      const envFile = String.fromEnvironment(
        'envFile',
        defaultValue: '.env',
      );
      await dotenv.load(fileName: "env/$envFile");

      // Set up API Urls
      apiUrls = ApiUrls.fromEnv(dotenv);

      /// Widget to show whenever a UI exception has occurred
      ErrorWidget.builder = (FlutterErrorDetails details) {
        return const Material(
          child: Center(
            child: Text(
              "Oops! There was an error",
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      };

      runApp(const FinnHubApp());
    },
    (error, StackTrace stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
    },
  );
}

/// Root widget of the FinnHub application
///
/// Sets up the MaterialApp with theme, routing, and initial configuration
class FinnHubApp extends StatelessWidget {
  /// Creates the root application widget
  const FinnHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Finnhub',
      onGenerateRoute: generateRoute,
      initialRoute: Routes.splash,
      theme: AppTheme.currentTheme(context),
    );
  }
}
