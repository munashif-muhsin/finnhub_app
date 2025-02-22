import 'package:flutter/material.dart';

import 'colors.dart';

class AppDecorations {
  final Decoration card;

  AppDecorations._({required this.card});

  static AppDecorations of(BuildContext context) {
    return AppDecorations._(card: _card(context));
  }

  static Decoration _card(BuildContext context) {
    return BoxDecoration(
      color: AppColors.of(context).surface,
      border: Border.all(color: AppColors.of(context).surfaceLight),
      borderRadius: BorderRadius.circular(5),
    );
  }
}
