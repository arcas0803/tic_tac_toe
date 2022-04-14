import 'package:flutter_riverpod/flutter_riverpod.dart';

final playerNameControllerProvider =
    StateProvider.autoDispose.family<String, String>(
  (ref, key) => '',
);
