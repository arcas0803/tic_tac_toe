import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tic_tac_toe/common/constants/id.dart';
import 'package:tic_tac_toe/locale/l10n.dart';
import 'package:tic_tac_toe/presentation/pages/config_page/widgets/widgets.dart';
import 'package:tic_tac_toe/presentation/widgets/responsive_widget.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({Key? key}) : super(key: key);

  Widget _buildBody({required BuildContext context}) {
    return Column(
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
    );
  }

  Widget _buildMobile({required Widget body}) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20), child: body);
  }

  Widget _buildTablet({required Widget body}) {
    return Row(
      children: [
        const Spacer(),
        Expanded(
          flex: 8,
          child: body,
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildDesktop({required Widget body}) {
    return Row(
      children: [
        const Spacer(
          flex: 2,
        ),
        Expanded(
          flex: 5,
          child: body,
        ),
        const Spacer(
          flex: 2,
        ),
      ],
    );
  }

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
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: ResponsiveWidget(
              mobile: _buildMobile(body: _buildBody(context: context)),
              tablet: _buildTablet(
                body: _buildBody(context: context),
              ),
              desktop: _buildDesktop(
                body: _buildBody(context: context),
              ),
            ),
          ),
          const Expanded(
            flex: 1,
            child: Center(child: AcceptButtonWidget()),
          ),
        ],
      ),
    );
  }
}
