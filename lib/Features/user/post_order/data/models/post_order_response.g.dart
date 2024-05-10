// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostOrderResponse _$PostOrderResponseFromJson(Map<String, dynamic> json) =>
    PostOrderResponse(
      message: json['message'] as String?,
      postOrderResponseData: json['data'] == null
          ? null
          : PostOrderResponseData.fromJson(
              json['data'] as Map<String, dynamic>),
      status: (json['status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PostOrderResponseToJson(PostOrderResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.postOrderResponseData,
      'status': instance.status,
    };

PostOrderResponseData _$PostOrderResponseDataFromJson(
        Map<String, dynamic> json) =>
    PostOrderResponseData(
      orderId: (json['orderId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PostOrderResponseDataToJson(
        PostOrderResponseData instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
    };
