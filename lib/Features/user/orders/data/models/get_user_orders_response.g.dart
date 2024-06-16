// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_orders_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserOrdersResponse _$GetUserOrdersResponseFromJson(
        Map<String, dynamic> json) =>
    GetUserOrdersResponse(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              GetUserOrdersResponseData.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: (json['status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GetUserOrdersResponseToJson(
        GetUserOrdersResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.data,
      'status': instance.status,
    };

GetUserOrdersResponseData _$GetUserOrdersResponseDataFromJson(
        Map<String, dynamic> json) =>
    GetUserOrdersResponseData(
      orderName: json['orderName'] as String?,
      countOfOrders: (json['countOfOrders'] as num?)?.toInt(),
      weight: (json['weight'] as num?)?.toInt(),
      breakable: json['breakable'] as String?,
      expiryDate: json['expiryDate'] as String?,
      expectedPrice: (json['expectedPrice'] as num?)?.toDouble(),
      orderPhotoUrl: json['orderPhotoUrl'] as String?,
      from: json['from'] as String?,
      to: json['to'] as String?,
      orderStatus: json['orderStatus'] as String?,
      senderCode: json['senderCode'] as String?,
      receiverCode: json['receiverCode'] as String?,
      negotiationPrice: (json['negotiationPrice'] as num?)?.toDouble(),
      cancellerId: json['cancellerId'] as String?,
      id: (json['id'] as num?)?.toInt(),
      senderName: json['senderName'] as String?,
      senderPhoneNumber: json['senderPhoneNumber'] as String?,
      receiverName: json['receiverName'] as String?,
      receiverPhoneNumber: json['receiverPhoneNumber'] as String?,
    );

Map<String, dynamic> _$GetUserOrdersResponseDataToJson(
        GetUserOrdersResponseData instance) =>
    <String, dynamic>{
      'orderName': instance.orderName,
      'countOfOrders': instance.countOfOrders,
      'weight': instance.weight,
      'breakable': instance.breakable,
      'expiryDate': instance.expiryDate,
      'expectedPrice': instance.expectedPrice,
      'orderPhotoUrl': instance.orderPhotoUrl,
      'from': instance.from,
      'to': instance.to,
      'orderStatus': instance.orderStatus,
      'senderCode': instance.senderCode,
      'receiverCode': instance.receiverCode,
      'negotiationPrice': instance.negotiationPrice,
      'cancellerId': instance.cancellerId,
      'id': instance.id,
      'senderName': instance.senderName,
      'senderPhoneNumber': instance.senderPhoneNumber,
      'receiverName': instance.receiverName,
      'receiverPhoneNumber': instance.receiverPhoneNumber,
    };
