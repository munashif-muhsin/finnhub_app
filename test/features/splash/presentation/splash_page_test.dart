import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finnhub_app/features/splash/presentation/splash_page.dart';
import 'package:finnhub_app/utils/router/routes.dart';

void main() {
  group('SplashPage', () {
    testWidgets('shows logo and loading indicator', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: SplashPage(),
        ),
      );

      // Verify logo
      final flutterLogo = find.byType(FlutterLogo);
      expect(flutterLogo, findsOneWidget);
      final logo = tester.widget<FlutterLogo>(flutterLogo);
      expect(logo.size, 100);

      // Verify loading indicator
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('navigates to home screen when button is pressed', (tester) async {
      // Track navigation
      final navigatorKey = GlobalKey<NavigatorState>();
      String? pushedRoute;

      await tester.pumpWidget(
        MaterialApp(
          navigatorKey: navigatorKey,
          onGenerateRoute: (settings) {
            pushedRoute = settings.name;
            return MaterialPageRoute(
              builder: (context) => const Scaffold(),
            );
          },
          home: const SplashPage(),
        ),
      );

      // Verify button exists
      final button = find.widgetWithText(MaterialButton, 'Start now');
      expect(button, findsOneWidget);

      // Tap the button
      await tester.tap(button);
      await tester.pumpAndSettle();

      // Verify navigation occurred
      expect(pushedRoute, equals(Routes.home));
    });
  });
}
