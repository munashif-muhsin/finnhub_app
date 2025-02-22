import 'package:flutter/material.dart';

import 'colors.dart';

class AppDecorations {
  final Decoration card;
  final Decoration innerCard;

  AppDecorations._({required this.card, required this.innerCard});

  static AppDecorations of(BuildContext context) {
    return AppDecorations._(
      card: _card(context),
      innerCard: _innerCard(context),
    );
  }

  static Decoration _card(BuildContext context) {
    return BoxDecoration(
      color: AppColors.of(context).surface,
      border: Border.all(color: AppColors.of(context).surfaceLight),
      borderRadius: BorderRadius.circular(5),
    );
  }

  static Decoration _innerCard(BuildContext context) {
    return BoxDecoration(
      color: AppColors.of(context).surfaceLight,
      border: Border.all(color: AppColors.of(context).surfaceLight),
      borderRadius: BorderRadius.circular(5),
    );
  }
}
