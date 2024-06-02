import 'package:extension_tech_task_app/presentation/view/home_screen.dart';
import 'package:extension_tech_task_app/presentation/view/splash_screen.dart';
import 'package:extension_tech_task_app/utils/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case Routes.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
        
      default:
        return _errorRoute();
    }
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
