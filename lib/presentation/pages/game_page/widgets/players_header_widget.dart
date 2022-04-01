import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/presentation/controllers/game_controller.dart';

class PlayersHeaderWidget extends StatelessWidget {
  const PlayersHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PlayerBoxWidget(
          child: Consumer(
            builder: (context, ref, child) {
              final player = ref.watch(
                  gameControllerProvider.select((value) => value.player1));

              final isCurrentPlayer = ref.watch(
                gameControllerProvider
                    .select((value) => value.currentPlayer == value.player1),
              );

              final isWinnerPlayer = ref.watch(
                gameControllerProvider
                    .select((value) => value.player1 == value.winnerPlayer),
              );

              return PlayerNameWidget(
                name: player.name,
                color: isWinnerPlayer ? Colors.deepPurple : player.color,
                isCurrentPlayer: isCurrentPlayer,
                isWinner: isWinnerPlayer,
              );
            },
          ),
        ),
        const ReplayWidget(),
        PlayerBoxWidget(
          child: Consumer(
            builder: (context, ref, child) {
              final player = ref.watch(
                  gameControllerProvider.select((value) => value.player2));

              final isCurrentPlayer = ref.watch(
                gameControllerProvider
                    .select((value) => value.currentPlayer == value.player2),
              );

              final isWinnerPlayer = ref.watch(
                gameControllerProvider
                    .select((value) => value.winnerPlayer == value.player2),
              );

              return PlayerNameWidget(
                name: player.name,
                color: isWinnerPlayer ? Colors.deepPurple : player.color,
                isCurrentPlayer: isCurrentPlayer,
                isWinner: isWinnerPlayer,
              );
            },
          ),
        ),
      ],
    );
  }
}

class PlayerBoxWidget extends StatelessWidget {
  final Widget child;
  const PlayerBoxWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: SizedBox(
        height: 100,
        child: Center(child: child),
      ),
    );
  }
}

class ReplayWidget extends ConsumerWidget {
  const ReplayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final canReplay =
        ref.watch(gameControllerProvider.select((value) => value.canReplay));
    return Expanded(
      flex: 2,
      child: IconButton(
        onPressed: canReplay
            ? () => ref.read(gameControllerProvider.notifier).replayTurn()
            : null,
        icon: const Icon(Icons.replay),
      ),
    );
  }
}

class PlayerNameWidget extends StatelessWidget {
  final String name;
  final Color color;
  final bool isCurrentPlayer;
  final bool isWinner;
  const PlayerNameWidget({
    Key? key,
    required this.name,
    required this.color,
    required this.isCurrentPlayer,
    required this.isWinner,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedDefaultTextStyle(
      style: TextStyle(
        color: isWinner ? Colors.deepPurple : color,
        fontSize: isCurrentPlayer ? 40 : 20,
        fontWeight: isCurrentPlayer ? FontWeight.bold : FontWeight.normal,
      ),
      duration: const Duration(milliseconds: 500),
      child: Text(
        isWinner ? '👑 $name' : name,
      ),
    );
  }
}
