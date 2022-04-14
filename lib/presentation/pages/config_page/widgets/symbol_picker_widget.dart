import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/common/constants/id.dart';
import 'package:tic_tac_toe/domain/entities/symbol_play.dart';
import 'package:tic_tac_toe/presentation/controllers/color_picker_controller.dart';
import 'package:tic_tac_toe/presentation/controllers/symbol_picker_controller.dart';

class SymbolPickerWidget extends ConsumerWidget {
  final String id;

  const SymbolPickerWidget({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final selected = ref.watch(
      symbolPickerControllerProvider.select(
        (value) {
          if (id == IdConstants.player1Id) {
            return value.player1Symbol;
          }
          return value.player2Symbol;
        },
      ),
    );

    final color = ref.watch(
      colorPickerControllerProvider(id),
    );

    return Row(
      children: [
        Expanded(
          child: Center(
            child: GestureDetector(
              onTap: id == IdConstants.player1Id
                  ? () => ref
                      .read(symbolPickerControllerProvider.notifier)
                      .changePlayer1Symbol(symbolPlay: SymbolPlay.x)
                  : () => ref
                      .read(symbolPickerControllerProvider.notifier)
                      .changePlayer2Symbol(symbolPlay: SymbolPlay.x),
              child: CustomPaint(
                painter: CrossPainter(
                    color: selected == SymbolPlay.x ? color : Colors.black),
                child: const SizedBox(height: 50, width: 50),
              ),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: GestureDetector(
              onTap: id == IdConstants.player1Id
                  ? () => ref
                      .read(symbolPickerControllerProvider.notifier)
                      .changePlayer1Symbol(symbolPlay: SymbolPlay.o)
                  : () => ref
                      .read(symbolPickerControllerProvider.notifier)
                      .changePlayer2Symbol(symbolPlay: SymbolPlay.o),
              child: CustomPaint(
                painter: CirclePainter(
                    color: selected == SymbolPlay.o ? color : Colors.black),
                child: const SizedBox(height: 50, width: 50),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CrossPainter extends CustomPainter {
  final Color color;

  CrossPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(const Offset(0, 0), Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(0, size.height), Offset(size.width, 0), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CirclePainter extends CustomPainter {
  final Color color;

  CirclePainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
