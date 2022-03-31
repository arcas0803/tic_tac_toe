// ignore_for_file: overridden_fields
import 'package:json_annotation/json_annotation.dart';
import 'package:tic_tac_toe/data/models/board_model.dart';
import 'package:tic_tac_toe/data/models/player_model.dart';

part 'turn_model.g.dart';

@JsonSerializable()
class TurnModel {
  final PlayerModel currentPlayer;

  final BoardModel board;

  final List<List<int>>? winnerCells;

  const TurnModel({
    required this.currentPlayer,
    required this.board,
    this.winnerCells,
  });

  factory TurnModel.fromJson(Map<String, dynamic> json) =>
      _$TurnModelFromJson(json);

  Map<String, dynamic> toJson() => _$TurnModelToJson(this);
}
