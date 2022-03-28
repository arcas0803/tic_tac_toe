/// Mapper from entity to model and vice versa.
abstract class Mapper<T, E> {
  /// Converts [entity] to [model].
  E? toEntity({T? model});

  /// Converts [model] to [entity].
  T? toModel({E? entity});
}
