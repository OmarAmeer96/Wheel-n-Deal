
import 'package:wheel_n_deal/Features/commuter/home/domain/entities/book_entity.dart';

abstract class HomeLocalDataSource {
  List<BookEntity> fetchFeauredBooks();
  List<BookEntity> fetchNewewstBooks();
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  @override
  List<BookEntity> fetchFeauredBooks() {
    // TODO: implement fetchFeauredBooks
    throw UnimplementedError();
  }

  @override
  List<BookEntity> fetchNewewstBooks() {
    // TODO: implement fetchNewewstBooks
    throw UnimplementedError();
  }
}
