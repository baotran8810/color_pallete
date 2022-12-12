import 'package:color_pallete/resources/color_scheme.dart';
import 'package:color_pallete/resources/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppThemeData {
  final Brightness brightness;
  final AppColorScheme colorScheme;
  final AppTextTheme textTheme;

  const AppThemeData.raw({
    required this.brightness,
    required this.colorScheme,
    required this.textTheme,
  });

  factory AppThemeData(
          {required Brightness brightness,
          required AppColorScheme colorScheme}) =>
      AppThemeData.raw(
        brightness: brightness,
        colorScheme: colorScheme,
        textTheme: AppTextTheme.create(color: Colors.white),
      );

  factory AppThemeData.main() => AppThemeData(
        brightness: Brightness.dark,
        colorScheme: AppColorScheme.main(),
      );

  ThemeData get materialThemeData => ThemeData(
        primaryColor: colorScheme.primary,
        dividerColor: colorScheme.primary,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          brightness: Brightness.dark,
          primary: colorScheme.primary,
          secondary: Colors.black,
        ),
        // primaryTextTheme: GoogleFonts.chakraPetchTextTheme(),
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          centerTitle: true,
          color: Colors.blue,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all(
              AppThemeData.main().colorScheme.primary),
        ),
      );
}

class AppTheme extends InheritedWidget {
  final AppThemeData data;

  const AppTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  static AppTheme of(BuildContext context) {
    final AppTheme? result =
        context.dependOnInheritedWidgetOfExactType<AppTheme>();
    assert(result != null, 'No PATheme found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant AppTheme oldWidget) {
    return data != oldWidget.data;
  }
}
