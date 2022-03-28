import 'package:tic_tac_toe/data/mappers/mapper.dart';
import 'package:tic_tac_toe/data/mappers/player_mapper.dart';
import 'package:tic_tac_toe/data/mappers/turn_mapper.dart';
import 'package:tic_tac_toe/data/models/game_model.dart';
import 'package:tic_tac_toe/domain/entities/game_entity.dart';

class GameMapper implements Mapper<GameModel, GameEntity> {
  @override
  GameEntity? toEntity({GameModel? model}) {
    if (model == null) return null;

    return GameEntity(
      id: model.id,
      player1: PlayerMapper().toEntity(model: model.player1)!,
      player2: PlayerMapper().toEntity(model: model.player2)!,
      turns: model.turns.map((e) => TurnMapper().toEntity(model: e)!).toList(),
    );
  }

  @override
  GameModel? toModel({GameEntity? entity}) {
    if (entity == null) return null;
    return GameModel(
      id: entity.id,
      player1: PlayerMapper().toModel(entity: entity.player1)!,
      player2: PlayerMapper().toModel(entity: entity.player2)!,
      turns: entity.turns.map((e) => TurnMapper().toModel(entity: e)!).toList(),
    );
  }
}
