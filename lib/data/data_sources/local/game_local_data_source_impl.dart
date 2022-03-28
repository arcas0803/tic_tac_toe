import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/data/data_sources/local/game_local_data_source.dart';
import 'package:tic_tac_toe/data/models/game_model.dart';

class GameLocalDataSourceImpl implements GameLocalDataSource {
  final SharedPreferences _prefs;
  final String _key;

  GameLocalDataSourceImpl(
      {required SharedPreferences prefs, required String key})
      : _prefs = prefs,
        _key = key;

  @override
  Future<GameModel> loadGame({required String id}) {
    return loadGames().then((games) {
      final game = games.indexWhere(
        (game) => game.id == id,
      );
      if (game == -1) {
        throw Exception('Game not found');
      }
      return games[game];
    });
  }

  @override
  Future<List<GameModel>> loadGames() {
    return Future.value(_prefs.getStringList(_key)).then((List<String>? json) {
      if (json == null) {
        return [];
      }
      return json
          .map(
            (String json) => GameModel.fromJson(
              jsonDecode(json),
            ),
          )
          .toList();
    });
  }

  @override
  Future<void> saveGame({required GameModel game}) {
    return loadGames().then((List<GameModel> games) {
      games.add(game);
      _prefs.setStringList(
        _key,
        games.map((GameModel game) => jsonEncode((game).toJson())).toList(),
      );
    });
  }
}
