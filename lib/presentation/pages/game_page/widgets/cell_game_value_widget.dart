import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:tic_tac_toe/domain/entities/symbol_play.dart';

/// Represents the value of the cell.
/// This widget is used to display the value of the cell with animations.
class CellGameValueWidget extends StatelessWidget {
  /// Actual value of the cell.
  final SymbolPlay value;

  /// Color of the value.
  final Color color;

  const CellGameValueWidget({
    Key? key,
    required this.value,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
          child:
              // If the value is none, then return  empty cell.
              // If not, paint the symbol with animation and color.
              value == SymbolPlay.none
                  ? const CellGameEmptyWidget()
                  : CellGameSymbolWidget(value: value, color: color)),
    );
  }
}

/// Class to paint the symbol with animation and color.
class CellGameSymbolWidget extends HookWidget {
  // Actual value of the cell.
  final SymbolPlay _value;
  // Color of the value.
  final Color _color;

  const CellGameSymbolWidget(
      {Key? key, required Color color, required SymbolPlay value})
      : _color = color,
        _value = value,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initial state
    final _fraction = useState(0.0);
    // Ticker provider for animation
    final _tickerProvider = useSingleTickerProvider();
    // Set a controller
    final _animationController = useAnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: _tickerProvider); // Define animation
    final _animation =
        useAnimation(Tween(begin: 0.0, end: 1.0).animate(_animationController));

    // Set state to update the animation
    _fraction.value = _animation;
    // execute animation
    _animationController.forward();

    return CustomPaint(
      painter: _value == SymbolPlay.x
          // If the value is X, then paint X with animation and color.
          ? CellXPainter(
              color: _color,
              fraction: _fraction.value,
            )
          // If the value is O, then paint O with animation and color.
          : CellCirclePainter(
              color: _color,
              fraction: _fraction.value,
            ),
      // Use the size of this widget to encapsulate the painter with no need of parent size.
      child: const Center(
        child: SizedBox(),
      ),
    );
  }
}

/// Painter for o.
class CellCirclePainter extends CustomPainter {
  // Used to update animation painter.
  final double fraction;
  // Color of the painter
  final Color color;
  Paint? _circlePaint;

  CellCirclePainter({required this.fraction, required this.color}) {
    _circlePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var rect = const Offset(0.0, 0.0) & size;

    canvas.drawArc(
        rect, -math.pi / 2, math.pi * 2 * fraction, false, _circlePaint!);
  }

  @override
  bool shouldRepaint(CellCirclePainter oldDelegate) {
    return oldDelegate.fraction != fraction;
  }
}

/// Painter for x.
class CellXPainter extends CustomPainter {
  // Used to update animation painter.
  final double fraction;
  // Color of the painter.
  final Color color;
  Paint? _xPaint;

  CellXPainter({required this.fraction, required this.color}) {
    _xPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Draw diagonal line.
    canvas.drawLine(const Offset(0, 0),
        Offset(size.width * fraction, size.height * fraction), _xPaint!);
    // Draw reverse diagonal line.
    canvas.drawLine(Offset(0, size.height),
        Offset(size.width * fraction, size.height * (1 - fraction)), _xPaint!);
  }

  @override
  bool shouldRepaint(CellXPainter oldDelegate) {
    return oldDelegate.fraction != fraction;
  }
}

/// Painter for empty cell.
/// It's just a size box but for clarity is encapsulated in a new widget.
class CellGameEmptyWidget extends StatelessWidget {
  const CellGameEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
