import 'package:flutter/material.dart';

import '../../../../theme/colors.dart';
import '../../../../theme/decorations.dart';
import 'exchange_picker_sheet.dart';

class ExchangePicker extends StatelessWidget {
  const ExchangePicker({
    super.key,
    required this.selectedExchange,
    this.exchanges = const [],
    this.onExchangeSelected,
  });

  final String selectedExchange;
  final List<String> exchanges;
  final void Function(String)? onExchangeSelected;

  void _showExchangePicker(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          maxChildSize: 0.8,
          expand: false,
          builder: (context, scrollController) {
            return ExchangePickerSheet(
              exchanges: exchanges,
              onExchangeSelected: onExchangeSelected,
              scrollController: scrollController,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showExchangePicker(context),
      child: Container(
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
      ),
    );
  }
}
