import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shortly/ui/router/app_router.dart';
import 'package:shortly/ui/theme/app_extended_theme.dart';

class ShortlyApp extends StatefulWidget {
  const ShortlyApp({Key? key}) : super(key: key);

  @override
  ShortlyAppState createState() => ShortlyAppState();
}

class ShortlyAppState extends State<ShortlyApp> {
  late AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Shortly',
        builder: (context, child) {
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
          return AppExtendedTheme(child: child ?? Container());
        },
        theme: buildAppBaseLightThemeData(context),
        onGenerateRoute: _appRouter.generateRoute,
        initialRoute: AppRoutePaths.splashScreenPage);
  }
}
