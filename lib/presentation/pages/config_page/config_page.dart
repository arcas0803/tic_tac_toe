import 'package:flutter/material.dart';
import 'package:tic_tac_toe/common/constants/id.dart';
import 'package:tic_tac_toe/locale/l10n.dart';
import 'package:tic_tac_toe/presentation/pages/config_page/widgets/widgets.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                S.of(context).settings_game,
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                      child: SymbolPickerWidget(
                    id: IdConstants.player1Id,
                  )),
                  const SizedBox(height: 20),
                  Expanded(
                    child: NamePickerWidget(
                      id: IdConstants.player1Id,
                      label: S.of(context).name_label_player_1,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Expanded(
                    child: ColorPickerWidget(id: IdConstants.player1Id),
                  ),
                  const SizedBox(height: 20),
                  const Expanded(
                      child: SymbolPickerWidget(
                    id: IdConstants.player2Id,
                  )),
                  const SizedBox(height: 20),
                  Expanded(
                    child: NamePickerWidget(
                      id: IdConstants.player2Id,
                      label: S.of(context).name_label_player_2,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Expanded(
                    child: ColorPickerWidget(
                      id: IdConstants.player2Id,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: AcceptButtonWidget(),
          ),
        ],
      ),
    );
  }
}
