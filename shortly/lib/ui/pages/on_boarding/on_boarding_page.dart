import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shortly/models/on_boarding_model.dart';
import 'package:shortly/ui/router/app_router.dart';
import 'package:shortly/ui/theme/app_extended_theme.dart';
import 'package:shortly/ui/ui_utils.dart';
import 'package:shortly/utils/consts.dart';


/// Page with promo carousel presented on first app launch
class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final _pageController = PageController();
  final _elements = OnBoardingModel.list;

  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final heightMargin = mainVerticalMargin(context);
    return Scaffold(
      body: SafeArea(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(height: heightMargin),
        SvgPicture.asset('assets/images/logo.svg'),
        Spacer(flex: 1),
        Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: PageView(
                controller: _pageController,
                children: _elements
                    .map((e) => OnBoardingElementView(title: e.title, text: e.text, imagePath: e.imagePath))
                    .toList(),
                onPageChanged: (index) => _currentPageNotifier.value = index)),
        const SizedBox(height: 28),
        _buildPageIndicator(),
        Spacer(flex: 1),
        _buildSkipButton(context),
        SizedBox(height: heightMargin),
      ])),
      backgroundColor: AppExtendedTheme.of(context).secondaryBackground,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// builds carousel indicator
  Widget _buildPageIndicator() {
    return CirclePageIndicator(
        currentPageNotifier: _currentPageNotifier,
        itemCount: _elements.length,
        size: 10,
        selectedSize: 10,
        dotSpacing: 10,
        dotColor: AppExtendedTheme.of(context).secondaryBackground,
        selectedDotColor: AppExtendedTheme.of(context).indicator,
        borderColor: AppExtendedTheme.of(context).indicator,
        selectedBorderColor: AppExtendedTheme.of(context).indicator,
        borderWidth: 2);
  }

  /// builds button skipping current page
  Widget _buildSkipButton(BuildContext context) {
    return GestureDetector(
      onTap: () => skipAction(context),
      child: Container(
          height: 49, padding: EdgeInsets.symmetric(horizontal: 49), child: Text('Skip', style: Theme.of(context).textTheme.headline5)),
    );
  }

  /// action to skip current page
  Future<void> skipAction(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(SharedPreferencesKeys.isFirstLaunch, false);

    Navigator.of(context).pushReplacementNamed(AppRoutePaths.mainScreenPage);
  }
}


/// Widget used in carousel to present promo
const double _badgeSize = 88;
const double _horizontalCardMargin = 25;

class OnBoardingElementView extends StatelessWidget {
  OnBoardingElementView({required this.title, required this.text, required this.imagePath});

  final String title;
  final String text;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: _horizontalCardMargin),
        child: Stack(children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: _badgeSize / 2),
              child: Container(
                  decoration:
                      BoxDecoration(color: AppExtendedTheme.of(context).background, borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 23, vertical: 64),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 20),
                            Text(title, style: Theme.of(context).textTheme.headline3, textAlign: TextAlign.center),
                            const SizedBox(height: 20),
                            Text(text, style: Theme.of(context).textTheme.headline5, textAlign: TextAlign.center)
                          ]))),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
                height: _badgeSize,
                width: _badgeSize,
                decoration: BoxDecoration(color: AppExtendedTheme.of(context).primaryActionDone, shape: BoxShape.circle),
                child: Center(child: SvgPicture.asset(imagePath))),
          )
        ]));
  }
}
