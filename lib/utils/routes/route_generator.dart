import 'package:extension_tech_task_app/presentation/view/home/screens/home_screen.dart';
import 'package:extension_tech_task_app/presentation/view/splash/screens/splash_screen.dart';
import 'package:extension_tech_task_app/utils/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return getCustomRoute(const SplashScreen());

      case Routes.homeScreen:
        return getCustomRoute(const HomeScreen());

      default:
        return _errorRoute();
    }
  }

  static CupertinoPageRoute getCustomRoute(Widget screen) {
    return CupertinoPageRoute(
      builder: (context) => screen
    );
  }

  static Route<dynamic> _errorRoute() {
    return CupertinoPageRoute(
      builder: (context) {
        return Scaffold(
            appBar: AppBar(title: const Text('ERROR')),
            body: const Center(child: Text('ERROR')));
      },
    );
  }
}
