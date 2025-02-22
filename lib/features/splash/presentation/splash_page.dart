import 'package:flutter/material.dart';

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
        ],
      ),
    );
  }
}
