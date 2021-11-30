import 'package:json_annotation/json_annotation.dart';
import 'package:shortly/models/shorten_link_model.dart';

part 'shorten_link_response.g.dart';

@JsonSerializable()
class ShortenLinkResponse {
  ShortenLinkResponse(this.ok, this.result);

  final bool ok;
  final ShortenLinkModel result;

  factory ShortenLinkResponse.fromJson(Map<String, dynamic> json) => _$ShortenLinkResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ShortenLinkResponseToJson(this);
}