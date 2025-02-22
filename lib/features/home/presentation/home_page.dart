import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/colors.dart';
import '../../exchange_symbols/bloc/exchange_symbols_bloc.dart';
import '../../exchange_symbols/presentation/exchange_symbols_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      body: BlocProvider(
        create: (context) => ExchangeSymbolsBloc(),
        child: ExchangeSymbolsPage(),
      ),
    );
  }
}
