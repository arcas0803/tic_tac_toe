import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/domain/entities/symbol_play.dart';

class PlayerEntity extends Equatable {
  final String name;
  final SymbolPlay symbol;
  final Color color;

  const PlayerEntity(
      {required this.name, required this.symbol, this.color = Colors.black});

  PlayerEntity copyWith({
    String? name,
    SymbolPlay? symbol,
  }) {
    return PlayerEntity(
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
    );
  }

  @override
  String toString() => 'PlayerEntity(name: $name, symbol: $symbol)';

  @override
  List<Object> get props => [name, symbol];
}
