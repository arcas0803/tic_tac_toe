import 'package:tic_tac_toe/data/data_sources/local/game_local_data_source.dart';
import 'package:tic_tac_toe/data/mappers/game_mapper.dart';
import 'package:tic_tac_toe/domain/entities/game_entity.dart';
import 'package:tic_tac_toe/domain/entities/result.dart';
import 'package:tic_tac_toe/domain/repositories/game_repository.dart';

class GameRepositoryImpl implements GameRepository {
  final GameLocalDataSource _localDataSource;

  GameRepositoryImpl({required GameLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<Result<GameEntity>> loadGame({required String id}) {
    return Result.guardFuture(
      () => _localDataSource
          .loadGame(id: id)
          .then((value) => GameMapper().toEntity(model: value)!),
    );
  }

  @override
  Future<Result<List<GameEntity>>> loadGames() {
    return Result.guardFuture(
      () => _localDataSource.loadGames().then(
            (value) =>
                value.map((e) => GameMapper().toEntity(model: e)!).toList(),
          ),
    );
  }

  @override
  Future<Result<void>> saveGame({required GameEntity game}) {
    return Result.guardFuture(
      () =>
          _localDataSource.saveGame(game: GameMapper().toModel(entity: game)!),
    );
  }
}
