import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tic_tac_toe/domain/entities/symbol_play.dart';

part 'player_model.g.dart';

@JsonSerializable()
class PlayerModel {
  final String name;
  final SymbolPlay symbol;

  const PlayerModel({required this.name, required this.symbol});

  factory PlayerModel.fromJson(Map<String, dynamic> json) =>
      _$PlayerModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerModelToJson(this);
}
