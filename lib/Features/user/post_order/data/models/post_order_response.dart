import 'package:json_annotation/json_annotation.dart';
part 'post_order_response.g.dart';

@JsonSerializable()
class PostOrderResponse {
  String? message;
  @JsonKey(name: 'data')
  PostOrderResponseData? postOrderResponseData;
  int? status;

  PostOrderResponse({
    this.message,
    this.postOrderResponseData,
    this.status,
  });

  factory PostOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$PostOrderResponseFromJson(json);
}

@JsonSerializable()
class PostOrderResponseData {
  String? orderId;
  PostOrderResponseData({
    this.orderId,
  });

  factory PostOrderResponseData.fromJson(Map<String, dynamic> json) =>
      _$PostOrderResponseDataFromJson(json);
}
