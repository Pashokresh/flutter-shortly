import 'package:json_annotation/json_annotation.dart';

part 'shorten_link_model.g.dart';

/// Model containing different types of links (full and short)
@JsonSerializable()
class ShortenLinkModel {
  ShortenLinkModel(this.code, this.shortLink, this.fullShortLink, this.shortLink2, this.fullShortLink2, this.shareLink, this.fullShareLink,
      this.originalLink);

  final String code;

  /// Short link for example "shrtco.de/KCveN"
  @JsonKey(name: 'short_link')
  final String shortLink;

  /// Full short link for example "https://shrtco.de/KCveN"
  @JsonKey(name: 'full_short_link')
  final String fullShortLink;

  /// Short link for example "9qr.de/KCveN"
  @JsonKey(name: 'short_link2')
  final String shortLink2;

  /// Full short link for example "https://9qr.de/KCveN"
  @JsonKey(name: 'full_short_link2')
  final String fullShortLink2;

  /// Share link
  @JsonKey(name: 'share_link')
  final String shareLink;

  /// Full share link "https://" + [share link]
  @JsonKey(name: 'full_share_link')
  final String fullShareLink;

  /// Original link, had been used to get short links
  @JsonKey(name: 'original_link')
  final String originalLink;


  factory ShortenLinkModel.fromJson(Map<String, dynamic> json) => _$ShortenLinkModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShortenLinkModelToJson(this);
}
