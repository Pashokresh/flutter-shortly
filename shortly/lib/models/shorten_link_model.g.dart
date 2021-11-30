// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shorten_link_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShortenLinkModel _$ShortenLinkModelFromJson(Map<String, dynamic> json) {
  return ShortenLinkModel(
    json['code'] as String,
    json['short_link'] as String,
    json['full_short_link'] as String,
    json['short_link2'] as String,
    json['full_short_link2'] as String,
    json['share_link'] as String,
    json['full_share_link'] as String,
    json['original_link'] as String,
  );
}

Map<String, dynamic> _$ShortenLinkModelToJson(ShortenLinkModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'short_link': instance.shortLink,
      'full_short_link': instance.fullShortLink,
      'short_link2': instance.shortLink2,
      'full_short_link2': instance.fullShortLink2,
      'share_link': instance.shareLink,
      'full_share_link': instance.fullShareLink,
      'original_link': instance.originalLink,
    };
