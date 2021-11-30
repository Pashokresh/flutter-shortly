import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shortly/blocs/local_store_history_cubit.dart';
import 'package:shortly/blocs/shorten_link_cubit.dart';
import 'package:shortly/models/history_item_model.dart';
import 'package:shortly/ui/common/shortly_action_button.dart';
import 'package:shortly/ui/pages/main_screen/widgets/history_list.dart';
import 'package:shortly/ui/theme/app_extended_theme.dart';
import 'package:shortly/ui/ui_utils.dart';

const double shortenSectionHeight = 204;
const double fadingHeight = 65;

class MainScreenPage extends StatefulWidget {
  @override
  _MainScreenPageState createState() => _MainScreenPageState();
}

class _MainScreenPageState extends State<MainScreenPage> {
  late ShortenLinkCubit _shortenLinkCubit;
  late LocalStoreHistoryCubit _localStoreHistoryCubit;

  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  bool _isError = false;
  final _hasUserStarted = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();

    _shortenLinkCubit = Provider.of<ShortenLinkCubit>(context, listen: false);
    _localStoreHistoryCubit = Provider.of<LocalStoreHistoryCubit>(context, listen: false);

    _localStoreHistoryCubit.fetchItems();
  }

  /// Method validates text in textField and sends input link to short it
  void _shortenAction() {
    if (_isError) return;

    if (_controller.text.isEmpty || Uri.tryParse(_controller.text) == null) {
      _isError = true;
      _controller.text = '';
      setState(() {});
    } else {
      _shortenLinkCubit.shortenLink(_controller.text);
      _hasUserStarted.value = true;
    }
  }

  /// Method called on [ShortenLinkCubit] state changed
  void _onLinkShortened(BuildContext context, ShortenLinkState state) {
    var currentState = state;
    if (currentState is ShortenLinkLoaded) {
      _localStoreHistoryCubit.addItems(
          HistoryItemModel(currentState.shortenLinkModel.originalLink, currentState.shortenLinkModel.fullShortLink, DateTime.now()));
    }
  }

  /// Method called on [LocalStoreHistoryCubit] state changed
  void _onHistoryFetched(BuildContext context, LocalStoreHistoryState state) {
    var currentState = state;
    if (currentState is LocalStoreHistoryFetched && currentState.items.isNotEmpty) {
      _hasUserStarted.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder(
            valueListenable: _hasUserStarted,
            child: Positioned(left: 0, bottom: 0, right: 0, height: shortenSectionHeight, child: _buildShortenSection(context)),
            builder: (context, bool value, child) {
              return Stack(children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: MediaQuery.of(context).size.height - shortenSectionHeight,
                  child: CustomScrollView(slivers: [
                    BlocListener(
                      bloc: _shortenLinkCubit,
                      listener: _onLinkShortened,
                      child: BlocListener(
                          bloc: _localStoreHistoryCubit,
                          listener: _onHistoryFetched,
                          child: value ? SliverToBoxAdapter(child: HistoryList()) : _buildIntroSection(context)),
                    )
                  ]),
                ),
                child ?? Container(),
                if (value)
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: shortenSectionHeight,
                      height: fadingHeight,
                      child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Color(0xFF0F1F6).withOpacity(0), Color(0xFFF0F1F6)]))))
              ]);
            }));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// if history is empty this promo section will be shown
  Widget _buildIntroSection(BuildContext context) {
    final heightMargin = mainVerticalMargin(context);
    return SliverToBoxAdapter(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        SizedBox(height: 2 * heightMargin),
        SvgPicture.asset('assets/images/logo.svg'),
        const SizedBox(height: 14),
        SvgPicture.asset('assets/images/illustration.svg', fit: BoxFit.fitWidth),
        const SizedBox(height: 12),
        Text('Let’s get started!', style: Theme.of(context).textTheme.headline3, textAlign: TextAlign.center),
        const SizedBox(height: 7),
        Text('Paste your first link into \n the field to shorten it',
            style: Theme.of(context).textTheme.headline5, textAlign: TextAlign.center),
      ]),
    );
  }

  /// builds section with textField and action button
  Widget _buildShortenSection(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: AppExtendedTheme.of(context).primaryActionDone),
        child: Stack(children: [
          Align(alignment: Alignment.topRight, child: SvgPicture.asset('assets/images/shape.svg')),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 46, horizontal: 48),
              child: Form(
                  key: _formKey,
                  child: Column(children: [
                    _buildTextField(context),
                    const SizedBox(height: 10),
                    ShortlyActionButton(title: 'Shorten it!'.toUpperCase(), onTap: () => _shortenAction())
                  ])))
        ]));
  }

  /// builds form's textField for original link
  Widget _buildTextField(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: AppExtendedTheme.of(context).background,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: _isError ? AppExtendedTheme.of(context).error : Colors.transparent)),
        child: TextFormField(
          controller: _controller,
          onTap: () {
            _controller.text = '';
            if (_isError) {
              _isError = false;
              _formKey.currentState!.setState(() {});
            }
          },
          decoration: InputDecoration(
              hintText: _isError ? 'Please add a link here' : 'Shorten a link here ...',
              hintStyle: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(color: _isError ? AppExtendedTheme.of(context).error : AppExtendedTheme.of(context).hint),
              border: InputBorder.none),
          textAlign: TextAlign.center,
        ));
  }
}
