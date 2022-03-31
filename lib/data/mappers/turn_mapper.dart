import 'package:tic_tac_toe/data/mappers/board_mapper.dart';
import 'package:tic_tac_toe/data/mappers/mapper.dart';
import 'package:tic_tac_toe/data/mappers/player_mapper.dart';
import 'package:tic_tac_toe/data/models/turn_model.dart';
import 'package:tic_tac_toe/domain/entities/turn_entity.dart';

class TurnMapper implements Mapper<TurnModel, TurnEntity> {
  @override
  TurnEntity? toEntity({TurnModel? model}) {
    if (model == null) return null;

    return TurnEntity(
      currentPlayer: PlayerMapper().toEntity(model: model.currentPlayer)!,
      board: BoardMapper().toEntity(model: model.board)!,
      winnerCells: model.winnerCells,
    );
  }

  @override
  TurnModel? toModel({TurnEntity? entity}) {
    if (entity == null) return null;

    return TurnModel(
      currentPlayer: PlayerMapper().toModel(entity: entity.currentPlayer)!,
      board: BoardMapper().toModel(entity: entity.board)!,
      winnerCells: entity.winnerCells,
    );
  }
}
