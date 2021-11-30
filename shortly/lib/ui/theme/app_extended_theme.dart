import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Standard font
const poppinsFontFamily = 'Poppins';

/// Main light theme
ThemeData buildAppBaseLightThemeData(BuildContext context) => ThemeData(
    fontFamily: poppinsFontFamily,
    brightness: Brightness.light,
    textTheme: TextTheme(
            headline1: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
            headline3: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            headline5: TextStyle(fontSize: 17, fontWeight: FontWeight.w500))
        .apply(bodyColor: Color(0xFF35323E), displayColor: Color(0xFF35323E)));

/// Extension of base [Theme] for the app.
/// All fonts and colors which are not in base theme will be here
class AppExtendedTheme extends StatelessWidget {
  const AppExtendedTheme({Key? key, this.data, required this.child}) : super(key: key);

  final AppExtendedThemeData? data;
  final Widget child;

  static AppExtendedThemeData of(BuildContext context) {
    final _InheritedTheme? inheritedTheme = context.dependOnInheritedWidgetOfExactType<_InheritedTheme>();
    return inheritedTheme?.theme?.data ?? AppExtendedThemeData.fromContext(context);
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedTheme(
      theme: this,
      child: child,
    );
  }
}

/// Использует [InheritedWidget], что позваляет передавать [AppExtendedTheme] по всему дереву приложения
class _InheritedTheme extends InheritedTheme {
  const _InheritedTheme({
    Key? key,
    required this.theme,
    required Widget child,
  }) : super(key: key, child: child);

  final AppExtendedTheme theme;

  @override
  Widget wrap(BuildContext context, Widget child) {
    final _InheritedTheme? ancestorTheme = context.findAncestorWidgetOfExactType<_InheritedTheme>();
    return identical(this, ancestorTheme) ? child : AppExtendedTheme(data: theme.data, child: child);
  }

  @override
  bool updateShouldNotify(_InheritedTheme old) => theme.data != old.theme.data;
}

/// Initializes and keeps all extended parameters of app's theme
class AppExtendedThemeData {
  AppExtendedThemeData();

  late Color primaryAction;

  late Color primaryActionDone;

  late Color error;

  late Color hint;

  late Color indicator;

  late Color grayishViolet;

  late Color veryDarkViolet;

  late Color background;

  late Color secondaryBackground;

  late Color primaryTextColor;

  late TextStyle? buttonTextStyle;

  /// Initializes parameters of extended theme based on [Theme]
  ///
  factory AppExtendedThemeData.fromContext(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppExtendedThemeData extendedTheme = AppExtendedThemeData();

    extendedTheme.primaryAction = Color(0xFF2ACFCF);
    extendedTheme.primaryActionDone = Color(0xFF3B3054);
    extendedTheme.error = Color(0xFFF46262);
    extendedTheme.hint = Color(0xFFBFBFBF);
    extendedTheme.indicator = Color(0xFF9E9AA7);
    extendedTheme.grayishViolet = Color(0xFF35323E);
    extendedTheme.veryDarkViolet = Color(0xFF232127);
    extendedTheme.background = Color(0xFFFFFFFF);
    extendedTheme.secondaryBackground = Color(0xFFF0F1F6);

    extendedTheme.buttonTextStyle = theme.textTheme.headline3?.copyWith(color: extendedTheme.background);


    return extendedTheme;
  }
}
