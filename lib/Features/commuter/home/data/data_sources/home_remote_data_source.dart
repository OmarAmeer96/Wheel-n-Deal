import 'package:wheel_n_deal/Features/commuter/home/domain/entities/message_entity.dart';

abstract class HomeRemoteDataSource {
  List<MessageEntity> sendMessage();
  Future<List<MessageEntity>> receiveMessage();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  List<MessageEntity> sendMessage() {
    throw UnimplementedError();
  }

  @override
  Future<List<MessageEntity>> receiveMessage() {
    throw UnimplementedError();
  }
}
