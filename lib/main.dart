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

/// This is for global navigation. It should be used sparingly
final navigatorKey = GlobalKey<NavigatorState>();

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

class FinnHubApp extends StatelessWidget {
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
