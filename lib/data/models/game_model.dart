// ignore_for_file: overridden_fields

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tic_tac_toe/data/models/player_model.dart';
import 'package:tic_tac_toe/data/models/turn_model.dart';

part 'game_model.g.dart';

@JsonSerializable()
class GameModel {
  final String id;
  final PlayerModel player1;
  final PlayerModel player2;
  final List<TurnModel> turns;
  const GameModel(
      {required this.id,
      required this.player1,
      required this.player2,
      required this.turns});

  factory GameModel.fromJson(Map<String, dynamic> json) =>
      _$GameModelFromJson(json);

  Map<String, dynamic> toJson() => _$GameModelToJson(this);
}
