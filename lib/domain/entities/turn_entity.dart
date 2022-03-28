import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/domain/entities/board_entity.dart';
import 'package:tic_tac_toe/domain/entities/player_entity.dart';

/// Turn entity represents a turn of the game.
/// It contains the board, the current player and the winner is optional.
/// If the winner is not null, the game is over.

class TurnEntity extends Equatable {
  // Current player
  final PlayerEntity currentPlayer;
  // Winner player
  final PlayerEntity? winner;
  // Board of the game in this turn
  final BoardEntity board;

  const TurnEntity({
    required this.currentPlayer,
    this.winner,
    required this.board,
  });

  /// Use this constructor to create the first turn in a new game.
  const TurnEntity.initial({required this.currentPlayer})
      : winner = null,
        board = const BoardEntity.initial();

  TurnEntity copyWith({
    PlayerEntity? currentPlayer,
    PlayerEntity? winner,
    BoardEntity? board,
  }) {
    return TurnEntity(
      currentPlayer: currentPlayer ?? this.currentPlayer,
      winner: winner ?? this.winner,
      board: board ?? this.board,
    );
  }

  @override
  String toString() =>
      'TurnEntity(currentPlayer: $currentPlayer, winner: $winner, board: $board)';

  @override
  List<Object?> get props => [currentPlayer, winner, board];
}
