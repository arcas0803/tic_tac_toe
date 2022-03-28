import 'package:tic_tac_toe/domain/entities/game_entity.dart';
import 'package:tic_tac_toe/domain/entities/result.dart';
import 'package:tic_tac_toe/domain/use_cases/use_case.dart';

class StartGameUseCase implements UseCase<GameEntity, NoParams> {
  const StartGameUseCase();

  @override
  Result<GameEntity> call({required NoParams params}) {
    return Result.success(
      data: GameEntity.initial(),
    );
  }
}
