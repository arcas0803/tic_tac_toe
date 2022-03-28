import 'package:json_annotation/json_annotation.dart';
import 'package:tic_tac_toe/domain/entities/symbol_play.dart';

part 'board_model.g.dart';

@JsonSerializable()
class BoardModel {
  final List<List<SymbolPlay>> board;

  const BoardModel({required this.board});

  factory BoardModel.fromJson(Map<String, dynamic> json) =>
      _$BoardModelFromJson(json);

  Map<String, dynamic> toJson() => _$BoardModelToJson(this);
}
