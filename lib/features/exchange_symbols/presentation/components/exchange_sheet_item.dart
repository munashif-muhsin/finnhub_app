import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';
import '../../../../theme/decorations.dart';

class ExchangeSheetItem extends StatelessWidget {
  const ExchangeSheetItem({
    super.key,
    required this.exchange,
  });

  final String exchange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(bottom: 10),
      height: 50,
      decoration: AppDecorations.of(context).innerCard,
      child: Row(
        children: [
          Expanded(
            child: Text(
              exchange.toUpperCase(),
              style: TextTheme.of(context).bodyLarge,
            ),
          ),
          Icon(
            Icons.keyboard_arrow_right_outlined,
            color: AppColors.of(context).textSecondary,
          ),
        ],
      ),
    );
  }
}
