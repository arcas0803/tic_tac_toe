import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/domain/entities/game_entity.dart';
import 'package:tic_tac_toe/domain/entities/result.dart';
import 'package:tic_tac_toe/domain/entities/turn_entity.dart';
import 'package:tic_tac_toe/domain/use_cases/save_game_use_case.dart';
import 'package:tic_tac_toe/domain/use_cases/use_case.dart';

class ReplayTurnParams extends Equatable {
  final GameEntity game;
  const ReplayTurnParams({
    required this.game,
  });

  ReplayTurnParams copyWith({
    GameEntity? game,
  }) {
    return ReplayTurnParams(
      game: game ?? this.game,
    );
  }

  @override
  String toString() => 'ReplayTurnParams(game: $game)';

  @override
  List<Object> get props => [game];
}

class ReplayTurnUseCase implements UseCaseFuture<GameEntity, ReplayTurnParams> {
  final SaveGameUseCase _saveGameUseCase;

  ReplayTurnUseCase({required SaveGameUseCase saveGameUseCase})
      : _saveGameUseCase = saveGameUseCase;

  @override
  Future<Result<GameEntity>> call({required ReplayTurnParams params}) async {
    final game = params.game;
    final turns = List<TurnEntity>.from(game.turns);
    turns.removeLast();
    final newGame = game.copyWith(
      turns: turns,
    );
    return _saveGameUseCase.call(params: SaveGameParams(game: newGame)).then(
          (value) => value.when(
            success: (game) => Result.success(data: newGame),
            failure: (error) => Result.failure(error: error),
          ),
        );
  }
}
