import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/common/constants/id.dart';
import 'package:tic_tac_toe/domain/entities/game_entity.dart';
import 'package:tic_tac_toe/domain/entities/player_entity.dart';
import 'package:tic_tac_toe/locale/l10n.dart';
import 'package:tic_tac_toe/presentation/controllers/color_picker_controller.dart';
import 'package:tic_tac_toe/presentation/controllers/game_controller.dart';
import 'package:tic_tac_toe/presentation/controllers/player_controller.dart';
import 'package:tic_tac_toe/presentation/controllers/symbol_picker_controller.dart';
import 'package:tic_tac_toe/presentation/pages/config_page/widgets/color_picker_widget.dart';
import 'package:tic_tac_toe/presentation/pages/config_page/widgets/symbol_picker_widget.dart';
import 'package:tic_tac_toe/presentation/router/router.dart';
import 'package:tic_tac_toe/presentation/widgets/rounded_button_widget.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Text(
                S.of(context).settings_game,
                style: Theme.of(context).textTheme.headline1,
              )),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      final selected = ref.watch(symbolPickerControllerProvider
                          .select((value) => value.player1Symbol));
                      final color = ref.watch(
                          colorPickerControllerProvider(IdConstants.player1Id));

                      return SymbolPickerWidget(
                        value: selected,
                        color: color,
                        onTap: ref
                            .read(symbolPickerControllerProvider.notifier)
                            .changePlayer1Symbol,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Consumer(
                    builder: (context, ref, child) => TextFormField(
                      decoration: const InputDecoration(
                        labelText: IdConstants.player1Id,
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => ref
                          .read(playerNameControllerProvider(
                                  IdConstants.player1Id)
                              .notifier)
                          .state = value,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const ColorPickerWidget(id: IdConstants.player1Id),
                  const SizedBox(height: 20),
                  Consumer(
                    builder: (context, ref, child) {
                      final selected = ref.watch(symbolPickerControllerProvider
                          .select((value) => value.player2Symbol));
                      final color = ref.watch(
                          colorPickerControllerProvider(IdConstants.player2Id));

                      return SymbolPickerWidget(
                        value: selected,
                        color: color,
                        onTap: ref
                            .read(symbolPickerControllerProvider.notifier)
                            .changePlayer2Symbol,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Consumer(
                    builder: (context, ref, child) => TextFormField(
                      decoration: const InputDecoration(
                        labelText: IdConstants.player2Id,
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => ref
                          .read(playerNameControllerProvider(
                                  IdConstants.player2Id)
                              .notifier)
                          .state = value,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const ColorPickerWidget(
                    id: IdConstants.player2Id,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Consumer(
                builder: (context, ref, child) => RoundedButtonWidget(
                  onPressed: () {
                    final player1Symbol =
                        ref.read(symbolPickerControllerProvider).player1Symbol;
                    final player2Symbol =
                        ref.read(symbolPickerControllerProvider).player2Symbol;

                    final player1Name = ref
                        .read(
                            playerNameControllerProvider(IdConstants.player1Id)
                                .notifier)
                        .state;
                    final player2Name = ref
                        .read(
                            playerNameControllerProvider(IdConstants.player2Id)
                                .notifier)
                        .state;

                    final player1Color = ref
                        .read(
                            colorPickerControllerProvider(IdConstants.player1Id)
                                .notifier)
                        .state;
                    final player2Color = ref
                        .read(
                            colorPickerControllerProvider(IdConstants.player2Id)
                                .notifier)
                        .state;

                    final player1 = PlayerEntity(
                        name: player1Name.isEmpty
                            ? IdConstants.player1Id
                            : player1Name,
                        symbol: player1Symbol,
                        color: player1Color);
                    final player2 = PlayerEntity(
                        name: player2Name.isEmpty
                            ? IdConstants.player2Id
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
