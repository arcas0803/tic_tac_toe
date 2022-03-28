import 'package:tic_tac_toe/domain/entities/game_entity.dart';
import 'package:tic_tac_toe/domain/entities/result.dart';
import 'package:tic_tac_toe/domain/repositories/game_repository.dart';
import 'package:tic_tac_toe/domain/use_cases/use_case.dart';

class LoadGamesUseCase implements UseCaseFuture<List<GameEntity>, NoParams> {
  final GameRepository _repository;

  const LoadGamesUseCase({required GameRepository repository})
      : _repository = repository;

  @override
  Future<Result<List<GameEntity>>> call({required NoParams params}) async {
    return _repository.loadGames();
  }
}
