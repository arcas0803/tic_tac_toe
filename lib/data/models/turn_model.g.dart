// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'turn_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TurnModel _$TurnModelFromJson(Map<String, dynamic> json) => TurnModel(
      currentPlayer:
          PlayerModel.fromJson(json['currentPlayer'] as Map<String, dynamic>),
      board: BoardModel.fromJson(json['board'] as Map<String, dynamic>),
      winner: json['winner'] == null
          ? null
          : PlayerModel.fromJson(json['winner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TurnModelToJson(TurnModel instance) => <String, dynamic>{
      'currentPlayer': instance.currentPlayer,
      'board': instance.board,
      'winner': instance.winner,
    };
