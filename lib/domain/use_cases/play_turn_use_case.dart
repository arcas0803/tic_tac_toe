import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/domain/entities/board_entity.dart';
import 'package:tic_tac_toe/domain/entities/game_entity.dart';
import 'package:tic_tac_toe/domain/entities/player_entity.dart';
import 'package:tic_tac_toe/domain/entities/result.dart';
import 'package:tic_tac_toe/domain/entities/symbol_play.dart';
import 'package:tic_tac_toe/domain/entities/turn_entity.dart';
import 'package:tic_tac_toe/domain/use_cases/check_winner_use_case.dart';
import 'package:tic_tac_toe/domain/use_cases/save_game_use_case.dart';
import 'package:tic_tac_toe/domain/use_cases/use_case.dart';

class PlayTurnParams extends Equatable {
  final GameEntity prevGame;
  final BoardEntity newBoard;
  const PlayTurnParams({
    required this.prevGame,
    required this.newBoard,
  });

  PlayTurnParams copyWith({
    GameEntity? prevGame,
    BoardEntity? newBoard,
  }) {
    return PlayTurnParams(
      prevGame: prevGame ?? this.prevGame,
      newBoard: newBoard ?? this.newBoard,
    );
  }

  @override
  String toString() =>
      'PlayTurnParams(prevGame: $prevGame, newBoard: $newBoard)';

  @override
  List<Object> get props => [prevGame, newBoard];
}

class PlayTurnUseCase implements UseCaseFuture<GameEntity, PlayTurnParams> {
  final CheckWinnerUseCase _checkWinnerUseCase;
  final SaveGameUseCase _saveGameUseCase;

  const PlayTurnUseCase(
      {required CheckWinnerUseCase checkWinnerUseCase,
      required SaveGameUseCase saveGameUseCase})
      : _checkWinnerUseCase = checkWinnerUseCase,
        _saveGameUseCase = saveGameUseCase;

  /// Get the new current user for the new turn.
  PlayerEntity _getNewCurrentPlayer({required GameEntity prevGame}) {
    if (prevGame.player1 == prevGame.turns.last.currentPlayer) {
      return prevGame.player2;
    } else {
      return prevGame.player1;
    }
  }

  @override
  Future<Result<GameEntity>> call({required PlayTurnParams params}) {
    // New turns list
    List<TurnEntity> newTurns = List<TurnEntity>.from(params.prevGame.turns);
    // New current player
    final PlayerEntity currentPlayer =
        _getNewCurrentPlayer(prevGame: params.prevGame);

    // Check if the game is over.
    final checkWinnerResult = _checkWinnerUseCase.call(
      params: CheckWinnerParams(
        board: params.newBoard,
      ),
    );

    return checkWinnerResult.when(
      success: (SymbolPlay? symbolPlay) {
        // New turn
        final newTurn = TurnEntity(
          // new board
          board: params.newBoard,
          // new current player
          currentPlayer: currentPlayer,
          // If there is a winner, the winner player is the current player.
          winner: symbolPlay != null
              ? params.prevGame.getPlayerFromSymbol(symbol: symbolPlay)
              : null,
        );
        // Add the new turn to the turns list.
        newTurns.add(newTurn);
        // Update the game with the new turns list.
        final newGame = params.prevGame.copyWith(
          turns: newTurns,
        );

        // Save the game.
        final saveGameResult = _saveGameUseCase.call(
          params: SaveGameParams(
            game: newGame,
          ),
        );

        return saveGameResult.then(
          (value) {
            return value.when(
              // If save game is successful, return the new game.
              success: (void data) => Result.success(data: newGame),
              // If save game is not successful, return the error.
              failure: (error) => Result.failure(error: error),
            );
          },
        );
      },
      // If the game check winner goes wrong, return the error.
      failure: (error) => Future.value(
        Result.failure(error: error),
      ),
    );
  }
}
