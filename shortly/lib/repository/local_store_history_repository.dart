import 'package:localstore/localstore.dart';
import 'package:shortly/models/history_item_model.dart';
import 'package:shortly/utils/consts.dart';

class LocalStoreHistoryRepository {
  final _db = Localstore.instance;

  CollectionRef get _historyCollection => _db.collection(LocalstoreKeys.dbHistory);

  /// Adds new item to history local store
  Future<void> addNewHistoryItem(HistoryItemModel item) async {
    // gets new item ID
    final id = _historyCollection.doc().id;

    _historyCollection.doc(id).set(item.toMap());
  }

  Future<List<HistoryItemModel>> fetchHistoryItems() async {
    final itemsMap = await _historyCollection.get();
    var items = <HistoryItemModel>[];
    itemsMap?.forEach((key, value) => items.add(HistoryItemModel.from(value as Map<String, dynamic>)..id = key.split('/').last));
    items.sort((a, b) => a.created.compareTo(b.created));
    return items.reversed.toList();
  }

  Future<void> deleteHistoryItem(String id) async {
    await _historyCollection.doc(id).delete();
  }
}