import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';
import '../../../../theme/decorations.dart';

class ExchangePicker extends StatelessWidget {
  const ExchangePicker({
    super.key,
    required this.selectedExchange,
  });

  final String selectedExchange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: AppDecorations.of(context).card,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Exchange",
                  style: TextTheme.of(context).labelMedium,
                ),
                Text(
                  selectedExchange.toUpperCase(),
                  style: TextTheme.of(context).bodyLarge,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Icon(
            Icons.expand_circle_down_outlined,
            color: AppColors.of(context).textSecondary,
          )
        ],
      ),
    );
  }
}
