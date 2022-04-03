import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/presentation/controllers/game_controller.dart';
import 'package:tic_tac_toe/presentation/router/router.dart';
import 'package:tic_tac_toe/presentation/widgets/rounded_button_widget.dart';

class ControlsBottomWidget extends ConsumerWidget {
  const ControlsBottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        RoundedButtonWidget(
          title: 'ReDo',
          onPressed: () =>
              ref.read(gameControllerProvider.notifier).replayTurn(),
        ),
        RoundedButtonWidget(
          title: 'Replay',
          onPressed: () =>
              ref.read(gameControllerProvider.notifier).restartGame(),
        ),
        RoundedButtonWidget(
          title: 'Settings',
          onPressed: () => context.replaceRoute(
            const ConfigRoute(),
          ),
        ),
      ],
    );
  }
}
