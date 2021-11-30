import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shortly/ui/common/shortly_action_button.dart';
import 'package:shortly/ui/router/app_router.dart';
import 'package:shortly/ui/ui_utils.dart';
import 'package:shortly/utils/consts.dart';

const double marginPartHighOfScreen = 20;

/// First screen presenting on the app launch
class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final heightMargin = mainVerticalMargin(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: heightMargin),
              SvgPicture.asset(
                'assets/images/logo.svg',
              ),
              const SizedBox(height: 15),
              SvgPicture.asset('assets/images/illustration.svg', fit: BoxFit.fitWidth),
              const SizedBox(height: 15),
              Text('More than just shorter links', style: Theme.of(context).textTheme.headline1, textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Text('Build your brand’s recognition and get detailed insights on how your links are performing.',
                  style: Theme.of(context).textTheme.headline5, textAlign: TextAlign.center),
              SizedBox(height: heightMargin),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: ShortlyActionButton(onTap: () => onStartTaped(context), title: 'Start'.toUpperCase())),
              SizedBox(height: heightMargin),
            ],
          ),
        ),
      ),
    );
  }

  /// Handler on start button
  Future<void> onStartTaped(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool(SharedPreferencesKeys.isFirstLaunch) ?? true;

    Navigator.of(context).pushReplacementNamed(isFirstLaunch ? AppRoutePaths.onBoardingPage : AppRoutePaths.mainScreenPage);
  }
}
