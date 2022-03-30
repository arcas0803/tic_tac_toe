import 'package:flutter/material.dart';
import 'package:tic_tac_toe/domain/entities/symbol_play.dart';
import 'package:tic_tac_toe/presentation/widgets/cell_game_widget.dart';

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
    const column = 0;
    return Row(
      children: const [
        Expanded(
          child: CellGameWidget(
            right: true,
            column: column,
            row: 0,
          ),
        ),
        Expanded(
          child: CellGameWidget(
            right: true,
            column: column,
            row: 1,
          ),
        ),
        Expanded(
          child: CellGameWidget(
            column: column,
            row: 2,
          ),
        ),
      ],
    );
  }

  Row _buildCenterRow() {
    const column = 1;
    return Row(
      children: const [
        Expanded(
          child: CellGameWidget(
            right: true,
            top: true,
            bottom: true,
            column: column,
            row: 0,
          ),
        ),
        Expanded(
          child: CellGameWidget(
            right: true,
            top: true,
            bottom: true,
            column: column,
            row: 1,
          ),
        ),
        Expanded(
          child: CellGameWidget(
            top: true,
            bottom: true,
            column: column,
            row: 2,
          ),
        ),
      ],
    );
  }

  Row _buildBottomRow() {
    const column = 2;
    return Row(
      children: const [
        Expanded(
          child: CellGameWidget(
            right: true,
            column: column,
            row: 0,
          ),
        ),
        Expanded(
          child: CellGameWidget(
            right: true,
            column: column,
            row: 1,
          ),
        ),
        Expanded(
          child: CellGameWidget(
            column: column,
            row: 2,
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
