import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/presentation/controllers/player_controller.dart';

class NamePickerWidget extends ConsumerWidget {
  final String id;
  final String label;
  const NamePickerWidget({
    Key? key,
    required this.id,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      onChanged: (value) =>
          ref.read(playerNameControllerProvider(id).notifier).state = value,
    );
  }
}
