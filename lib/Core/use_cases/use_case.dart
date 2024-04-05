import 'package:dartz/dartz.dart';
import 'package:wheel_n_deal/Core/errors/failure.dart';

abstract class UseCase<Type, Param> {
  Future<Either<Failure, Type>> call([Param param]);
}

class NoParam {}
