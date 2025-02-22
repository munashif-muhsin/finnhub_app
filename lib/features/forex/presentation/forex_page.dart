import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/colors.dart';
import '../bloc/forex_bloc.dart';
import 'components/exchange_picker.dart';
import 'components/forex_symbol_widget.dart';

class ForexPage extends StatefulWidget {
  const ForexPage({super.key});

  @override
  State<ForexPage> createState() => _ForexPageState();
}

class _ForexPageState extends State<ForexPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ForexBloc>(context).add(InitializeForexState());
  }

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
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
          child: BlocBuilder<ForexBloc, ForexState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator.adaptive());
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExchangePicker(
                    selectedExchange: state.selectedExchange ?? '--',
                    exchanges: state.exchanges,
                    onExchangeSelected: (exchange) {
                      BlocProvider.of<ForexBloc>(context).add(ChangeExchange(exchange));
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
                            return ForexSymbolWidget(symbol: state.symbols.elementAt(index));
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
