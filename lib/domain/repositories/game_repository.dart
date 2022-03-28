import 'package:tic_tac_toe/domain/entities/game_entity.dart';
import 'package:tic_tac_toe/domain/entities/result.dart';

abstract class GameRepository {
  /// Load specific game from storage
  Future<Result<GameEntity>> loadGame({required String id});

  /// Load all previous games from the storage.
  Future<Result<List<GameEntity>>> loadGames();

  /// Save a new game to the storage.
  Future<Result<void>> saveGame({required GameEntity game});
}
