import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/forex/bloc/forex_bloc.dart';
import '../../features/home/presentation/home_page.dart';
import '../../features/splash/presentation/splash_page.dart';
import 'routes.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  try {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (context) => const SplashPage());

      case Routes.home:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => ForexBloc(),
            child: const HomePage(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const ErrorPage(error: ''),
        );
    }
  } catch (e, stackTrace) {
    final error = 'User routed to an invalid url with ${settings.toString()}';
    log(error, stackTrace: stackTrace);

    return MaterialPageRoute(
      builder: (context) => ErrorPage(error: e.toString()),
    );
  }
}

class ErrorPage extends StatelessWidget {
  final String error;

  const ErrorPage({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Page not found'),
            Text(error),
            const SizedBox(height: 32),
            MaterialButton(
              child: const Text('Go back home'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ));
  }
}
