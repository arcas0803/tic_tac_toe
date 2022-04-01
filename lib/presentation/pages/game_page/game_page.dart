import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/domain/entities/player_entity.dart';
import 'package:tic_tac_toe/presentation/controllers/game_controller.dart';

import 'widgets/widgets.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer(builder: (context, ref, child) {
          ref.listen<PlayerEntity?>(
              gameControllerProvider.select((value) => value.winnerPlayer),
              (previous, next) {
            if (next != null) {
              showGeneralDialog(
                context: context,
                barrierDismissible: false,
                transitionDuration: const Duration(milliseconds: 300),
                transitionBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: animation,
                      child: child,
                    ),
                  );
                },
                pageBuilder: (context, animation, secondaryAnimation) =>
                    WinnerGameDialog(
                  onClose: () => Navigator.of(context).pop(),
                  onReplayGame: () {
                    ref.read(gameControllerProvider.notifier).restartGame();
                    Navigator.of(context).pop();
                  },
                  winner: next,
                ),
              );
            }
          });
          return Column(
            children: [
              const PlayersHeaderWidget(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Consumer(
                    builder: (context, ref, child) {
                      final board = ref.watch(
                        gameControllerProvider
                            .select((value) => value.turns.last.board),
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
          );
        }),
      ),
    );
  }
}
