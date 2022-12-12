import 'package:flutter/material.dart';

class AppColorScheme {
  final Color primary;

  AppColorScheme({required this.primary});

  factory AppColorScheme.main() => AppColorScheme(primary: Colors.white);
}
