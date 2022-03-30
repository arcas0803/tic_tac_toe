import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/domain/entities/symbol_play.dart';
import 'package:tic_tac_toe/presentation/controllers/game_controller.dart';

/// CellGameWidget represents a cell in the game board.
/// Each cell has a value and a position.
///
/// The position is used to determine the position of the cell in the game board.
///
/// The value is used to determine the symbol to be displayed in the cell.
/// There are three possible values:
/// - none: the cell is empty
/// - x: the cell is occupied by an x
/// - o: the cell is occupied by an o
///
/// The parameters [top], [right], [bottom], [left] are used to determine the lines
/// that are drawn around the cell.

class CellGameWidget extends StatelessWidget {
  /// Needs a top line.
  final bool top;

  /// Needs a bottom line.
  final bool bottom;

  /// Needs a left line.
  final bool left;

  /// Needs a right line.
  final bool right;

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
    return Consumer(builder: (context, ref, child) {
      // Watch if there is a winner. If there is, the cell should be disabled.
      final winner = ref.watch(
          gameControllerProvider.select((value) => value.currentTurn.winner));

      // Watch the actual value of the cell.
      final value = ref.watch(
        gameControllerProvider.select(
          (value) => value.currentTurn.board.board[column][row],
        ),
      );

      return GestureDetector(
        onTap: winner != null
            ? null
            // If a value has been set before, don't allow to change it.
            : value != SymbolPlay.none
                ? null
                : () => ref.read(gameControllerProvider.notifier).playTurn(
                      column: column,
                      row: row,
                    ),
        child: Container(
            decoration: _buildBoxDecoration(),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final _size = Size(constraints.maxWidth, constraints.maxHeight);
                switch (value) {
                  case SymbolPlay.none:
                    return const Center(child: SizedBox());
                  case SymbolPlay.x:
                    return XWidget(size: _size);
                  case SymbolPlay.o:
                    return CircleWidget(size: _size);
                  default:
                    return const SizedBox();
                }
              },
            )

            //CellWinner(value: symbolPlayToString(value)),
            ),
      );
    });
  }
}

class CircleWidget extends StatefulWidget {
  final Size size;

  const CircleWidget({Key? key, required this.size}) : super(key: key);

  @override
  _CircleState createState() => _CircleState();
}

class _CircleState extends State<CircleWidget>
    with SingleTickerProviderStateMixin {
  double _fraction = 0.0;
  late Animation<double> _animation;
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _fraction = _animation.value;
        });
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: CustomPaint(
          painter: CirclePainter(fraction: _fraction),
          child: const Center(
            child: SizedBox(),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CirclePainter extends CustomPainter {
  final double fraction;
  var _circlePaint;

  CirclePainter({required this.fraction}) {
    _circlePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    print(size);
    var rect = const Offset(0.0, 0.0) & size;

    canvas.drawArc(
        rect, -math.pi / 2, math.pi * 2 * fraction, false, _circlePaint);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return oldDelegate.fraction != fraction;
  }
}

class CellWinner extends HookWidget {
  final String value;

  const CellWinner({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _tickerProvider = useSingleTickerProvider();

    final _animationController = useAnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: _tickerProvider,
      reverseDuration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    final _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );

    return RotationTransition(
      turns: _animation,
      child: Center(
        child: Text(
          value,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

class XWidget extends StatefulWidget {
  final Size size;

  const XWidget({Key? key, required this.size}) : super(key: key);

  @override
  _XState createState() => _XState();
}

class _XState extends State<XWidget> with SingleTickerProviderStateMixin {
  double _fraction = 0.0;
  late Animation<double> _animation;
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _fraction = _animation.value;
        });
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: CustomPaint(
          painter: XPainter(fraction: _fraction),
          size: widget.size,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class XPainter extends CustomPainter {
  final double fraction;
  var _xPaint;

  XPainter({required this.fraction}) {
    _xPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    print(size);
    canvas.drawLine(const Offset(0, 0),
        Offset(size.width * fraction, size.height * fraction), _xPaint);
    canvas.drawLine(Offset(0, size.height),
        Offset(size.width * fraction, size.height * (1 - fraction)), _xPaint);
  }

  @override
  bool shouldRepaint(XPainter oldDelegate) {
    return oldDelegate.fraction != fraction;
  }
}
