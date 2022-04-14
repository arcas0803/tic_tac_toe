import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final colorPickerControllerProvider =
    StateProvider.autoDispose.family<Color, String>(
  // We return the default value.
  (ref, key) => Colors.red,
);
