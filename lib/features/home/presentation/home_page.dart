import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/colors.dart';
import '../../exchange_symbols/bloc/exchange_symbols_bloc.dart';
import '../../exchange_symbols/presentation/exchange_symbols_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ExchangeSymbolsBloc forexBloc = ExchangeSymbolsBloc(ExchangeType.forex)..add(InitializeExchangeSymbolsState());

  final ExchangeSymbolsBloc cryptoBloc = ExchangeSymbolsBloc(ExchangeType.crypto)
    ..add(InitializeExchangeSymbolsState());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.of(context).background,
        body: TabBarView(children: [
          BlocProvider.value(
            value: forexBloc,
            child: const ExchangeSymbolsPage(title: "Forex"),
          ),
          BlocProvider.value(
            value: cryptoBloc,
            child: const ExchangeSymbolsPage(title: "Crypto"),
          ),
        ]),
        bottomNavigationBar: SafeArea(
          child: const TabBar(
            dividerColor: Colors.transparent,
            tabs: [
              Tab(icon: Icon(Icons.attach_money)),
              Tab(icon: Icon(Icons.currency_bitcoin)),
            ],
          ),
        ),
      ),
    );
  }
}
