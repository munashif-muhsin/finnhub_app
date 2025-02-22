import 'package:flutter/material.dart';

/// A widget that displays an error message with a retry button
///
/// This widget is commonly used throughout the app to show error states
/// and provide users with the ability to retry failed operations
class ErrorRetryWidget extends StatelessWidget {
  /// Creates an error retry widget
  ///
  /// The [onRetry] callback is required and is called when the retry button is pressed.
  /// An optional [message] can be provided to customize the error message.
  const ErrorRetryWidget({
    super.key,
    required this.onRetry,
    this.message,
  });

  /// Callback function that is executed when the retry button is pressed
  final VoidCallback onRetry;

  /// Custom error message to display
  /// If null, a default error message will be shown
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          message ?? "An error occurred. Please try again.",
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: onRetry,
          child: const Text("Retry"),
        ),
      ],
    );
  }
}
