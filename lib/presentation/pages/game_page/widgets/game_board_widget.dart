import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/presentation/controllers/game_controller.dart';

import 'cell_game_widget.dart';

/// Create a widget that display the current board state.
/// The widget listen to the [GameController] sizes board to paint the structure of the board.
class GameBoardWidget extends ConsumerWidget {
  const GameBoardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final size = ref.watch(
      gameControllerProvider.select((value) => value.currentBoard.size),
    );

    return Column(
        children: List<Widget>.generate(size, (row) {
      return Expanded(
        child: Row(
          children: List<Widget>.generate(size, (cell) {
            if (row == size - 1 && cell == size - 1) {
              return Expanded(
                child: CellGameWidget(
                  column: cell,
                  row: row,
                ),
              );
            }
            if (cell == size - 1) {
              return Expanded(
                child: CellGameWidget(
                  column: cell,
                  row: row,
                  bottom: true,
                ),
              );
            }
            if (row == size - 1) {
              return Expanded(
                child: CellGameWidget(
                  column: cell,
                  row: row,
                  right: true,
                ),
              );
            }
            return Expanded(
              child: CellGameWidget(
                column: cell,
                row: row,
                bottom: true,
                right: true,
              ),
            );
          }),
        ),
      );
    }));
  }
}
