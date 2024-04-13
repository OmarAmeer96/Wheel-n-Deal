/* Here, this is abstract as in thic class I will determine what will happen in the remote data source, 
but without determining how that will happen.
Also, I will not use the either type here; as I don't need to handle the exceptions here.
*/
import 'package:wheel_n_deal/Core/utils/api_service.dart';
import 'package:wheel_n_deal/Features/commuter/home/domain/entities/message_entity.dart';

abstract class HomeRemoteDataSource {
  Future<List<MessageEntity>> fetchFeauredBooks();
  Future<List<MessageEntity>> fetchNewewstBooks();
}

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final ApiService apiService;

  HomeRemoteDataSourceImpl(this.apiService);
  @override
  Future<List<MessageEntity>> fetchFeauredBooks() async {
    var data = await apiService.get(
      endPoint: 'volumes?Filtering=free-ebooks&q=programming',
    );
    List<MessageEntity> books = getBooksList(data);
    return books;
  }

  @override
  Future<List<MessageEntity>> fetchNewewstBooks() async {
    var data = await apiService.get(
      endPoint: 'volumes?Filtering=free-ebooks&Sorting=newewst&q=programming',
    );
    List<MessageEntity> books = getBooksList(data);
    return books;
  }

  List<MessageEntity> getBooksList(Map<String, dynamic> data) {
    List<MessageEntity> books = [];
    // ignore: unused_local_variable
    for (var bookMap in data['items']) {
      // books.add(BookModel.fromJson(bookMap));
    }
    return books;
  }
}
