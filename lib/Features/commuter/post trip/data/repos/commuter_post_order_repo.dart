import 'package:wheel_n_deal/Core/networking/api_error_handler.dart';
import 'package:wheel_n_deal/Core/networking/api_result.dart';
import 'package:wheel_n_deal/Core/networking/api_service.dart';
import 'package:wheel_n_deal/Features/commuter/post%20trip/data/models/commuter_post_trip_response.dart';

class CommuterPostTripRepo {
  final ApiService _apiServices;

  CommuterPostTripRepo(this._apiServices);

  Future<ApiResult<CommuterPostTripResponse>> commuterPostTrip(
    String token,
    String from,
    String to,
    List<String> paths,
    String tripPhoto,
    String startsAt,
    String endsAt,
    String capacity,
    int userId,
  ) async {
    try {
      final response = await _apiServices.commuterPostTrip(
        token: 'Bearer $token',
        from: from,
        to: to,
        paths: paths,
        tripPhoto: tripPhoto,
        startsAt: startsAt,
        endsAt: endsAt,
        capacity: capacity,
        userId: userId,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
