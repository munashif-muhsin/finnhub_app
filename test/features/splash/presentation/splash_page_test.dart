import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finnhub_app/features/splash/presentation/splash_page.dart';

void main() {
  testWidgets('SplashPage shows logo and loading indicator', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: SplashPage(),
      ),
    );

    // Verify FlutterLogo is present with correct size
    final flutterLogo = find.byType(FlutterLogo);
    expect(flutterLogo, findsOneWidget);
    final FlutterLogo logo = tester.widget(flutterLogo);
    expect(logo.size, 100);

    // Verify CircularProgressIndicator is present
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
