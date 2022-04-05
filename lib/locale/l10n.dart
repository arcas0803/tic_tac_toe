// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Tic Tac Toe`
  String get game_name {
    return Intl.message(
      'Tic Tac Toe',
      name: 'game_name',
      desc: '',
      args: [],
    );
  }

  /// `Ajustes del juego`
  String get settings_game {
    return Intl.message(
      'Ajustes del juego',
      name: 'settings_game',
      desc: '',
      args: [],
    );
  }

  /// `Aceptar`
  String get accept {
    return Intl.message(
      'Aceptar',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Cancelar`
  String get cancel {
    return Intl.message(
      'Cancelar',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Deshacer`
  String get undo {
    return Intl.message(
      'Deshacer',
      name: 'undo',
      desc: '',
      args: [],
    );
  }

  /// `Reiniciar`
  String get reset {
    return Intl.message(
      'Reiniciar',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Tú eres el ganador {playerName}`
  String winner_message(Object playerName) {
    return Intl.message(
      'Tú eres el ganador $playerName',
      name: 'winner_message',
      desc: '',
      args: [playerName],
    );
  }

  /// `Nuevo juego`
  String get new_game {
    return Intl.message(
      'Nuevo juego',
      name: 'new_game',
      desc: '',
      args: [],
    );
  }

  /// `Cerrar`
  String get close {
    return Intl.message(
      'Cerrar',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Nombre del jugador 1`
  String get name_label_player_1 {
    return Intl.message(
      'Nombre del jugador 1',
      name: 'name_label_player_1',
      desc: '',
      args: [],
    );
  }

  /// `Nombre del jugador 2`
  String get name_label_player_2 {
    return Intl.message(
      'Nombre del jugador 2',
      name: 'name_label_player_2',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
