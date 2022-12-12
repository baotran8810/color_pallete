import 'package:flutter/material.dart';

class AppTextTheme {
  final TextStyle regular;
  const AppTextTheme({required this.regular});

  factory AppTextTheme.create({color = Colors.white}) {
    return AppTextTheme(
      regular: TextStyle(
        height: 1.0,
        fontSize: 24,
        color: color,
      ),
    );
  }
}
