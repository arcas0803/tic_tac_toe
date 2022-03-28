import 'package:tic_tac_toe/domain/entities/symbol_play.dart';

class Utils {
  static List<List<SymbolPlay?>> transpose(
      {required List<List<SymbolPlay?>> colsInRows}) {
    int nRows = colsInRows.length;
    if (colsInRows.isEmpty) return colsInRows;

    int nCols = colsInRows[0].length;
    if (nCols == 0) throw StateError('Degenerate matrix');

    // Init the transpose to make sure the size is right
    List<List<SymbolPlay?>> rowsInCols = List.filled(nCols, []);
    for (int col = 0; col < nCols; col++) {
      rowsInCols[col] = List.filled(nRows, null);
    }

    // Transpose
    for (int row = 0; row < nRows; row++) {
      for (int col = 0; col < nCols; col++) {
        rowsInCols[col][row] = colsInRows[row][col];
      }
    }
    return rowsInCols;
  }
}
