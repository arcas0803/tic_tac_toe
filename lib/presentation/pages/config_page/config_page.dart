import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/presentation/controllers/color_picker_controller.dart';
import 'package:tic_tac_toe/presentation/controllers/player_controller.dart';
import 'package:tic_tac_toe/presentation/pages/config_page/widgets/color_picker_widget.dart';

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
                'Ajustes',
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
                    builder: (context, ref, child) => TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Player 1',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => ref
                          .read(
                              playerNameControllerProvider('player 1').notifier)
                          .state = value,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const ColorPickerWidget(id: 'player1'),
                  const SizedBox(height: 20),
                  Consumer(
                    builder: (context, ref, child) => TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Player 2',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => ref
                          .read(
                              playerNameControllerProvider('player 2').notifier)
                          .state = value,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const ColorPickerWidget(
                    id: 'player 2',
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
                builder: (context, ref, child) => OutlinedButton(
                  onPressed: () {
                    final player1Name = ref
                        .read(playerNameControllerProvider('player 1').notifier)
                        .state;
                    final player2Name = ref
                        .read(playerNameControllerProvider('player 2').notifier)
                        .state;

                    final player1Color = ref
                        .read(
                            colorPickerControllerProvider('player 1').notifier)
                        .state;
                    final player2Color = ref
                        .read(
                            colorPickerControllerProvider('player 2').notifier)
                        .state;
                    print(player1Name);
                    print(player2Name);
                    print(player1Color);
                    print(player2Color);
                    //final player1 = PlayerEntity(name: player1Name, symbol: symbol, color: player1Color);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Accept",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
