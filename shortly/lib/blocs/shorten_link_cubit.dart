import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shortly/models/shorten_link_model.dart';
import 'package:shortly/repository/shorten_link_repository.dart';

/// Cubit loading [ShortenLinkModel]
class ShortenLinkCubit extends Cubit<ShortenLinkState> {
  ShortenLinkCubit(this._repository) : super(ShortenLinkInitial());

  final ShortenLinkRepository _repository;

  /// Method loading shortened link
  Future<void> shortenLink(String link) async {
    emit(ShortenLinkLoading());
    try {
      final result = await _repository.shortenLink(link);
      emit(ShortenLinkLoaded(result));
    } catch (ex, trace) {
      emit(ShortenLinkError());
      addError(ex, trace);
    }
  }
}

abstract class ShortenLinkState extends Equatable {
  const ShortenLinkState();

  @override
  List<Object> get props => [];
}

class ShortenLinkInitial extends ShortenLinkState {}

class ShortenLinkLoading extends ShortenLinkState {}

class ShortenLinkLoaded extends ShortenLinkState {
  ShortenLinkLoaded(this.shortenLinkModel);

  final ShortenLinkModel shortenLinkModel;

  @override
  List<Object> get props => [shortenLinkModel];

  @override
  bool get stringify => true;
}

class ShortenLinkError extends ShortenLinkState {}