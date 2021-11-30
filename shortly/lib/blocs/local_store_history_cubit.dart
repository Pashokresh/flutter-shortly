import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortly/models/history_item_model.dart';
import 'package:shortly/repository/local_store_history_repository.dart';

class LocalStoreHistoryCubit extends Cubit<LocalStoreHistoryState> {
  LocalStoreHistoryCubit(this._repository) : super(LocalStoreHistoryInitial());

  final LocalStoreHistoryRepository _repository;

  Future<void> fetchItems() async {
    emit(LocalStoreHistoryFetching());
    await _fetchItems();
  }

  Future<void> addItems(HistoryItemModel item) async {
    _repository.addNewHistoryItem(item);
    await _fetchItems();
  }

  Future<void> deleteItemWith({required String id}) async {
    await _repository.deleteHistoryItem(id);
    await _fetchItems();
  }

  Future<void> _fetchItems() async {
    final items = await _repository.fetchHistoryItems();
    emit(LocalStoreHistoryFetched(items));
  }
}

abstract class LocalStoreHistoryState extends Equatable {
  const LocalStoreHistoryState();

  @override
  List<Object> get props => [];
}

class LocalStoreHistoryInitial extends LocalStoreHistoryState {}

class LocalStoreHistoryFetching extends LocalStoreHistoryState {}

class LocalStoreHistoryFetched extends LocalStoreHistoryState {
  const LocalStoreHistoryFetched(this.items);

  final List<HistoryItemModel> items;

  @override
  List<Object> get props => [items];
}