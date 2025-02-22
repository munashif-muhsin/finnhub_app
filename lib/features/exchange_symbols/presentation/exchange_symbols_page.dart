import 'package:finnhub_app/features/tick/presentation/tick_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/colors.dart';
import '../../common/widgets/error_retry_widget.dart';
import '../bloc/exchange_symbols_bloc.dart';
import 'components/exchange_picker.dart';
import 'components/exchange_symbol_widget.dart';

class ExchangeSymbolsPage extends StatelessWidget {
  const ExchangeSymbolsPage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      appBar: AppBar(
        title: Text(
          title,
          style: TextTheme.of(context).headlineLarge,
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
          child: BlocBuilder<ExchangeSymbolsBloc, ExchangeSymbolsState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator.adaptive());
              }

              if (state.hasError) {
                return ErrorRetryWidget(
                  onRetry: () {
                    BlocProvider.of<ExchangeSymbolsBloc>(context).add(InitializeExchangeSymbolsState());
                  },
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExchangePicker(
                    selectedExchange: state.selectedExchange ?? '--',
                    exchanges: state.exchanges,
                    onExchangeSelected: (exchange) {
                      BlocProvider.of<ExchangeSymbolsBloc>(context).add(ChangeExchange(exchange));
                    },
                  ),
                  const SizedBox(height: 25),

                  // List of Symbols
                  if (state.isSymbolsLoading)
                    const Center(child: CircularProgressIndicator.adaptive())
                  else ...[
                    if (state.symbols.isEmpty)
                      const Center(child: Text('No symbols found'))
                    else
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.symbols.length,
                          itemBuilder: (context, index) {
                            final symbol = state.symbols.elementAt(index);
                            return ExchangeSymbolWidget(
                              symbol: symbol,
                              tickWidget: TickWidget(symbol: symbol.symbol),
                            );
                          },
                        ),
                      )
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
