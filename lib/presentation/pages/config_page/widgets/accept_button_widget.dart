import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/common/constants/constants.dart';
import 'package:tic_tac_toe/domain/entities/game_entity.dart';
import 'package:tic_tac_toe/domain/entities/player_entity.dart';
import 'package:tic_tac_toe/locale/l10n.dart';
import 'package:tic_tac_toe/presentation/controllers/controllers.dart';
import 'package:tic_tac_toe/presentation/router/router.dart';
import 'package:tic_tac_toe/presentation/widgets/rounded_button_widget.dart';

class AcceptButtonWidget extends ConsumerWidget {
  const AcceptButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: RoundedButtonWidget(
        onPressed: () {
          final player1Symbol =
              ref.read(symbolPickerControllerProvider).player1Symbol;
          final player2Symbol =
              ref.read(symbolPickerControllerProvider).player2Symbol;

          final player1Name = ref
              .read(
                  playerNameControllerProvider(IdConstants.player1Id).notifier)
              .state;
          print(player1Name);
          final player2Name = ref
              .read(
                  playerNameControllerProvider(IdConstants.player2Id).notifier)
              .state;

          final player1Color = ref
              .read(
                  colorPickerControllerProvider(IdConstants.player1Id).notifier)
              .state;
          final player2Color = ref
              .read(
                  colorPickerControllerProvider(IdConstants.player2Id).notifier)
              .state;

          final player1 = PlayerEntity(
              name: player1Name.isEmpty
                  ? S.of(context).name_label_player_1
                  : player1Name,
              symbol: player1Symbol,
              color: player1Color);
          final player2 = PlayerEntity(
              name: player2Name.isEmpty
                  ? S.of(context).name_label_player_2
                  : player2Name,
              symbol: player2Symbol,
              color: player2Color);
          final game = GameEntity.withPlayers(
              player1: player1, player2: player2, size: 3);

          ref.read(gameParamStateProvider.notifier).state = game;

          context.replaceRoute(
            const GameRoute(),
          );
        },
        title: S.of(context).accept,
      ),
    );
  }
}
