import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/domain/entities/symbol_play.dart';

class SymbolPickerWidget extends StatelessWidget {
  final SymbolPlay _value;
  final Color _color;
  final void Function({required SymbolPlay symbolPlay}) _onTap;

  const SymbolPickerWidget({
    Key? key,
    required SymbolPlay value,
    required Color color,
    required void Function({required SymbolPlay symbolPlay}) onTap,
  })  : _value = value,
        _color = color,
        _onTap = onTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return Row(
        children: [
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: () => _onTap(symbolPlay: SymbolPlay.x),
                child: CustomPaint(
                  painter: CrossPainter(
                      color: _value == SymbolPlay.x ? _color : Colors.black),
                  child: const SizedBox(height: 50, width: 50),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: () => _onTap(symbolPlay: SymbolPlay.o),
                child: CustomPaint(
                  painter: CirclePainter(
                      color: _value == SymbolPlay.o ? _color : Colors.black),
                  child: const SizedBox(height: 50, width: 50),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class CrossPainter extends CustomPainter {
  final Color _color;

  CrossPainter({required Color color}) : _color = color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _color
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
  final Color _color;

  CirclePainter({
    required Color color,
  }) : _color = color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _color
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
