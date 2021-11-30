import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shortly/blocs/local_store_history_cubit.dart';
import 'package:shortly/blocs/shorten_link_cubit.dart';
import 'package:shortly/models/history_item_model.dart';
import 'package:shortly/ui/common/shortly_action_button.dart';
import 'package:shortly/ui/pages/main_screen/main_screen_page.dart';
import 'package:shortly/ui/theme/app_extended_theme.dart';
import 'package:shortly/ui/ui_utils.dart';

const double _defaultPadding = 23;

class HistoryList extends StatefulWidget {
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  late ShortenLinkCubit _shortenLinkCubit;
  late LocalStoreHistoryCubit _localStoreHistoryCubit;

  var _copiedLinkId = ValueNotifier<String>('');

  @override
  void initState() {
    super.initState();

    _shortenLinkCubit = Provider.of<ShortenLinkCubit>(context, listen: false);
    _localStoreHistoryCubit = Provider.of<LocalStoreHistoryCubit>(context, listen: false);
  }

  /// Copies short link
  Future<void> _copyToClipboard(String str) async {
    await Clipboard.setData(ClipboardData(text: str));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _shortenLinkCubit,
        builder: (context, shortenLinkState) => BlocBuilder(
            bloc: _localStoreHistoryCubit,
            builder: (context, localStoreState) {
              var currentLocalStoreState = localStoreState;
              return Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisSize: MainAxisSize.max, children: [
                SizedBox(height: 2 * mainVerticalMargin(context)),
                _buildHeader(context),
                const SizedBox(height: 10),
                if (shortenLinkState is ShortenLinkLoading)
                  Container(height: 60, child: Center(child: CircularProgressIndicator.adaptive())),
                if (currentLocalStoreState is LocalStoreHistoryFetched) _buildList(context, currentLocalStoreState.items),
                SizedBox(height: fadingHeight),
              ]);
            }));
  }

  /// header with title
  Widget _buildHeader(BuildContext context) => Text('Your Link History', style: Theme.of(context).textTheme.headline5);

  /// builds list with history items
  Widget _buildList(BuildContext context, List<HistoryItemModel> items) => ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => _listItemCard(context, items[index]),
      padding: EdgeInsets.symmetric(horizontal: 25));

  /// method decorating history list item
  Widget _listItemCard(BuildContext context, HistoryItemModel item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
          decoration: BoxDecoration(color: AppExtendedTheme.of(context).background, borderRadius: BorderRadius.circular(8)),
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: _defaultPadding),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Padding(
                    padding: const EdgeInsets.only(left: _defaultPadding, bottom: 12.0, right: _defaultPadding),
                    child: Row(children: [
                      Flexible(
                          fit: FlexFit.tight,
                          child: Text(item.originalLink, style: Theme.of(context).textTheme.headline5, overflow: TextOverflow.ellipsis)),
                      GestureDetector(
                          onTap: () => _localStoreHistoryCubit.deleteItemWith(id: item.id), child: SvgPicture.asset('assets/images/del.svg'))
                    ])),
                Divider(color: AppExtendedTheme.of(context).hint, thickness: 1),
                Padding(
                    padding: const EdgeInsets.only(top: 12.0, left: _defaultPadding, right: _defaultPadding),
                    child: Column(children: [
                      Text(item.shortLink,
                          style: Theme.of(context).textTheme.headline5?.copyWith(color: AppExtendedTheme.of(context).primaryAction),
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(height: _defaultPadding),
                      ValueListenableBuilder(valueListenable: _copiedLinkId, builder: (context, String value, child) => ShortlyActionButton(
                          title: (value == item.id ? 'Copied!' : 'Copy!').toUpperCase(),
                          onTap: () {
                            _copiedLinkId.value = item.id;
                            _copyToClipboard(item.shortLink);
                          },
                          actionDone: value == item.id))
                    ]))
              ]))),
    );
  }
}
