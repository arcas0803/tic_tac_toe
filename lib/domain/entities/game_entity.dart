import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/domain/entities/board_entity.dart';
import 'package:tic_tac_toe/domain/entities/cell_entity.dart';
import 'package:tic_tac_toe/domain/entities/player_entity.dart';
import 'package:tic_tac_toe/domain/entities/symbol_play.dart';
import 'package:tic_tac_toe/domain/entities/turn_entity.dart';
import 'package:uuid/uuid.dart';

/// Represents a tic tac toe game logic.
class GameEntity extends Equatable {
  // Id game
  final String id;
  // Player A
  final PlayerEntity player1;
  // Player B
  final PlayerEntity player2;
  // List of turns in the game
  final List<TurnEntity> turns;

  const GameEntity({
    required this.id,
    required this.player1,
    required this.player2,
    required this.turns,
  });

  /// Creates a game with the [player1] and [player2] names.
  /// The [player1] will be the first player.
  /// The board will be created with the size 3x3.
  GameEntity.initial({
    required String player1Name,
    required String player2Name,
  })  : id = const Uuid().v4(),
        player1 = PlayerEntity(
            name: player1Name, symbol: SymbolPlay.x, color: Colors.red),
        player2 = PlayerEntity(
            name: player2Name, symbol: SymbolPlay.o, color: Colors.amber),
        turns = [
          TurnEntity.initial(
            currentPlayer:
                PlayerEntity(name: player1Name, symbol: SymbolPlay.x),
          ),
        ];

  /// Creates a game with the [player1] and [player2] entities and [size] for the board.
  GameEntity.withPlayers({
    required this.player1,
    required this.player2,
    int size = 3,
  })  : id = const Uuid().v4(),
        turns = [
          TurnEntity.initial(currentPlayer: player1, size: size),
        ];

  /// Return current turn. Turn can not be empty.
  TurnEntity get currentTurn => turns.last;

  /// Return the current player.
  PlayerEntity get currentPlayer => currentTurn.currentPlayer;

  /// Return the current board.
  BoardEntity get currentBoard => currentTurn.board;

  /// Return null when no winner.
  PlayerEntity? get winnerPlayer => turns.last.winner;

  /// Return null when no winner. Else return the winner cells.
  List<CellEntity>? get winnerCells => turns.last.winnerCells;

  /// Defines if the turn can be replay.
  bool get canReplay => turns.length > 1;

  GameEntity copyWith({
    String? id,
    PlayerEntity? player1,
    PlayerEntity? player2,
    List<TurnEntity>? turns,
  }) {
    return GameEntity(
      id: id ?? this.id,
      player1: player1 ?? this.player1,
      player2: player2 ?? this.player2,
      turns: turns ?? this.turns,
    );
  }

  @override
  String toString() {
    return 'GameEntity(id: $id, player1: $player1, player2: $player2, turns: $turns)';
  }

  @override
  List<Object> get props => [id, player1, player2, turns];
}
