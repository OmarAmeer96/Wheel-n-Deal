import 'package:dartz/dartz.dart';
import 'package:wheel_n_deal/Core/errors/failure.dart';
import 'package:wheel_n_deal/Core/use_cases/use_case.dart';
import 'package:wheel_n_deal/Features/commuter/home/domain/entities/message_entity.dart';
import 'package:wheel_n_deal/Features/commuter/home/domain/repos/home_repo.dart';

class ReceiveMessageUseCase extends UseCase<List<MessageEntity>, NoParam> {
  final HomeRepo homeRepo;

  ReceiveMessageUseCase({required this.homeRepo});
  @override
  Future<Either<Failure, List<MessageEntity>>> call([NoParam? param]) async {
    return await homeRepo.receiveMessage();
  }
}
