import 'package:tic_tac_toe/data/mappers/mapper.dart';
import 'package:tic_tac_toe/data/models/player_model.dart';
import 'package:tic_tac_toe/domain/entities/player_entity.dart';

class PlayerMapper implements Mapper<PlayerModel, PlayerEntity> {
  @override
  PlayerEntity? toEntity({PlayerModel? model}) {
    if (model == null) return null;

    return PlayerEntity(
      name: model.name,
      symbol: model.symbol,
    );
  }

  @override
  PlayerModel? toModel({PlayerEntity? entity}) {
    if (entity == null) return null;

    return PlayerModel(
      name: entity.name,
      symbol: entity.symbol,
    );
  }
}
