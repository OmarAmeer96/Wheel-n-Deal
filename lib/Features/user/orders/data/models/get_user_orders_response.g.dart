// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_orders_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserOrdersResponse _$GetUserOrdersResponseFromJson(
        Map<String, dynamic> json) =>
    GetUserOrdersResponse(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              GetUserOrdersResponseData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetUserOrdersResponseToJson(
        GetUserOrdersResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

GetUserOrdersResponseData _$GetUserOrdersResponseDataFromJson(
        Map<String, dynamic> json) =>
    GetUserOrdersResponseData(
      orderName: json['orderName'] as String?,
      countOfOrders: (json['countOfOrders'] as num?)?.toInt(),
      weight: (json['weight'] as num?)?.toInt(),
      breakable: json['breakable'] as bool?,
      expiryDate: json['expiryDate'] as String?,
      expectedPrice: (json['expectedPrice'] as num?)?.toInt(),
      orderPhotoUrl: json['orderPhotoUrl'] as String?,
      from: json['from'] as String?,
      to: json['to'] as String?,
      orderStatus: json['orderStatus'] as String?,
      senderCode: json['senderCode'],
      receiverCode: json['receiverCode'],
      negotiationPrice: (json['negotiationPrice'] as num?)?.toInt(),
      cancellerId: json['cancellerId'],
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
