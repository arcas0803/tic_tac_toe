import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/presentation/controllers/game_controller.dart';
import 'package:tic_tac_toe/presentation/widgets/row_game_widget.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 100,
                    child: Center(
                      child: Consumer(builder: (context, ref, child) {
                        final player1 = ref.watch(gameControllerProvider
                            .select((value) => value.player1));
                        final currentPlayer = ref.watch(
                          gameControllerProvider.select(
                              (value) => value.currentTurn.currentPlayer),
                        );

                        return Text(
                          player1.name,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: player1 == currentPlayer
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 100,
                    child: Center(
                      child: Consumer(builder: (context, ref, child) {
                        final player2 = ref.watch(gameControllerProvider
                            .select((value) => value.player2));
                        final currentPlayer = ref.watch(
                          gameControllerProvider.select(
                              (value) => value.currentTurn.currentPlayer),
                        );

                        return Text(
                          player2.name,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: player2 == currentPlayer
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
            Consumer(builder: ((context, ref, child) {
              final winner = ref.watch(gameControllerProvider
                  .select((value) => value.currentTurn.winner));

              return winner != null ? Text(winner.name) : const SizedBox();
            })),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Consumer(
                  builder: (context, ref, child) {
                    final board = ref.watch(
                      gameControllerProvider
                          .select((value) => value.turns.last.board),
                    );
                    final currentPLayer = ref.watch(
                      gameControllerProvider.select(
                          (value) => value.turns.last.currentPlayer.symbol),
                    );

                    return Column(
                      children: [
                        Expanded(
                          child: RowGameWidget(
                            rowPosition: RowPosition.top,
                            values: board.board[0],
                          ),
                        ),
                        Expanded(
                          child: RowGameWidget(
                            rowPosition: RowPosition.center,
                            values: board.board[1],
                          ),
                        ),
                        Expanded(
                          child: RowGameWidget(
                            rowPosition: RowPosition.bottom,
                            values: board.board[2],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
