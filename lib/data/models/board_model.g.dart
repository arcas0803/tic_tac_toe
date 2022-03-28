// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardModel _$BoardModelFromJson(Map<String, dynamic> json) => BoardModel(
      board: (json['board'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => $enumDecode(_$SymbolPlayEnumMap, e))
              .toList())
          .toList(),
    );

Map<String, dynamic> _$BoardModelToJson(BoardModel instance) =>
    <String, dynamic>{
      'board': instance.board
          .map((e) => e.map((e) => _$SymbolPlayEnumMap[e]).toList())
          .toList(),
    };

const _$SymbolPlayEnumMap = {
  SymbolPlay.x: 'x',
  SymbolPlay.o: 'o',
  SymbolPlay.none: 'none',
};
