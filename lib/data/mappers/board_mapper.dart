import 'package:tic_tac_toe/data/mappers/mapper.dart';
import 'package:tic_tac_toe/data/models/board_model.dart';
import 'package:tic_tac_toe/domain/entities/board_entity.dart';

class BoardMapper implements Mapper<BoardModel, BoardEntity> {
  @override
  BoardEntity? toEntity({BoardModel? model}) {
    if (model == null) return null;
    return BoardEntity(
      board: model.board,
    );
  }

  @override
  BoardModel? toModel({BoardEntity? entity}) {
    if (entity == null) return null;
    return BoardModel(
      board: entity.board,
    );
  }
}
