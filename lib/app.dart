import 'package:color_pallete/data/models/app_configs_model.dart';

import 'package:color_pallete/resources/routes.dart';
import 'package:color_pallete/resources/themes.dart';
import 'package:color_pallete/ui/screens/main_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends StatefulWidget {
  final AppConfig appConfig;
  const MyApp({super.key, required this.appConfig});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    _initApp();
    super.initState();
  }

  _initApp() {}

  @override
  Widget build(BuildContext context) {
    final themeData = AppThemeData.main();
    return AppTheme(
      data: themeData,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.root,
        theme: themeData.materialThemeData,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''),
          Locale('es', ''),
        ],
        locale: const Locale('en', ''),
        onGenerateRoute: (settings) => _getRoute(settings),
      ),
    );
  }

  Route<dynamic> _getRoute(RouteSettings settings) {
    switch (settings.name) {
      default:
        return MaterialPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const MainScreen(),
        );

      // throw Exception("Route is not defined");
    }
  }
}
