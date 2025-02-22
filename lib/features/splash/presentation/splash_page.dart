import 'package:flutter/material.dart';

import '../../../utils/router/routes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlutterLogo(size: 100),
          const SizedBox(height: 50),
          CircularProgressIndicator.adaptive(),
          const SizedBox(height: 50),
          // Test code to navigate to home screen
          MaterialButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(Routes.home);
            },
            child: Text('Start now'),
          ),
        ],
      ),
    );
  }
}
