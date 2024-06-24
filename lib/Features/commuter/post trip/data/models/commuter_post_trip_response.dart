import 'package:json_annotation/json_annotation.dart';
part 'commuter_post_trip_response.g.dart';

@JsonSerializable()
class CommuterPostTripResponse {
  String? message;
  @JsonKey(name: 'data')
  CommuterPostTripResponseData? commuterPostTripResponseData;
  int? status;

  CommuterPostTripResponse({
    this.message,
    this.commuterPostTripResponseData,
    this.status,
  });

  factory CommuterPostTripResponse.fromJson(Map<String, dynamic> json) =>
      _$CommuterPostTripResponseFromJson(json);
}

@JsonSerializable()
class CommuterPostTripResponseData {
  int? orderId;
  CommuterPostTripResponseData({
    this.orderId,
  });

  factory CommuterPostTripResponseData.fromJson(Map<String, dynamic> json) =>
      _$CommuterPostTripResponseDataFromJson(json);
}
