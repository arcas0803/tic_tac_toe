import 'package:flutter/material.dart';
import 'package:tic_tac_toe/domain/entities/symbol_play.dart';
import 'package:tic_tac_toe/presentation/pages/game_page/widgets/cell_game_widget.dart';

enum RowPosition { top, bottom, center }

class RowGameWidget extends StatelessWidget {
  final RowPosition rowPosition;
  final List<SymbolPlay> values;

  const RowGameWidget({
    Key? key,
    required this.rowPosition,
    required this.values,
  }) : super(key: key);

  Row _buildTopRow() {
    const row = 0;
    return Row(
      children: const [
        Expanded(
          child: CellGameWidget(
            right: true,
            column: 0,
            row: row,
          ),
        ),
        Expanded(
          child: CellGameWidget(
            right: true,
            column: 1,
            row: row,
          ),
        ),
        Expanded(
          child: CellGameWidget(
            column: 2,
            row: row,
          ),
        ),
      ],
    );
  }

  Row _buildCenterRow() {
    const row = 1;
    return Row(
      children: const [
        Expanded(
          child: CellGameWidget(
            right: true,
            top: true,
            bottom: true,
            column: 0,
            row: row,
          ),
        ),
        Expanded(
          child: CellGameWidget(
            right: true,
            top: true,
            bottom: true,
            column: 1,
            row: row,
          ),
        ),
        Expanded(
          child: CellGameWidget(
            top: true,
            bottom: true,
            column: 2,
            row: row,
          ),
        ),
      ],
    );
  }

  Row _buildBottomRow() {
    const row = 2;
    return Row(
      children: const [
        Expanded(
          child: CellGameWidget(
            right: true,
            column: 0,
            row: row,
          ),
        ),
        Expanded(
          child: CellGameWidget(
            right: true,
            column: 1,
            row: row,
          ),
        ),
        Expanded(
          child: CellGameWidget(
            column: 2,
            row: row,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (rowPosition) {
      case RowPosition.top:
        return _buildTopRow();
      case RowPosition.center:
        return _buildCenterRow();
      case RowPosition.bottom:
        return _buildBottomRow();
      default:
        return Container();
    }
  }
}
