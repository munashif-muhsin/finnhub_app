import 'package:flutter/material.dart';

import '../../../../theme/decorations.dart';
import '../../models/exchange_symbol_model.dart';

class ExchangeSymbolWidget extends StatelessWidget {
  const ExchangeSymbolWidget({
    super.key,
    required this.symbol,
    required this.tickWidget,
  });

  final ExchangeSymbol symbol;
  final Widget tickWidget;

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
          tickWidget,
        ],
      ),
    );
  }
}
