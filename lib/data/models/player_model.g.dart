// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlayerModel _$PlayerModelFromJson(Map<String, dynamic> json) => PlayerModel(
      name: json['name'] as String,
      symbol: $enumDecode(_$SymbolPlayEnumMap, json['symbol']),
    );

Map<String, dynamic> _$PlayerModelToJson(PlayerModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'symbol': _$SymbolPlayEnumMap[instance.symbol],
    };

const _$SymbolPlayEnumMap = {
  SymbolPlay.x: 'x',
  SymbolPlay.o: 'o',
  SymbolPlay.none: 'none',
};
