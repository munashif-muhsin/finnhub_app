import 'package:flutter/material.dart';

import 'package:finnhub_app/features/forex/models/forex_symbol_model.dart';

import '../../../../theme/decorations.dart';

class ForexSymbolWidget extends StatelessWidget {
  const ForexSymbolWidget({
    super.key,
    required this.symbol,
  });

  final ForexSymbol symbol;

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
                  symbol.displaySymbol,
                  style: TextTheme.of(context).headlineSmall,
                ),
                Text(
                  symbol.description,
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
