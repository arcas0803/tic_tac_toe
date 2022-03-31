import 'package:flutter/foundation.dart';
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

class CellGameWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      // Watch if there is a winner. If there is, the cell should be disabled.
      final winner = ref.watch(
          gameControllerProvider.select((value) => value.currentTurn.winner));

      // Watch the actual value of the cell.
      final value = ref.watch(
        gameControllerProvider.select(
          (value) => value.currentBoard.board[row][column],
        ),
      );

      final player1 = ref.watch(
        gameControllerProvider.select(
          (value) => value.player1,
        ),
      );

      final player2 = ref.watch(
        gameControllerProvider.select(
          (value) => value.player2,
        ),
      );

      final winnerCell = ref.watch(
        gameControllerProvider.select(
          (state) {
            if (state.winnerCells != null) {
              final search = state.winnerCells!
                  .indexWhere((element) => listEquals([row, column], element));
              return search != -1;
            }
            return false;
          },
        ),
      );

      return GestureDetector(
        // If the game has a winner (game over), the cell should be disabled.
        onTap: winner != null
            ? null
            // If a value has been set before, don't allow to change it.
            : value != SymbolPlay.none
                ? null
                : () => ref.read(gameControllerProvider.notifier).playTurn(
                      column: column,
                      row: row,
                    ),
        child: Container(
          decoration: _buildBoxDecoration(),
          child: CellGameValueWidget(
            color: winnerCell
                ? Colors.green
                : value == player1.symbol
                    ? player1.color
                    : player2.color,
            value: value,
          ),
        ),
      );
    });
  }
}
