import 'package:flutter/material.dart';

import 'exchange_sheet_item.dart';

class ExchangePickerSheet extends StatelessWidget {
  const ExchangePickerSheet({
    super.key,
    required this.exchanges,
    required this.onExchangeSelected,
    required this.scrollController,
  });

  final List<String> exchanges;
  final void Function(String)? onExchangeSelected;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select exchange",
            style: TextTheme.of(context).headlineMedium,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: exchanges.length,
              itemBuilder: (context, index) {
                final exchange = exchanges[index];

                return GestureDetector(
                  onTap: () {
                    onExchangeSelected?.call(exchange);
                    Navigator.of(context).pop();
                  },
                  child: ExchangeSheetItem(exchange: exchange),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
