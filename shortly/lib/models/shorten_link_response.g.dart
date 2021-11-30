// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shorten_link_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShortenLinkResponse _$ShortenLinkResponseFromJson(Map<String, dynamic> json) {
  return ShortenLinkResponse(
    json['ok'] as bool,
    ShortenLinkModel.fromJson(json['result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ShortenLinkResponseToJson(
        ShortenLinkResponse instance) =>
    <String, dynamic>{
      'ok': instance.ok,
      'result': instance.result,
    };
