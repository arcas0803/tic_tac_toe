import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/presentation/app.dart';
import 'package:tic_tac_toe/presentation/controllers/games_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(ProviderScope(overrides: [
    prefsProvider.overrideWithValue(sharedPreferences),
  ], child: App()));
}
