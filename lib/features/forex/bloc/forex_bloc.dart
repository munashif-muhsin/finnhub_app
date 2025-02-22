import 'dart:developer';

import 'package:finnhub_app/features/forex/repositories/forex_repository.dart';
import 'package:finnhub_app/features/forex/repositories/forex_repository_i.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main.dart';
import '../models/forex_symbol_model.dart';

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
      emit(state.copyWith(isLoading: true));

      final List<String> exchanges = await _forexRepository.getExchanges();
      emit(state.copyWith(exchanges: exchanges, isLoading: false));

      if (exchanges.isNotEmpty) {
        add(ChangeExchange(exchanges.first));
        emit(state.copyWith(selectedExchange: exchanges.first));
      } else {
        emit(state.copyWith(isSymbolsLoading: false));
      }
    } catch (e, stackTrace) {
      emit(state.copyWith(isLoading: false));
      log(e.toString(), stackTrace: stackTrace);
    }
  }

  Future<void> _onInitializeForexSymbols(
    ChangeExchange event,
    Emitter<ForexState> emit,
  ) async {
    try {
      if (state.selectedExchange == null) return;

      emit(state.copyWith(isSymbolsLoading: true));

      final List<ForexSymbol> symbols = await _forexRepository.getSymbols(state.selectedExchange!);
      emit(state.copyWith(symbols: symbols, isSymbolsLoading: false));
    } catch (e, stackTrace) {
      emit(state.copyWith(isSymbolsLoading: false));
      log(e.toString(), stackTrace: stackTrace);
    }
  }
}
