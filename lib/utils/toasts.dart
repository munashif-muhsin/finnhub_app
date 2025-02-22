import 'package:finnhub_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toasts {
  /// Shows a toast message with optional background color
  ///
  /// [message] The message to display in the toast
  /// [backgroundColor] Optional background color for the toast
  static void show(String message, {Color? backgroundColor}) {
    Fluttertoast.showToast(msg: message, backgroundColor: backgroundColor);
  }

  /// Shows a failure toast message with red background
  ///
  /// [message] The error message to display
  static void failure(String message) => show(message, backgroundColor: AppColors.danger);
}
