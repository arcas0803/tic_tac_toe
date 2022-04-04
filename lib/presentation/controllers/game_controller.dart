import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/domain/entities/game_entity.dart';
import 'package:tic_tac_toe/domain/use_cases/check_winner_use_case.dart';
import 'package:tic_tac_toe/domain/use_cases/play_turn_use_case.dart';
import 'package:tic_tac_toe/domain/use_cases/replay_turn_use_case.dart';
import 'package:tic_tac_toe/domain/use_cases/start_game_use_case.dart';

final startGameUseCaseProvider = Provider<StartGameUseCase>((ref) {
  return const StartGameUseCase();
});

final checkWinnerUseCaseProvider = Provider<CheckWinnerUseCase>((ref) {
  return CheckWinnerUseCase();
});

final playTurnUseCaseProvider = Provider<PlayTurnUseCase>((ref) {
  final checkWinnerUseCase = ref.watch(checkWinnerUseCaseProvider);
  return PlayTurnUseCase(
    checkWinnerUseCase: checkWinnerUseCase,
  );
});

final replayTurnUseCaseProvider = Provider<ReplayTurnUseCase>((ref) {
  return ReplayTurnUseCase();
});

final gameParamStateProvider = StateProvider<GameEntity?>((ref) => null);

final gameControllerProvider =
    StateNotifierProvider<GameController, GameEntity>((ref) {
  final startGameUseCase = ref.watch(startGameUseCaseProvider);
  final playTurnUseCase = ref.watch(playTurnUseCaseProvider);
  final replayTurnUseCase = ref.watch(replayTurnUseCaseProvider);
  final gameEntity = ref.watch(gameParamStateProvider);
  return GameController(
    startGameUseCase: startGameUseCase,
    playTurnUseCase: playTurnUseCase,
    replayTurnUseCase: replayTurnUseCase,
    gameEntity: gameEntity,
  );
});

class GameController extends StateNotifier<GameEntity> {
  final StartGameUseCase _startGameUseCase;
  final PlayTurnUseCase _playTurnUseCase;
  final ReplayTurnUseCase _replayTurnUseCase;

  GameController(
      {required StartGameUseCase startGameUseCase,
      required PlayTurnUseCase playTurnUseCase,
      required ReplayTurnUseCase replayTurnUseCase,
      GameEntity? gameEntity})
      : _startGameUseCase = startGameUseCase,
        _playTurnUseCase = playTurnUseCase,
        _replayTurnUseCase = replayTurnUseCase,
        super(
          gameEntity ??
              GameEntity.initial(
                  player1Name: 'Player 1', player2Name: 'Player 2'),
        );

  Future<void> playTurn({
    required int row,
    required int column,
  }) async {
    //final newBoard = _updateBoard(row: row, column: column);
    final result = _playTurnUseCase(
      params: PlayTurnParams(
        cellEntity: state.currentBoard.board[row][column],
        symbolPlay: state.currentTurn.currentPlayer.symbol,
        prevGame: state,
      ),
    );
    result.ifSuccess((data) {
      state = data;
    });
  }

  Future<void> replayTurn() async {
    if (!state.canReplay) return;

    final result = _replayTurnUseCase(
      params: ReplayTurnParams(
        game: state,
      ),
    );
    result.ifSuccess(
      (data) {
        state = data;
      },
    );
  }

  void restartGame() {
    final result = _startGameUseCase(
      params: StartGameParams(gameEntity: state),
    );
    result.ifSuccess((data) {
      state = data;
    });
  }
}
