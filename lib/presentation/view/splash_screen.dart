import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:extension_tech_task_app/constants/constants.dart';
import 'package:extension_tech_task_app/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  void navigateToHome() async {
    await Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.homeScreen, (route) => false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Shimmer.fromColors(
            baseColor: Colors.blue.shade700,
            highlightColor: Colors.white,
            loop: 3,
            child: Image.asset(extensionLogo)),
      ),
    );
  }
}
