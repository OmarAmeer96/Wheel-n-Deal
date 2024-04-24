// The use cases are used to fetch data from the repository, so it should have an access to the repo.
import 'package:dartz/dartz.dart';
import 'package:wheel_n_deal/Core/errors/failure.dart';
import 'package:wheel_n_deal/Core/use_cases/use_case.dart';
import 'package:wheel_n_deal/Features/commuter/home/domain/entities/message_entity.dart';
import 'package:wheel_n_deal/Features/commuter/home/domain/repos/home_repo.dart';

class SendMessageUseCase extends UseCase<List<MessageEntity>, NoParam> {
  final HomeRepo homeRepo;

  SendMessageUseCase({required this.homeRepo});

  @override
  Future<Either<Failure, List<MessageEntity>>> call([NoParam? param]) async {
    /* 
    Here, for example if i will check the permissions, so the code will be written here, 
    and the functionality of fetching the featured books itself 
    is at the fetchFeauredBooks (so that i just called it in the next line). 
    */
    return await homeRepo.sendMessage();
  }
}
