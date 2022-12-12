import 'package:color_pallete/resources/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension BuildContextExt on BuildContext {
  AppThemeData get theme => AppTheme.of(this).data;

  AppLocalizations get localizations => AppLocalizations.of(this)!;
}
