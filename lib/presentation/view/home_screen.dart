import 'dart:async';

import 'package:extension_tech_task_app/constants/constants.dart';
import 'package:extension_tech_task_app/presentation/view_model/home_view_model.dart';
import 'package:extension_tech_task_app/utils/helper.dart';
import 'package:extension_tech_task_app/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    // Provider of HomeScreen
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    StreamSubscription<List<ConnectivityResult>> subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      homeViewModel.updateInternetConnection(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 2,
            shadowColor: Colors.grey.shade100,
            backgroundColor: Colors.white,
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
            ]),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ListTile(
                  title: Text('Hello, Shashwat',),
                  subtitle: Text('shashwatdhingra2@gmail.com'),
                  leading: CircleAvatar(child: Icon(Icons.person, color: Colors.white,), backgroundColor: Colors.black,),
                ),
                24.ph,
                Consumer<HomeViewModel>(
                    builder: (context, value, child) => Center(
                          child: SizedBox(
                            width: 220,
                            height: 52,
                            child: Container(
                              padding: EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade700,
                                  borderRadius: BorderRadius.circular(8)),
                              child: CupertinoButton(
                                  onPressed: value.hasLastCheckIn
                                      ? value.onCheckOutButtonTap
                                      : value.onCheckInButtonTap,
                                  color: value.hasLastCheckIn
                                      ? Colors.white
                                      : Colors.black,
                                  child: value.isButtonLoading
                                      ? SizedBox.square(
                                          // dimension: 20,
                                          child: SizedBox.square(
                                            dimension: 22,
                                            child: CircularProgressIndicator(
                                                color: value.hasLastCheckIn ? Colors.black : Colors.white,
                                                strokeWidth: 1),
                                          ))
                                      : value.hasLastCheckIn
                                          ? const Text(
                                              'CheckOut',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            )
                                          : const Text('CheckIn')),
                            ),
                          ),
                        )),
                52.ph,
                const Text(
                  'Employee Check-In Data',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                const Divider(),
                Consumer<HomeViewModel>(
                    builder: (context, value, child) => value
                            .isInternetConnected
                        ? value.isCheckInListLoading
                            ? const Expanded(
                                child:
                                    Center(child: CircularProgressIndicator()))
                            : Expanded(
                                child: Column(
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Total entries : ${value.checkInList!.data!.length}',
                                          style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w500),
                                        )),
                                    Expanded(
                                      child: ListView.builder(
                                        padding: const EdgeInsets.all(8.0),
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) =>
                                            ListTile(
                                          leading: const Icon(
                                              Icons.arrow_right_outlined),
                                          title: Text(
                                            value.checkInList!.data![index]
                                                .name!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        itemCount:
                                            value.checkInList!.data!.length,
                                      ),
                                    )
                                  ],
                                ),
                              )
                        : const Expanded(
                            child: Center(
                                child: Text(
                                    'No Internet Connection \nYou can still Check-In and Check-Out!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 22,
                                        color: Colors.grey)))))
              ]),
        ));
  }
}
