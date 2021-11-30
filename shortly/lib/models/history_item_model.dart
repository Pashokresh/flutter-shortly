import 'package:shortly/utils/consts.dart';

class HistoryItemModel {
  HistoryItemModel(this.originalLink, this.shortLink, this.created);

  final String originalLink;
  final String shortLink;
  final DateTime created;

  late String id;

  factory HistoryItemModel.from(Map<String, dynamic> map) {
    return HistoryItemModel(map[LocalstoreKeys.original] ?? '', map[LocalstoreKeys.short] ?? '',
        DateTime.fromMillisecondsSinceEpoch(map[LocalstoreKeys.created]));
  }

  Map<String, dynamic> toMap() {
    return {LocalstoreKeys.original: originalLink, LocalstoreKeys.short: shortLink, LocalstoreKeys.created: created.millisecondsSinceEpoch};
  }
}
