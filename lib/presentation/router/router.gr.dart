// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    ConfigRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const ConfigPage());
    },
    GameRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const GamePage());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(ConfigRoute.name, path: '/'),
        RouteConfig(GameRoute.name, path: '/game-page')
      ];
}

/// generated route for
/// [ConfigPage]
class ConfigRoute extends PageRouteInfo<void> {
  const ConfigRoute() : super(ConfigRoute.name, path: '/');

  static const String name = 'ConfigRoute';
}

/// generated route for
/// [GamePage]
class GameRoute extends PageRouteInfo<void> {
  const GameRoute() : super(GameRoute.name, path: '/game-page');

  static const String name = 'GameRoute';
}
