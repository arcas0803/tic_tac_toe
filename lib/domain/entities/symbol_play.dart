// Simbols for play the tic tac toe game.
enum SymbolPlay {
  x,
  o,
  none,
}

SymbolPlay symbolPlayFromString(String value) {
  switch (value) {
    case 'x':
      return SymbolPlay.x;
    case 'o':
      return SymbolPlay.o;
    default:
      return SymbolPlay.none;
  }
}

String symbolPlayToString(SymbolPlay value) {
  switch (value) {
    case SymbolPlay.x:
      return 'x';
    case SymbolPlay.o:
      return 'o';
    default:
      return '';
  }
}
