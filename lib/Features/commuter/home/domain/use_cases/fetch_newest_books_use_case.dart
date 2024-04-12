import 'package:dartz/dartz.dart';
import 'package:wheel_n_deal/Core/errors/failure.dart';
import 'package:wheel_n_deal/Core/use_cases/use_case.dart';
import 'package:wheel_n_deal/Features/commuter/home/domain/entities/book_entity.dart';
import 'package:wheel_n_deal/Features/commuter/home/domain/repos/home_repo.dart';

class FetchNewestBooksUseCase extends UseCase<List<BookEntity>, NoParam> {
  final HomeRepo homeRepo;

  FetchNewestBooksUseCase({required this.homeRepo});
  @override
  Future<Either<Failure, List<BookEntity>>> call([NoParam? param]) async {
    return await homeRepo.fetchNewewstBooks();
  }
}
