import 'package:json_annotation/json_annotation.dart';
part 'commuter_post_trip_response.g.dart';

@JsonSerializable()
class CommuterPostTripResponse {
  int? status;
  String? message;
  @JsonKey(name: 'data')
  CommuterPostTripResponseData? commuterPostTripResponseData;

  CommuterPostTripResponse({
    this.status,
    this.message,
    this.commuterPostTripResponseData,
  });

  factory CommuterPostTripResponse.fromJson(Map<String, dynamic> json) =>
      _$CommuterPostTripResponseFromJson(json);
}

@JsonSerializable()
class CommuterPostTripResponseData {
  CommuterPostTripResponseData();

  factory CommuterPostTripResponseData.fromJson(Map<String, dynamic> json) =>
      _$CommuterPostTripResponseDataFromJson(json);
}
