import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/domain/entities/board_entity.dart';
import 'package:tic_tac_toe/domain/entities/game_entity.dart';
import 'package:tic_tac_toe/domain/entities/symbol_play.dart';
import 'package:tic_tac_toe/domain/use_cases/check_winner_use_case.dart';
import 'package:tic_tac_toe/domain/use_cases/play_turn_use_case.dart';
import 'package:tic_tac_toe/domain/use_cases/save_game_use_case.dart';
import 'package:tic_tac_toe/domain/use_cases/start_game_use_case.dart';
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

final gameControllerProvider =
    StateNotifierProvider<GameController, GameEntity>((ref) {
  final startGameUseCase = ref.watch(startGameUseCaseProvider);
  final playTurnUseCase = ref.watch(playTurnUseCaseProvider);
  return GameController(
      startGameUseCase: startGameUseCase, playTurnUseCase: playTurnUseCase);
});

class GameController extends StateNotifier<GameEntity> {
  final StartGameUseCase _startGameUseCase;
  final PlayTurnUseCase _playTurnUseCase;

  GameController(
      {required StartGameUseCase startGameUseCase,
      required PlayTurnUseCase playTurnUseCase})
      : _startGameUseCase = startGameUseCase,
        _playTurnUseCase = playTurnUseCase,
        super(GameEntity.initial());

  BoardEntity _updateBoard({required int column, required int row}) {
    List<List<SymbolPlay>> currentBoard = [];
    for (int i = 0; i < state.currentTurn.board.board.length; i++) {
      currentBoard.add([]);
      for (int j = 0; j < state.currentTurn.board.board[i].length; j++) {
        currentBoard[i].add(state.currentTurn.board.board[i][j]);
      }
    }

    currentBoard[column].removeAt(row);
    currentBoard[column].insert(row, state.currentTurn.currentPlayer.symbol);

    return BoardEntity(board: currentBoard);
  }

  Future<void> playTurn({required int column, required int row}) async {
    final newBoard = _updateBoard(column: column, row: row);
    final result = await _playTurnUseCase(
      params: PlayTurnParams(
        newBoard: newBoard,
        prevGame: state,
      ),
    );
    result.ifSuccess((data) {
      print(data.currentTurn.board.board.toString());
      print(data.currentTurn.winner);
      state = data;
    });
  }
}
