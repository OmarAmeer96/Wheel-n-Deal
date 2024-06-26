// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commuter_post_trip_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommuterPostTripResponse _$CommuterPostTripResponseFromJson(
        Map<String, dynamic> json) =>
    CommuterPostTripResponse(
      status: (json['status'] as num?)?.toInt(),
      message: json['message'] as String?,
      commuterPostTripResponseData: json['data'] == null
          ? null
          : CommuterPostTripResponseData.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommuterPostTripResponseToJson(
        CommuterPostTripResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.commuterPostTripResponseData,
    };

CommuterPostTripResponseData _$CommuterPostTripResponseDataFromJson(
        Map<String, dynamic> json) =>
    CommuterPostTripResponseData();

Map<String, dynamic> _$CommuterPostTripResponseDataToJson(
        CommuterPostTripResponseData instance) =>
    <String, dynamic>{};
