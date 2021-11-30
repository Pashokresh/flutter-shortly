import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shortly/providers/app_providers.dart';
import 'package:shortly/ui/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: appProviders, child: ShortlyApp()));
}
