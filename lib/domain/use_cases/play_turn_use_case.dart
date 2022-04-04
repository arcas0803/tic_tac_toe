import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/domain/entities/board_entity.dart';
import 'package:tic_tac_toe/domain/entities/cell_entity.dart';
import 'package:tic_tac_toe/domain/entities/game_entity.dart';
import 'package:tic_tac_toe/domain/entities/player_entity.dart';
import 'package:tic_tac_toe/domain/entities/result.dart';
import 'package:tic_tac_toe/domain/entities/symbol_play.dart';
import 'package:tic_tac_toe/domain/entities/turn_entity.dart';
import 'package:tic_tac_toe/domain/use_cases/check_winner_use_case.dart';
import 'package:tic_tac_toe/domain/use_cases/use_case.dart';

class PlayTurnParams extends Equatable {
  final GameEntity prevGame;
  final CellEntity cellEntity;
  final SymbolPlay symbolPlay;
  const PlayTurnParams({
    required this.prevGame,
    required this.cellEntity,
    required this.symbolPlay,
  });

  PlayTurnParams copyWith({
    GameEntity? prevGame,
    CellEntity? cellEntity,
    SymbolPlay? symbolPlay,
  }) {
    return PlayTurnParams(
      prevGame: prevGame ?? this.prevGame,
      cellEntity: cellEntity ?? this.cellEntity,
      symbolPlay: symbolPlay ?? this.symbolPlay,
    );
  }

  @override
  String toString() =>
      'PlayTurnParams(prevGame: $prevGame, cellEntity: $cellEntity, symbolPlay: $symbolPlay)';

  @override
  List<Object> get props => [prevGame, cellEntity, symbolPlay];
}

class PlayTurnUseCase implements UseCase<GameEntity, PlayTurnParams> {
  final CheckWinnerUseCase _checkWinnerUseCase;

  const PlayTurnUseCase({
    required CheckWinnerUseCase checkWinnerUseCase,
  }) : _checkWinnerUseCase = checkWinnerUseCase;

  /// Get the new current user for the new turn.
  PlayerEntity _getNewCurrentPlayer({required GameEntity prevGame}) {
    if (prevGame.player1 == prevGame.turns.last.currentPlayer) {
      return prevGame.player2;
    } else {
      return prevGame.player1;
    }
  }

  @override
  Result<GameEntity> call({required PlayTurnParams params}) {
    // New turns list
    List<TurnEntity> newTurns = [];
    for (var turn in params.prevGame.turns) {
      newTurns.add(turn);
    }

    // Copy las board
    List<List<CellEntity>> newBoard = [];

    for (var row in params.prevGame.currentBoard.board) {
      List<CellEntity> newRow = [];
      for (var cell in row) {
        newRow.add(cell);
      }
      newBoard.add(newRow);
    }

    // Update cell value
    newBoard[params.cellEntity.row][params.cellEntity.column] = CellEntity(
      row: params.cellEntity.row,
      column: params.cellEntity.column,
      value: params.symbolPlay,
    );

    BoardEntity newBoardEntity = BoardEntity(
      board: newBoard,
      size: params.prevGame.currentBoard.size,
    );

    // Check if the game is over.
    final checkWinnerResult = _checkWinnerUseCase.call(
      params: CheckWinnerParams(
        board: newBoardEntity,
      ),
    );

    return checkWinnerResult.when(
      success: (List<CellEntity>? winnerCells) {
        // New current player
        late PlayerEntity currentPlayer;
        // If there is a winner, the current player is the winner.
        if (winnerCells != null) {
          currentPlayer = params.prevGame.currentPlayer;
        } else {
          // If there is no winner, the opponent player is the new current player.
          currentPlayer = _getNewCurrentPlayer(prevGame: params.prevGame);
        }

        // New turn
        final newTurn = TurnEntity(
          // new board
          board: newBoardEntity,
          // new current player
          currentPlayer: currentPlayer,
          // If there is a winner, set the winner cells combination.
          winnerCells: winnerCells,
        );

        // Add the new turn to the turns list.
        newTurns.add(newTurn);

        // Update the game with the new turns list.
        final newGame = params.prevGame.copyWith(
          turns: newTurns,
        );

        return Result.success(data: newGame);
      },
      // If the game check winner goes wrong, return the error.
      failure: (error) => Result.failure(error: error),
    );
  }
}
