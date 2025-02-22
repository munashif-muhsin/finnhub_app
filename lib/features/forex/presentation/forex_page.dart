import 'package:flutter/material.dart';

import '../../../theme/colors.dart';
import 'components/exchange_picker.dart';
import 'components/forex_symbol.dart';

class ForexPage extends StatelessWidget {
  const ForexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      appBar: AppBar(
        title: Text(
          "Forex",
          style: TextTheme.of(context).headlineLarge,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
          child: Column(
            children: [
              ExchangePicker(),
              const SizedBox(height: 25),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return ForexSymbol();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
