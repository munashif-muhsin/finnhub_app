import 'package:flutter/material.dart';

import '../../../../theme/decorations.dart';

class ForexSymbol extends StatelessWidget {
  const ForexSymbol({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: AppDecorations.of(context).card,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "EUR/USD",
                  style: TextTheme.of(context).headlineSmall,
                ),
                Text(
                  "IC MARKETS Euro vs US Dollar EURUSD",
                  style: TextTheme.of(context).labelMedium,
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Row(
            children: [
              Icon(Icons.keyboard_arrow_up),
              const SizedBox(width: 2),
              Text(
                "123.45",
                style: TextTheme.of(context).headlineMedium,
              ),
            ],
          )
        ],
      ),
    );
  }
}
