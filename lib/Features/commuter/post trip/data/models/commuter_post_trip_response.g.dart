// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commuter_post_trip_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommuterPostTripResponse _$CommuterPostTripResponseFromJson(
        Map<String, dynamic> json) =>
    CommuterPostTripResponse(
      message: json['message'] as String?,
      commuterPostTripResponseData: json['data'] == null
          ? null
          : CommuterPostTripResponseData.fromJson(
              json['data'] as Map<String, dynamic>),
      status: (json['status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CommuterPostTripResponseToJson(
        CommuterPostTripResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'data': instance.commuterPostTripResponseData,
      'status': instance.status,
    };

CommuterPostTripResponseData _$CommuterPostTripResponseDataFromJson(
        Map<String, dynamic> json) =>
    CommuterPostTripResponseData(
      orderId: (json['orderId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CommuterPostTripResponseDataToJson(
        CommuterPostTripResponseData instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
    };
