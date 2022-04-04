import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/domain/entities/symbol_play.dart';

/// Represents a tic tac toe cell on the board
class CellEntity extends Equatable {
  /// Column of the cell on the board
  final int column;

  /// Row of the cell on the board
  final int row;

  /// Symbol of the cell
  final SymbolPlay value;
  const CellEntity({
    required this.column,
    required this.row,
    required this.value,
  });

  /// Creates a new cell entity with the [none] symbol
  const CellEntity.initial({
    required this.column,
    required this.row,
  }) : value = SymbolPlay.none;

  CellEntity copyWith({
    int? column,
    int? row,
    SymbolPlay? value,
  }) {
    return CellEntity(
      column: column ?? this.column,
      row: row ?? this.row,
      value: value ?? this.value,
    );
  }

  @override
  String toString() => 'CellEntity(column: $column, row: $row, value: $value)';

  @override
  List<Object> get props => [column, row, value];
}
