import 'package:json_annotation/json_annotation.dart';

part 'get_user_orders_response.g.dart';

@JsonSerializable()
class GetUserOrdersResponse {
  int? status;
  String? message;
  @JsonKey(name: 'data')
  List<GetUserOrdersResponseData>? data;

  GetUserOrdersResponse({
    this.status,
    this.message,
    this.data,
  });

  factory GetUserOrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUserOrdersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserOrdersResponseToJson(this);
}

@JsonSerializable()
class GetUserOrdersResponseData {
  String? orderName;
  int? countOfOrders;
  int? weight;
  bool? breakable;
  String? expiryDate;
  int? expectedPrice;
  String? orderPhotoUrl;
  String? from;
  String? to;
  String? orderStatus;
  dynamic senderCode;
  dynamic receiverCode;
  int? negotiationPrice;
  dynamic cancellerId;
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

  Map<String, dynamic> toJson() => _$GetUserOrdersResponseDataToJson(this);
}
