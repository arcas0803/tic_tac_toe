import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/domain/entities/cell_entity.dart';
import 'package:tic_tac_toe/domain/entities/symbol_play.dart';

class BoardEntity extends Equatable {
  /// List of cells on the board
  final List<List<CellEntity>> board;

  /// Size of the board. It is always square. The minimum size is 3x3.
  final int size;

  const BoardEntity({
    required this.board,
    required this.size,
  });

  /// Creates a new board entity with the [board] as a parameter.
  const BoardEntity.byBoard({
    required this.board,
  }) : size = board.length;

  /// Creates a new board entity from a [size] board.
  /// If size is null, it will be set to 3.
  /// If size is less than 3, an assert will be thrown.
  BoardEntity.bySize({this.size = 3})
      : board = List.generate(
          size,
          (i) => List.generate(
            size,
            (j) => CellEntity.initial(column: j, row: i),
          ),
        ),
        assert(size >= 3);

  /// Checks if the there is a row with the same symbol in the board.
  /// If there is, it returns the row.
  List<CellEntity>? checkRows() {
    for (var i = 0; i < size; i++) {
      var row = board[i];
      if (row.every((cell) =>
          cell.value == row[0].value && cell.value != SymbolPlay.none)) {
        return row;
      }
    }
    return null;
  }

  /// Checks if the there is a column with the same symbol in the board.
  /// If there is, returns the column.
  List<CellEntity>? checkColumns() {
    for (var i = 0; i < size; i++) {
      var column = board.map((row) => row[i]).toList();
      if (column.every((cell) =>
          cell.value == column[0].value && cell.value != SymbolPlay.none)) {
        return column;
      }
    }
    return null;
  }

  /// Checks if the there is a diagonal with the same symbol in the board.
  /// If there is, returns the diagonal.
  List<CellEntity>? checkDiagonals() {
    var diagonal1 = List.generate(size, (i) => board[i][i]);
    if (diagonal1.every((cell) =>
        cell.value == diagonal1[0].value && cell.value != SymbolPlay.none)) {
      return diagonal1;
    }

    var diagonal2 = List.generate(size, (i) => board[i][size - i - 1]);
    if (diagonal2.every((cell) =>
        cell.value == diagonal2[0].value && cell.value != SymbolPlay.none)) {
      return diagonal2;
    }

    return null;
  }

  BoardEntity copyWith({
    List<List<CellEntity>>? board,
    int? size,
  }) {
    return BoardEntity(
      board: board ?? this.board,
      size: size ?? this.size,
    );
  }

  @override
  String toString() => 'BoardEntity(board: $board, size: $size)';

  @override
  List<Object> get props => [board, size];
}
