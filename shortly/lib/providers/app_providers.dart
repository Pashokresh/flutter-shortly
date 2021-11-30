import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shortly/blocs/local_store_history_cubit.dart';
import 'package:shortly/blocs/shorten_link_cubit.dart';
import 'package:shortly/networking/api_base_helper.dart';
import 'package:shortly/repository/local_store_history_repository.dart';
import 'package:shortly/repository/shorten_link_repository.dart';

List<SingleChildStatelessWidget> appProviders = [
  Provider<ApiBaseHelper>.value(value: ApiBaseHelper()),
  ProxyProvider<ApiBaseHelper, ShortenLinkRepository>(update: (context, helper, previous) => previous ?? ShortenLinkRepository(helper)),
  ProxyProvider<ShortenLinkRepository, ShortenLinkCubit>(update: (context, repository, previous) => previous ?? ShortenLinkCubit(repository)),
  Provider<LocalStoreHistoryRepository>.value(value: LocalStoreHistoryRepository()),
  ProxyProvider<LocalStoreHistoryRepository, LocalStoreHistoryCubit>(update: (context, repository, previous) => previous ?? LocalStoreHistoryCubit(repository))
];