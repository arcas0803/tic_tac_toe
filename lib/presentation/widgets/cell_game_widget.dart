import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/domain/entities/symbol_play.dart';
import 'package:tic_tac_toe/presentation/controllers/game_controller.dart';

class CellGameWidget extends StatelessWidget {
  final bool top;
  final bool bottom;
  final bool left;
  final bool right;
  final SymbolPlay value;
  final int row;
  final int column;

  const CellGameWidget({
    Key? key,
    this.top = false,
    this.bottom = false,
    this.left = false,
    this.right = false,
    required this.column,
    required this.row,
    required this.value,
  }) : super(key: key);

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      border: Border(
        top: top
            ? const BorderSide(color: Colors.black, width: 2)
            : BorderSide.none,
        bottom: bottom
            ? const BorderSide(color: Colors.black, width: 2)
            : BorderSide.none,
        left: left
            ? const BorderSide(color: Colors.black, width: 2)
            : BorderSide.none,
        right: right
            ? const BorderSide(color: Colors.black, width: 2)
            : BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) => GestureDetector(
        onTap: () => ref.read(gameControllerProvider.notifier).playTurn(
              column: column,
              row: row,
            ),
        child: Container(
          decoration: _buildBoxDecoration(),
          child: Center(
            child: Text(symbolPlayToString(value)),
          ),
        ),
      ),
    );
  }
}
