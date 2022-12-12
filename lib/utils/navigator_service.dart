import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState currentState() => navigatorKey.currentState!;

  BuildContext get context => navigatorKey.currentContext!;
}
