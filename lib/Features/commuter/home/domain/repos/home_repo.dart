// Here, this is abstract as in thic class I will determine what will happen, but without determining how that will happen.
import 'package:dartz/dartz.dart';
import 'package:wheel_n_deal/Core/errors/failure.dart';
import 'package:wheel_n_deal/Features/commuter/home/domain/entities/message_entity.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<MessageEntity>>> fetchFeauredBooks();
  Future<Either<Failure, List<MessageEntity>>> fetchNewewstBooks();
}
