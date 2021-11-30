import 'package:flutter/material.dart';
import 'package:shortly/ui/pages/main_screen/main_screen_route.dart';
import 'package:shortly/ui/pages/on_boarding/on_boarding_route.dart';
import 'package:shortly/ui/pages/splash_screen/splash_screen_route.dart';

class AppRoutePaths {
  /// Start screen
  static const splashScreenPage = 'splashScreenPage';

  /// Introducing carousel
  static const onBoardingPage = 'onBoardingPage';

  /// Main page
  static const mainScreenPage = 'mainScreenPage';
}

class AppRouter {
  /// Takes needed [PageRoute] by name [AppRoutePaths]
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutePaths.splashScreenPage:
        return SplashScreenRoute(routeName: AppRoutePaths.splashScreenPage);
      case AppRoutePaths.onBoardingPage:
        return OnBoardingRoute(routeName: AppRoutePaths.onBoardingPage);
      case AppRoutePaths.mainScreenPage:
        return MainScreenRoute(routeName: AppRoutePaths.mainScreenPage);
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
    }
  }
}
