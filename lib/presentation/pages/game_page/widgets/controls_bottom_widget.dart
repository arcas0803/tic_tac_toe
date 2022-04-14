import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tic_tac_toe/locale/l10n.dart';
import 'package:tic_tac_toe/presentation/controllers/game_controller.dart';
import 'package:tic_tac_toe/presentation/router/router.dart';
import 'package:tic_tac_toe/presentation/widgets/responsive_widget.dart';
import 'package:tic_tac_toe/presentation/widgets/rounded_button_widget.dart';

class ControlsBottomWidget extends ConsumerWidget {
  const ControlsBottomWidget({Key? key}) : super(key: key);

  Widget _buidlMobile({required List<Widget> widgets}) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (final widget in widgets)
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                child: widget,
              ),
            ),
        ],
      );

  Widget _buidlTablet({required List<Widget> widgets}) => Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: widgets,
        ),
      );

  Widget _buidlDesktop({required List<Widget> widgets}) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final widget in widgets)
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 5.h,
                ),
                child: widget,
              ),
            ),
        ],
      );

  @override
  Widget build(BuildContext context, ref) {
    final listButtons = [
      RoundedButtonWidget(
        title: S.of(context).undo,
        onPressed: () => ref.read(gameControllerProvider.notifier).replayTurn(),
      ),
      RoundedButtonWidget(
        title: S.of(context).reset,
        onPressed: () =>
            ref.read(gameControllerProvider.notifier).restartGame(),
      ),
      RoundedButtonWidget(
        title: S.of(context).settings_game,
        onPressed: () => context.replaceRoute(
          const ConfigRoute(),
        ),
      ),
    ];

    return ResponsiveWidget(
        mobile: _buidlMobile(widgets: listButtons),
        tablet: _buidlTablet(widgets: listButtons),
        desktop: _buidlDesktop(widgets: listButtons));
  }
}
