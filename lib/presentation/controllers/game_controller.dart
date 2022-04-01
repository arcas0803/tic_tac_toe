import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/domain/entities/board_entity.dart';
import 'package:tic_tac_toe/domain/entities/game_entity.dart';
import 'package:tic_tac_toe/domain/entities/symbol_play.dart';
import 'package:tic_tac_toe/domain/use_cases/check_winner_use_case.dart';
import 'package:tic_tac_toe/domain/use_cases/play_turn_use_case.dart';
import 'package:tic_tac_toe/domain/use_cases/replay_turn_use_case.dart';
import 'package:tic_tac_toe/domain/use_cases/save_game_use_case.dart';
import 'package:tic_tac_toe/domain/use_cases/start_game_use_case.dart';
import 'package:tic_tac_toe/domain/use_cases/use_case.dart';
import 'package:tic_tac_toe/presentation/controllers/games_controller.dart';

final startGameUseCaseProvider = Provider<StartGameUseCase>((ref) {
  return const StartGameUseCase();
});

final saveGameUseCaseProvider = Provider<SaveGameUseCase>((ref) {
  final repository = ref.watch(gameRepositoryProvider);
  return SaveGameUseCase(repository: repository);
});

final checkWinnerUseCaseProvider = Provider<CheckWinnerUseCase>((ref) {
  return CheckWinnerUseCase();
});

final playTurnUseCaseProvider = Provider<PlayTurnUseCase>((ref) {
  final saveGameUseCase = ref.watch(saveGameUseCaseProvider);
  final checkWinnerUseCase = ref.watch(checkWinnerUseCaseProvider);
  return PlayTurnUseCase(
      checkWinnerUseCase: checkWinnerUseCase, saveGameUseCase: saveGameUseCase);
});

final replayTurnUseCaseProvider = Provider<ReplayTurnUseCase>((ref) {
  final saveGameUseCase = ref.watch(saveGameUseCaseProvider);

  return ReplayTurnUseCase(saveGameUseCase: saveGameUseCase);
});

final gameControllerProvider =
    StateNotifierProvider<GameController, GameEntity>((ref) {
  final startGameUseCase = ref.watch(startGameUseCaseProvider);
  final playTurnUseCase = ref.watch(playTurnUseCaseProvider);
  final replayTurnUseCase = ref.watch(replayTurnUseCaseProvider);
  return GameController(
      startGameUseCase: startGameUseCase,
      playTurnUseCase: playTurnUseCase,
      replayTurnUseCase: replayTurnUseCase);
});

class GameController extends StateNotifier<GameEntity> {
  final StartGameUseCase _startGameUseCase;
  final PlayTurnUseCase _playTurnUseCase;
  final ReplayTurnUseCase _replayTurnUseCase;

  GameController(
      {required StartGameUseCase startGameUseCase,
      required PlayTurnUseCase playTurnUseCase,
      required ReplayTurnUseCase replayTurnUseCase})
      : _startGameUseCase = startGameUseCase,
        _playTurnUseCase = playTurnUseCase,
        _replayTurnUseCase = replayTurnUseCase,
        super(GameEntity.initial());

  BoardEntity _updateBoard({required int row, required int column}) {
    List<List<SymbolPlay>> currentBoard = [];
    for (int i = 0; i < state.currentTurn.board.board.length; i++) {
      currentBoard.add([]);
      for (int j = 0; j < state.currentTurn.board.board[i].length; j++) {
        currentBoard[i].add(state.currentTurn.board.board[i][j]);
      }
    }

    currentBoard[row].removeAt(column);
    currentBoard[row].insert(column, state.currentTurn.currentPlayer.symbol);

    return BoardEntity(board: currentBoard);
  }

  Future<void> playTurn({
    required int row,
    required int column,
  }) async {
    final newBoard = _updateBoard(row: row, column: column);
    final result = await _playTurnUseCase(
      params: PlayTurnParams(
        newBoard: newBoard,
        prevGame: state,
      ),
    );
    result.ifSuccess((data) {
      state = data;
    });
  }

  Future<void> replayTurn() async {
    if (!state.canReplay) return;
    final result = await _replayTurnUseCase(
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
      params: NoParams(),
    );
    result.ifSuccess((data) {
      state = data;
    });
  }
}
