import 'package:flutter/material.dart';
import 'package:shortly/ui/pages/splash_screen/splash_screen_page.dart';

/// Роут экрана [SplashScreenPage]
class SplashScreenRoute extends MaterialPageRoute {
  SplashScreenRoute({required String routeName})
      : super(builder: (ctx) => SplashScreenPage(), settings: RouteSettings(name: routeName));
}