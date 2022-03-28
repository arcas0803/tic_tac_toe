// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameModel _$GameModelFromJson(Map<String, dynamic> json) => GameModel(
      id: json['id'] as String,
      player1: PlayerModel.fromJson(json['player1'] as Map<String, dynamic>),
      player2: PlayerModel.fromJson(json['player2'] as Map<String, dynamic>),
      turns: (json['turns'] as List<dynamic>)
          .map((e) => TurnModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GameModelToJson(GameModel instance) => <String, dynamic>{
      'id': instance.id,
      'player1': instance.player1,
      'player2': instance.player2,
      'turns': instance.turns,
    };
