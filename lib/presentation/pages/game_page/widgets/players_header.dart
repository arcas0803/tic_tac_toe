import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/presentation/controllers/game_controller.dart';

class PlayersHeaderWidget extends StatelessWidget {
  const PlayersHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 100,
            child: Center(
              child: Consumer(builder: (context, ref, child) {
                final player1 = ref.watch(
                    gameControllerProvider.select((value) => value.player1));
                final currentPlayer = ref.watch(
                  gameControllerProvider
                      .select((value) => value.currentTurn.currentPlayer),
                );
                final winnerPlayer = ref.watch(
                  gameControllerProvider
                      .select((value) => value.currentTurn.winner),
                );

                return Text(
                  player1.name,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: player1 == currentPlayer
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: winnerPlayer != null
                        ? winnerPlayer == player1
                            ? Colors.green
                            : Colors.red
                        : Colors.black,
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
                final player2 = ref.watch(
                    gameControllerProvider.select((value) => value.player2));
                final currentPlayer = ref.watch(
                  gameControllerProvider
                      .select((value) => value.currentTurn.currentPlayer),
                );

                final winnerPlayer = ref.watch(
                  gameControllerProvider
                      .select((value) => value.currentTurn.winner),
                );

                return Text(
                  player2.name,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: player2 == currentPlayer
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: winnerPlayer != null
                        ? winnerPlayer == player2
                            ? Colors.green
                            : Colors.red
                        : Colors.black,
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
