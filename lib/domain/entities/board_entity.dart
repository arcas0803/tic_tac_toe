import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/domain/entities/symbol_play.dart';

class BoardEntity extends Equatable {
  final List<List<SymbolPlay>> board;
  const BoardEntity({
    required this.board,
  });

  const BoardEntity.initial()
      : board = const <List<SymbolPlay>>[
          <SymbolPlay>[SymbolPlay.none, SymbolPlay.none, SymbolPlay.none],
          <SymbolPlay>[SymbolPlay.none, SymbolPlay.none, SymbolPlay.none],
          <SymbolPlay>[SymbolPlay.none, SymbolPlay.none, SymbolPlay.none],
        ];

  BoardEntity.fromString({required List<List<String>> boardString})
      : board = boardString
            .map((row) => row
                .map((cell) {
                  switch (cell) {
                    case 'X':
                      return SymbolPlay.x;
                    case 'O':
                      return SymbolPlay.o;
                    default:
                      return SymbolPlay.none;
                  }
                })
                .toList()
                .cast<SymbolPlay>())
            .toList();

  List<List<String>> boardToString() {
    return board
        .map(
          (row) => row.map((cell) {
            if (cell == SymbolPlay.none) {
              return ' ';
            }

            return cell.toString();
          }).toList(),
        )
        .toList();
  }

  BoardEntity copyWith({
    List<List<SymbolPlay>>? board,
  }) {
    return BoardEntity(
      board: board ?? this.board,
    );
  }

  @override
  String toString() => 'BoardEntity(board: $board)';

  @override
  List<Object> get props => [board];
}
