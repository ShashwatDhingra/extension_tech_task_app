import 'package:extension_tech_task_app/constants/constants.dart';
import 'package:extension_tech_task_app/presentation/view_model/home_view_model.dart';
import 'package:extension_tech_task_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

AppBar getHomeAppBar() {
  return AppBar(
      elevation: 2,
      shadowColor: Colors.grey.shade100,
      surfaceTintColor: Colors.white,
      leading: Image.asset(extensionLogo),
      title: const Text('Extention-Erp'),
      actions: [
        Consumer<HomeViewModel>(
            builder: (context, value, child) => value.isInternetConnected
                ? const Icon(
                    Icons.wifi,
                    color: Colors.green,
                  )
                : const Icon(Icons.wifi_off_sharp, color: Colors.red)),
        12.pw
      ]);
}
