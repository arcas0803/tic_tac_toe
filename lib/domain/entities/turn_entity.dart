import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/domain/entities/board_entity.dart';
import 'package:tic_tac_toe/domain/entities/cell_entity.dart';
import 'package:tic_tac_toe/domain/entities/player_entity.dart';

/// Turn entity represents a turn of the game.
/// It contains the board, the current player and the winner is optional.
/// If the winner is not null, the game is over.

class TurnEntity extends Equatable {
  // Current player
  final PlayerEntity currentPlayer;

  // Winner cells.
  final List<CellEntity>? winnerCells;

  // Board of the game in this turn
  final BoardEntity board;

  const TurnEntity({
    required this.currentPlayer,
    this.winnerCells,
    required this.board,
  });

  /// Get the winner player from the turn.
  PlayerEntity? get winner => winnerCells != null ? currentPlayer : null;

  /// Use this constructor to create the first turn in a new game.
  TurnEntity.initial({required this.currentPlayer, int size = 3})
      : winnerCells = null,
        board = BoardEntity.bySize(size: size);

  TurnEntity copyWith({
    PlayerEntity? currentPlayer,
    List<CellEntity>? winnerCells,
    BoardEntity? board,
  }) {
    return TurnEntity(
      currentPlayer: currentPlayer ?? this.currentPlayer,
      winnerCells: winnerCells ?? this.winnerCells,
      board: board ?? this.board,
    );
  }

  @override
  String toString() =>
      'TurnEntity(currentPlayer: $currentPlayer, winnerCells: $winnerCells, board: $board)';

  @override
  List<Object?> get props => [currentPlayer, winnerCells, board];
}
