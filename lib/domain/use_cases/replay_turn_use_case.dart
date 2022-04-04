import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/domain/entities/app_error.dart';
import 'package:tic_tac_toe/domain/entities/game_entity.dart';
import 'package:tic_tac_toe/domain/entities/result.dart';
import 'package:tic_tac_toe/domain/entities/turn_entity.dart';
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

class ReplayTurnUseCase implements UseCase<GameEntity, ReplayTurnParams> {
  ReplayTurnUseCase();

  @override
  Result<GameEntity> call({required ReplayTurnParams params}) {
    try {
      final game = params.game;
      final turns = List<TurnEntity>.from(game.turns);
      turns.removeLast();
      final newGame = game.copyWith(
        turns: turns,
      );

      return Result.success(data: newGame);
    } catch (e) {
      return Result.failure(
        error: AppError(error: e as Exception),
      );
    }
  }
}
