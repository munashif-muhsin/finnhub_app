import 'package:finnhub_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Toasts {
  static void show(String message, {Color? backgroundColor}) {
    Fluttertoast.showToast(msg: message, backgroundColor: backgroundColor);
  }

  static void failure(String message) => show(message, backgroundColor: AppColors.danger);
}
