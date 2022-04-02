import 'package:flutter_riverpod/flutter_riverpod.dart';

final playerNameControllerProvider = StateProvider.family<String, String>(
  (ref, key) => '',
);
