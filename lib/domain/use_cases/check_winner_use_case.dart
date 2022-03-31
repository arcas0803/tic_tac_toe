import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/domain/entities/board_entity.dart';
import 'package:tic_tac_toe/domain/entities/result.dart';
import 'package:tic_tac_toe/domain/entities/symbol_play.dart';
import 'package:tic_tac_toe/domain/use_cases/use_case.dart';

class CheckWinnerParams extends Equatable {
  final BoardEntity board;

  const CheckWinnerParams({
    required this.board,
  });

  CheckWinnerParams copyWith({
    BoardEntity? board,
  }) {
    return CheckWinnerParams(
      board: board ?? this.board,
    );
  }

  @override
  String toString() => 'CheckWinnerParams(board: $board)';

  @override
  List<Object> get props => [board];
}

class CheckWinnerUseCase
    implements UseCase<List<List<int>>?, CheckWinnerParams> {
  // Check all rows for a winner.
  List<List<int>>? _checkRows({required BoardEntity board}) {
    // Build an array of all rows checks.
    // If a row contains the same symbol in all cells, return true.
    // Otherwise, return false.
    final results = board.board
        .map((e) =>
            e.every((element) => element == e[0] && element != SymbolPlay.none))
        .toList();

    // Check results. If a row contains a winner result, return the position of all cells of the winner combination.
    for (int i = 0; i < results.length; i++) {
      if (results[i]) {
        List<List<int>> winnerCells = [];
        for (int j = 0; j < board.board.length; j++) {
          winnerCells.add([i, j]);
        }
        return winnerCells;
      }
    }
    return null;
  }

  // Check all columns for a winner.
  List<List<int>>? _checkColumns({required BoardEntity board}) {
    // Transpose matriz to evaluate columns as rows.
    final List<List<SymbolPlay>> boardTemp = [];

    for (int row = 0; row < board.board.length; row++) {
      boardTemp.add(<SymbolPlay>[]);
      for (int column = 0; column < board.board[row].length; column++) {
        boardTemp[row].add(board.board[column][row]);
      }
    }

    return _checkRows(board: BoardEntity(board: boardTemp));
  }

  List<List<int>>? _checkDiagonals({required BoardEntity board}) {
    // Check first diagonal.
    final firstDiagonal = [];

    int columnFirst = 0;
    for (int rowFirst = 0; rowFirst < board.board.length; rowFirst++) {
      firstDiagonal.add(board.board[rowFirst][columnFirst]);
      columnFirst++;
    }

    if (firstDiagonal.every((element) => element == firstDiagonal[0])) {
      if (firstDiagonal[0] == SymbolPlay.none) {
        return null;
      }
      // If a diagonal contains a winner result, return the position of all cells of the winner combination.
      List<List<int>> winnerCells = [];
      int columnFirst = 0;
      for (int rowFirst = 0; rowFirst < board.board.length; rowFirst++) {
        winnerCells.add([rowFirst, columnFirst]);
        columnFirst++;
      }
      return winnerCells;
    }

    // Check second diagonal.
    final secondDiagonal = [];
    int columnSecond = board.board.length - 1;

    for (int rowSecond = 0; rowSecond < board.board.length; rowSecond++) {
      secondDiagonal.add(board.board[rowSecond][columnSecond]);
      columnSecond--;
    }
    if (secondDiagonal.every((element) => element == secondDiagonal[0])) {
      if (secondDiagonal[0] == SymbolPlay.none) {
        return null;
      }

      // If a diagonal contains a winner result, return the position of all cells of the winner combination.
      List<List<int>> winnerCells = [];
      int columnSecond = board.board.length - 1;

      for (int rowSecond = 0; rowSecond < board.board.length; rowSecond++) {
        winnerCells.add([rowSecond, columnSecond]);
        columnSecond--;
      }
      return winnerCells;
    }

    return null;
  }

  @override
  Result<List<List<int>>?> call({required CheckWinnerParams params}) {
    final board = params.board;

    // Check rows.
    final resultRows = _checkRows(board: board);
    if (resultRows != null && resultRows.isNotEmpty) {
      return Result.success(data: resultRows);
    }
    // Check columns.
    final resultColumns = _checkColumns(board: board);
    if (resultColumns != null && resultColumns.isNotEmpty) {
      return Result.success(data: resultColumns);
    }

    // Check diagonals.
    final resultDiagonals = _checkDiagonals(board: board);
    if (resultDiagonals != null && resultDiagonals.isNotEmpty) {
      return Result.success(data: resultDiagonals);
    }

    return const Result.success(data: null);
  }
}
