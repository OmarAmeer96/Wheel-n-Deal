import 'package:json_annotation/json_annotation.dart';
part 'get_user_orders_response.g.dart';

@JsonSerializable()
class GetUserOrdersResponse {
  String? message;
  @JsonKey(name: 'data')
  GetUserOrdersResponseData? getUserOrdersResponseData;
  int? status;

  GetUserOrdersResponse({
    this.message,
    this.getUserOrdersResponseData,
    this.status,
  });

  factory GetUserOrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUserOrdersResponseFromJson(json);
}

@JsonSerializable()
class GetUserOrdersResponseData {
  String? orderName;
  int? countOfOrders;
  int? weight;
  String? breakable;
  String? expiryDate;
  double? expectedPrice;
  String? orderPhotoUrl;
  String? from;
  String? to;
  String? orderStatus;
  String? senderCode;
  String? receiverCode;
  double? negotiationPrice;
  String? cancellerId;
  int? id;
  String? senderName;
  String? senderPhoneNumber;
  String? receiverName;
  String? receiverPhoneNumber;

  GetUserOrdersResponseData({
    this.orderName,
    this.countOfOrders,
    this.weight,
    this.breakable,
    this.expiryDate,
    this.expectedPrice,
    this.orderPhotoUrl,
    this.from,
    this.to,
    this.orderStatus,
    this.senderCode,
    this.receiverCode,
    this.negotiationPrice,
    this.cancellerId,
    this.id,
    this.senderName,
    this.senderPhoneNumber,
    this.receiverName,
    this.receiverPhoneNumber,
  });

  factory GetUserOrdersResponseData.fromJson(Map<String, dynamic> json) =>
      _$GetUserOrdersResponseDataFromJson(json);
}
