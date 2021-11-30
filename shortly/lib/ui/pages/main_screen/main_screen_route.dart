import 'package:flutter/material.dart';
import 'main_screen_page.dart';

/// Route of [MainScreenPage]
class MainScreenRoute extends MaterialPageRoute {
  MainScreenRoute({required String routeName}): super(builder: (ctx) => MainScreenPage(), settings: RouteSettings(name: routeName));
}