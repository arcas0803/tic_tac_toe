import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/domain/entities/result.dart';

abstract class UseCaseFuture<Type, Params> {
  Future<Result<Type>> call({required Params params});
}

abstract class UseCaseStream<Type, Params> {
  Stream<Result<Type>> call({required Params params});
}

abstract class UseCase<Type, Params> {
  Result<Type> call({required Params params});
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
