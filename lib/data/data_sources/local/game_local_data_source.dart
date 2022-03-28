import 'package:tic_tac_toe/data/models/game_model.dart';

abstract class GameLocalDataSource {
  /// Load specific game from storage
  Future<GameModel> loadGame({required String id});

  /// Load all previous games from the storage.
  Future<List<GameModel>> loadGames();

  /// Save a new game to the storage.
  Future<void> saveGame({required GameModel game});
}
