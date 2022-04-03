import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/domain/entities/board_entity.dart';
import 'package:tic_tac_toe/domain/entities/game_entity.dart';
import 'package:tic_tac_toe/domain/entities/result.dart';
import 'package:tic_tac_toe/domain/entities/turn_entity.dart';
import 'package:tic_tac_toe/domain/use_cases/use_case.dart';

class StartGameParams extends Equatable {
  final GameEntity? gameEntity;
  const StartGameParams({
    this.gameEntity,
  });

  StartGameParams copyWith({
    GameEntity? gameEntity,
  }) {
    return StartGameParams(
      gameEntity: gameEntity ?? this.gameEntity,
    );
  }

  @override
  String toString() => 'StartGameParams(gameEntity: $gameEntity)';

  @override
  List<Object?> get props => [gameEntity];
}

class StartGameUseCase implements UseCase<GameEntity, StartGameParams> {
  const StartGameUseCase();

  @override
  Result<GameEntity> call({required StartGameParams params}) {
    if (params.gameEntity == null) {
      return Result.success(
        data: GameEntity.initial(),
      );
    }

    return Result.success(
        data: params.gameEntity!.copyWith(turns: [
      TurnEntity(
          currentPlayer: params.gameEntity!.player1,
          board: const BoardEntity.initial())
    ]));
  }
}
