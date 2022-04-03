import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/domain/entities/game_entity.dart';
import 'package:tic_tac_toe/presentation/pages/config_page/config_page.dart';
import 'package:tic_tac_toe/presentation/pages/game_page/game_page.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: ConfigPage, initial: true),
    AutoRoute(page: GamePage),
  ],
)
class AppRouter extends _$AppRouter {}
