import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/domain/entities/player_entity.dart';
import 'package:tic_tac_toe/domain/entities/symbol_play.dart';
import 'package:tic_tac_toe/domain/entities/turn_entity.dart';
import 'package:uuid/uuid.dart';

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

  GameEntity.initial()
      : id = const Uuid().v4(),
        player1 = const PlayerEntity(name: 'Player 1', symbol: SymbolPlay.x),
        player2 = const PlayerEntity(name: 'Player 2', symbol: SymbolPlay.o),
        turns = const [
          TurnEntity.initial(
              currentPlayer:
                  PlayerEntity(name: 'Player 1', symbol: SymbolPlay.x))
        ];

  /// Return null if there are not turns.
  TurnEntity get currentTurn => turns.last;

  /// Return null when no winner.
  PlayerEntity? get winnerPlayer => turns.isEmpty ? null : turns.last.winner;

  /// Get player from symbol.
  PlayerEntity getPlayerFromSymbol({required SymbolPlay symbol}) {
    if (symbol == player1.symbol) {
      return player1;
    } else if (symbol == player2.symbol) {
      return player2;
    } else {
      throw Exception('Invalid symbol');
    }
  }

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
