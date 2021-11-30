import 'package:flutter/material.dart';
import 'on_boarding_page.dart';

/// Route of [OnBoardingPage]
class OnBoardingRoute extends MaterialPageRoute {
  OnBoardingRoute({required String routeName}): super(builder: (ctx) => OnBoardingPage(), settings: RouteSettings(name: routeName));
}
