import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';
import '../../../utils/toasts.dart';
import '../../common/models/exchange_symbol_model.dart';
import '../repositories/exchange_symbols_repository.dart';
import '../repositories/exchange_symbols_repository_i.dart';

part 'exchange_symbols_event.dart';
part 'exchange_symbols_state.dart';

enum ExchangeType {
  forex,
  crypto,
}

class ExchangeSymbolsBloc extends Bloc<ExchangeSymbolsEvent, ExchangeSymbolsState> {
  final ExchangeSymbolsRepository _exchangeSymbolsRepository = ExchangeSymbolsRepositoryImplementation(apiUrls);
  final ExchangeType exchangeType;

  ExchangeSymbolsBloc(this.exchangeType) : super(ExchangeSymbolsState.initial()) {
    on<InitializeExchangeSymbolsState>(_onInitializeExchangeState);
    on<ChangeExchange>(_onInitializeSymbols);
  }

  Future<void> _onInitializeExchangeState(
    InitializeExchangeSymbolsState event,
    Emitter<ExchangeSymbolsState> emit,
  ) async {
    try {
      emit(state.copyWith(hasError: false));

      final List<String> exchanges = await _exchangeSymbolsRepository.getExchanges(exchangeType.name);
      emit(state.copyWith(exchanges: exchanges, isLoading: false));

      if (exchanges.isNotEmpty) {
        add(ChangeExchange(exchanges.first));
      } else {
        emit(state.copyWith(isSymbolsLoading: false));
      }
    } catch (e, stackTrace) {
      Toasts.failure(e.toString());
      emit(state.copyWith(isLoading: false, hasError: true));
      log(e.toString(), stackTrace: stackTrace);
    }
  }

  Future<void> _onInitializeSymbols(
    ChangeExchange event,
    Emitter<ExchangeSymbolsState> emit,
  ) async {
    try {
      emit(state.copyWith(
        selectedExchange: event.exchange,
        isSymbolsLoading: true,
        hasError: false,
      ));

      final List<ExchangeSymbol> symbols = await _exchangeSymbolsRepository.getSymbols(
        state.selectedExchange!,
        exchangeType.name,
      );
      emit(state.copyWith(symbols: symbols, isSymbolsLoading: false));
    } catch (e, stackTrace) {
      Toasts.failure(e.toString());
      emit(state.copyWith(isSymbolsLoading: false, hasError: true));
      log(e.toString(), stackTrace: stackTrace);
    }
  }
}
