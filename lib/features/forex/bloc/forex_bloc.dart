import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';
import '../../../utils/toasts.dart';
import '../models/forex_symbol_model.dart';
import '../repositories/forex_repository.dart';
import '../repositories/forex_repository_i.dart';

part 'forex_event.dart';
part 'forex_state.dart';

class ForexBloc extends Bloc<ForexEvent, ForexState> {
  final ForexRepository _forexRepository = ForexRepositoryImplementation(apiUrls);

  ForexBloc() : super(ForexState.initial()) {
    on<InitializeForexState>(_onInitializeForexState);
    on<ChangeExchange>(_onInitializeForexSymbols);
  }

  Future<void> _onInitializeForexState(
    InitializeForexState event,
    Emitter<ForexState> emit,
  ) async {
    try {
      emit(state.copyWith(isLoading: true, hasError: false));

      final List<String> exchanges = await _forexRepository.getExchanges();
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

  Future<void> _onInitializeForexSymbols(
    ChangeExchange event,
    Emitter<ForexState> emit,
  ) async {
    try {
      emit(state.copyWith(
        selectedExchange: event.exchange,
        isSymbolsLoading: true,
        hasError: false,
      ));

      final List<ForexSymbol> symbols = await _forexRepository.getSymbols(state.selectedExchange!);
      emit(state.copyWith(symbols: symbols, isSymbolsLoading: false));
    } catch (e, stackTrace) {
      Toasts.failure(e.toString());
      emit(state.copyWith(isSymbolsLoading: false, hasError: true));
      log(e.toString(), stackTrace: stackTrace);
    }
  }
}
