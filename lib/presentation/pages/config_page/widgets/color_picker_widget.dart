import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/presentation/controllers/color_picker_controller.dart';

class ColorPickerWidget extends ConsumerWidget {
  final String id;

  const ColorPickerWidget({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final value = ref.watch(
      colorPickerControllerProvider(id),
    );

    return Row(
      children: [
        CircleSelectWidget(
          color: Colors.red,
          isSelected: value == Colors.red,
          onTap: () => ref
              .read(colorPickerControllerProvider(id).notifier)
              .state = Colors.red,
        ),
        const SizedBox(width: 10),
        CircleSelectWidget(
          color: Colors.blue,
          isSelected: value == Colors.blue,
          onTap: () => ref
              .read(colorPickerControllerProvider(id).notifier)
              .state = Colors.blue,
        ),
        const SizedBox(width: 10),
        CircleSelectWidget(
          color: Colors.green,
          isSelected: value == Colors.green,
          onTap: () => ref
              .read(colorPickerControllerProvider(id).notifier)
              .state = Colors.green,
        ),
        const SizedBox(width: 10),
        CircleSelectWidget(
          color: Colors.amber,
          isSelected: value == Colors.amber,
          onTap: () => ref
              .read(colorPickerControllerProvider(id).notifier)
              .state = Colors.amber,
        ),
        const SizedBox(width: 10),
        CircleSelectWidget(
          color: Colors.brown,
          isSelected: value == Colors.brown,
          onTap: () => ref
              .read(colorPickerControllerProvider(id).notifier)
              .state = Colors.brown,
        ),
      ],
    );
  }
}

class CircleSelectWidget extends StatelessWidget {
  final Color _color;
  final bool _isSelected;
  final void Function() _onTap;

  const CircleSelectWidget({
    Key? key,
    required Color color,
    bool isSelected = false,
    required void Function() onTap,
  })  : _color = color,
        _isSelected = isSelected,
        _onTap = onTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: _onTap,
        child: CustomPaint(
          painter: CirclePalleteColor(
            color: _color,
            isSelected: _isSelected,
          ),
          child: Container(
            height: 50,
          ),
        ),
      ),
    );
  }
}

class CirclePalleteColor extends CustomPainter {
  final Color _color;
  final bool _isSelected;

  CirclePalleteColor({
    required Color color,
    bool isSelected = false,
  })  : _color = color,
        _isSelected = isSelected;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 4, paint);
    final paintBorder = Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    if (_isSelected) {
      canvas.drawCircle(Offset(size.width / 2, size.height / 2),
          (size.width / 4), paintBorder);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
