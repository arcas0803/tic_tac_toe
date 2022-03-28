import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/common/utils/app_constants.dart';
import 'package:tic_tac_toe/data/data_sources/local/game_local_data_source.dart';
import 'package:tic_tac_toe/data/data_sources/local/game_local_data_source_impl.dart';
import 'package:tic_tac_toe/data/repositories/game_repository_impl.dart';
import 'package:tic_tac_toe/domain/entities/game_entity.dart';
import 'package:tic_tac_toe/domain/repositories/game_repository.dart';
import 'package:tic_tac_toe/domain/use_cases/load_games_use_case.dart';
import 'package:tic_tac_toe/domain/use_cases/use_case.dart';

final prefsProvider =
    Provider<SharedPreferences>((_) => throw UnimplementedError());

final appConstatsProvider = Provider<AppConstants>(
  (_) => AppConstants(),
);

final gameLocalDataSourceProvider = Provider<GameLocalDataSource>((ref) {
  final sharedPreferences = ref.watch(prefsProvider);
  final appConstants = ref.watch(appConstatsProvider);
  return GameLocalDataSourceImpl(
    prefs: sharedPreferences,
    key: appConstants.gameKey,
  );
});

final gameRepositoryProvider = Provider<GameRepository>((ref) {
  final localDataSource = ref.watch(gameLocalDataSourceProvider);

  return GameRepositoryImpl(localDataSource: localDataSource);
});

final loadGamesUseCaseProvider = Provider<LoadGamesUseCase>((ref) {
  final repository = ref.watch(gameRepositoryProvider);
  return LoadGamesUseCase(repository: repository);
});

final getGamesProvider = FutureProvider<List<GameEntity>>((ref) async {
  final useCase = ref.watch(loadGamesUseCaseProvider);

  final result = await useCase.call(
    params: NoParams(),
  );

  return result.when(
    success: (games) => games,
    failure: (error) => throw error,
  );
});
