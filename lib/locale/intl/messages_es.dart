// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'es';

  static String m0(playerName) => "Tú eres el ganador ${playerName}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accept": MessageLookupByLibrary.simpleMessage("Aceptar"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "close": MessageLookupByLibrary.simpleMessage("Cerrar"),
        "game_name": MessageLookupByLibrary.simpleMessage("Tic Tac Toe"),
        "name_label_player_1":
            MessageLookupByLibrary.simpleMessage("Nombre del jugador 1"),
        "name_label_player_2":
            MessageLookupByLibrary.simpleMessage("Nombre del jugador 2"),
        "new_game": MessageLookupByLibrary.simpleMessage("Nuevo juego"),
        "reset": MessageLookupByLibrary.simpleMessage("Reiniciar"),
        "settings_game":
            MessageLookupByLibrary.simpleMessage("Ajustes del juego"),
        "undo": MessageLookupByLibrary.simpleMessage("Deshacer"),
        "winner_message": m0
      };
}
