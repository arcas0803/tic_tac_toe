import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/domain/entities/symbol_play.dart';
import 'package:tic_tac_toe/presentation/controllers/game_controller.dart';
import 'package:tic_tac_toe/presentation/pages/game_page/widgets/cell_game_value_widget.dart';

/// CellGameWidget represents a cell in the game board.
/// Each cell has a value and a position.
///
/// The position is used to determine the position of the cell in the game board.
///
/// The value is used to determine the symbol to be displayed in the cell.
/// There are three possible values:
/// - none: the cell is empty
/// - x: the cell is occupied by an x
/// - o: the cell is occupied by an o
///
/// The parameters [top], [right], [bottom], [left] are used to determine the lines
/// that are drawn around the cell.

class CellGameWidget extends ConsumerWidget {
  /// Needs a top line.
  final bool top;

  /// Needs a bottom line.
  final bool bottom;

  /// Needs a left line.
  final bool left;

  /// Needs a right line.
  final bool right;

  final int row;

  final int column;

  const CellGameWidget({
    Key? key,
    this.top = false,
    this.bottom = false,
    this.left = false,
    this.right = false,
    required this.column,
    required this.row,
  }) : super(key: key);

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      border: Border(
        top: top
            ? const BorderSide(color: Colors.black, width: 2)
            : BorderSide.none,
        bottom: bottom
            ? const BorderSide(color: Colors.black, width: 2)
            : BorderSide.none,
        left: left
            ? const BorderSide(color: Colors.black, width: 2)
            : BorderSide.none,
        right: right
            ? const BorderSide(color: Colors.black, width: 2)
            : BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context, ref) {
    // Get the current cell from the board.
    final cell = ref.watch(
      gameControllerProvider.select(
        (value) => value.currentBoard.board[row][column],
      ),
    );
    // Determines the color of the cell.
    final color = ref.watch(
      gameControllerProvider.select(
        (value) {
          // If the cell is winner cell, then the color is the default color for winner.
          if (value.winnerCells != null) {
            if (value.winnerCells!.contains(cell)) {
              return Colors.deepPurple;
            }
          }

          // If the cell contains the symbol of player 1, then the color is player1 color.
          if (value.currentBoard.board[row][column].value ==
              value.player1.symbol) {
            return value.player1.color;
          }
          // If the cell contains the symbol of player 2, then the color is player2 color.
          if (value.currentBoard.board[row][column].value ==
              value.player2.symbol) {
            return value.player2.color;
          }

          // If the cell is empty, then the color is the default color for empty.
          return Colors.black;
        },
      ),
    );
    // Determines the hability of the cell to changes it's value.
    final canChangeValue = ref.watch(
      gameControllerProvider.select(
        (value) {
          // If there is a previous symbol, then the cell is not empty, so it can't be changed.
          if (value.currentBoard.board[row][column].value != SymbolPlay.none) {
            return false;
          }
          // If the game is over, then the cell can't be changed.
          if (value.winnerPlayer != null) {
            return false;
          }
          return true;
        },
      ),
    );

    return GestureDetector(
      // If the game has a winner (game over), the cell should be disabled.
      onTap: canChangeValue
          ? () => ref.read(gameControllerProvider.notifier).playTurn(
                column: column,
                row: row,
              )
          : null,
      child: Container(
        decoration: _buildBoxDecoration(),
        child: CellGameValueWidget(
          color: color,
          value: cell.value,
        ),
      ),
    );
  }
}
