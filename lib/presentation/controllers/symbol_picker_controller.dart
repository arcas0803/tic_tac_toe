import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/domain/entities/symbol_play.dart';

class SymbolPickerState extends Equatable {
  final SymbolPlay player1Symbol;
  final SymbolPlay player2Symbol;
  const SymbolPickerState({
    required this.player1Symbol,
    required this.player2Symbol,
  });

  const SymbolPickerState.initial({
    this.player1Symbol = SymbolPlay.x,
    this.player2Symbol = SymbolPlay.o,
  });

  SymbolPickerState copyWith({
    SymbolPlay? player1Symbol,
    SymbolPlay? player2Symbol,
  }) {
    return SymbolPickerState(
      player1Symbol: player1Symbol ?? this.player1Symbol,
      player2Symbol: player2Symbol ?? this.player2Symbol,
    );
  }

  @override
  String toString() =>
      'SymbolPickerState(player1Symbol: $player1Symbol, player2Symbol: $player2Symbol)';

  @override
  List<Object> get props => [player1Symbol, player2Symbol];
}

class SymbolPickerController extends StateNotifier<SymbolPickerState> {
  SymbolPickerController() : super(const SymbolPickerState.initial());

  void changePlayer1Symbol({required SymbolPlay symbolPlay}) {
    state = state.copyWith(
      player1Symbol: symbolPlay,
      player2Symbol: symbolPlay == SymbolPlay.x ? SymbolPlay.o : SymbolPlay.x,
    );
  }

  void changePlayer2Symbol({required SymbolPlay symbolPlay}) {
    state = state.copyWith(
      player1Symbol: symbolPlay == SymbolPlay.x ? SymbolPlay.o : SymbolPlay.x,
      player2Symbol: symbolPlay,
    );
  }
}

final symbolPickerControllerProvider =
    StateNotifierProvider<SymbolPickerController, SymbolPickerState>(
  (ref) => SymbolPickerController(),
);
