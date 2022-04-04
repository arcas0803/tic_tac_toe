import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/domain/entities/board_entity.dart';
import 'package:tic_tac_toe/domain/entities/cell_entity.dart';
import 'package:tic_tac_toe/domain/entities/result.dart';
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

/// Checks all possible winning combinations and returns the winner if there is one.
class CheckWinnerUseCase
    implements UseCase<List<CellEntity>?, CheckWinnerParams> {
  @override
  Result<List<CellEntity>?> call({required CheckWinnerParams params}) {
    final board = params.board;

    // Check rows.
    final resultRows = board.checkRows();
    if (resultRows != null && resultRows.isNotEmpty) {
      return Result.success(data: resultRows);
    }
    // Check columns.
    final resultColumns = board.checkColumns();
    if (resultColumns != null && resultColumns.isNotEmpty) {
      return Result.success(data: resultColumns);
    }

    // Check diagonals.
    final resultDiagonals = board.checkDiagonals();
    if (resultDiagonals != null && resultDiagonals.isNotEmpty) {
      return Result.success(data: resultDiagonals);
    }
    // If no winner combination found, return null.
    return const Result.success(data: null);
  }
}
