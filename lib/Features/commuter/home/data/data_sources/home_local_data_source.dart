import 'package:wheel_n_deal/Features/commuter/home/domain/entities/message_entity.dart';

abstract class HomeLocalDataSource {
  List<MessageEntity> fetchFeauredBooks();
  List<MessageEntity> fetchNewewstBooks();
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  @override
  List<MessageEntity> fetchFeauredBooks() {
    // TODO: implement fetchFeauredBooks
    throw UnimplementedError();
  }

  @override
  List<MessageEntity> fetchNewewstBooks() {
    // TODO: implement fetchNewewstBooks
    throw UnimplementedError();
  }
}
