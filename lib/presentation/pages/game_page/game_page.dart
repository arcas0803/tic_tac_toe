import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tic_tac_toe/domain/entities/player_entity.dart';
import 'package:tic_tac_toe/presentation/controllers/game_controller.dart';
import 'package:tic_tac_toe/presentation/pages/game_page/widgets/controls_bottom_widget.dart';
import 'package:tic_tac_toe/presentation/pages/game_page/widgets/game_board_widget.dart';
import 'package:tic_tac_toe/presentation/widgets/responsive_widget.dart';

import 'widgets/widgets.dart';

class GamePage extends StatelessWidget {
  const GamePage({
    Key? key,
  }) : super(key: key);

  Widget _buildMobile(
          {required Widget header,
          required Widget body,
          required Widget bottom}) =>
      Column(
        children: [
          Expanded(
            flex: 1,
            child: header,
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
                horizontal: 10.w,
              ),
              child: body,
            ),
          ),
          Expanded(
            flex: 2,
            child: bottom,
          ),
        ],
      );
  Widget _buildTablet(
          {required Widget header,
          required Widget body,
          required Widget bottom}) =>
      Column(
        children: [
          Expanded(
            flex: 1,
            child: header,
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
                horizontal: 10.w,
              ),
              child: body,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: bottom,
            ),
          ),
        ],
      );
  Widget _buildDesktop(
          {required Widget header,
          required Widget body,
          required Widget bottom}) =>
      Column(
        children: [
          header,
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: bottom,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.0.h,
                      vertical: 20.0.h,
                    ),
                    child: Center(child: body),
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    const header = PlayersHeaderWidget();
    const body = AspectRatio(
      aspectRatio: 1,
      child: GameBoardWidget(),
    );
    const bottom = ControlsBottomWidget();
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
          return ResponsiveWidget(
            mobile: _buildMobile(header: header, body: body, bottom: bottom),
            tablet: _buildTablet(header: header, body: body, bottom: bottom),
            desktop: _buildDesktop(header: header, body: body, bottom: bottom),
          );
        }),
      ),
    );
  }
}
