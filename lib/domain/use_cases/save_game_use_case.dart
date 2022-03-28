import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/domain/entities/game_entity.dart';
import 'package:tic_tac_toe/domain/entities/result.dart';
import 'package:tic_tac_toe/domain/repositories/game_repository.dart';
import 'package:tic_tac_toe/domain/use_cases/use_case.dart';

class SaveGameParams extends Equatable {
  final GameEntity game;
  const SaveGameParams({
    required this.game,
  });

  SaveGameParams copyWith({
    GameEntity? game,
  }) {
    return SaveGameParams(
      game: game ?? this.game,
    );
  }

  @override
  String toString() => 'SaveGameParams(game: $game)';

  @override
  List<Object> get props => [game];
}

class SaveGameUseCase implements UseCaseFuture<void, SaveGameParams> {
  final GameRepository _repository;

  const SaveGameUseCase({required GameRepository repository})
      : _repository = repository;

  @override
  Future<Result<void>> call({required SaveGameParams params}) {
    return _repository.saveGame(game: params.game);
  }
}
