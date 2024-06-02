import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:extension_tech_task_app/models/checkin_model.dart';
import 'package:extension_tech_task_app/models/employee_checkin_model.dart';
import 'package:extension_tech_task_app/repository/checkin_repository.dart';
import 'package:extension_tech_task_app/utils/helper.dart';
import 'package:extension_tech_task_app/utils/utils.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  bool isButtonLoading = false;
  bool isCheckInListLoading = false;
  bool isInternetConnected = false;
  bool hasLastCheckIn = false;
  CheckInRepository checkInRepo = CheckInRepository();
  DBHelper dbHelper = DBHelper();
  PrefHelper prefHelper = PrefHelper();
  EmployeeCheckInModel? checkInList;

  HomeViewModel() {
    checkInternetConnection();
    getEmployeeCheckIns();
    getLastCheckInStatus();
  }

  Future<void> updateInternetConnection(List<ConnectivityResult> result) async {
    log('Updating Internet Connection Flag');
    if (result.contains(ConnectivityResult.none)) {
      isInternetConnected = false;
      notifyListeners();
    } else {
      isInternetConnected = true;
      notifyListeners();
      await syncData();
      getEmployeeCheckIns();
    }
  }

  Future<void> checkInternetConnection() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.none)) {
      isInternetConnected = false;
    } else {
      isInternetConnected = true;
    }

    notifyListeners();
  }

  Future<void> syncData() async {
    final pendingCheckIns = await DBHelper().getPendingCheckIns();
    pendingCheckIns.forEach((checkIn) async {
      try {
        toggleButtonLoading(true);
        // Sycing the Check-In on Network
        final response = await checkInRepo.createCheckInOut(checkIn);

        if (response['data'] != null) {
          getEmployeeCheckIns();
        } else {
          Utils.showToast('Can\'t Check-In right now!', true);
        }
      } catch (e) {
        log(e.toString());
      } finally {
        toggleButtonLoading(false);
      }
    });

    dbHelper.clearDatabase();
  }

  Future<void> onCheckInButtonTap() async {
    toggleButtonLoading(true);
    try {
      if (isInternetConnected) {
        // Check-In directly on Network
        final response = await checkInRepo.createCheckInOut(CheckInModel(
            employee: 'HR-EMP-00002',
            employeeName: 'Ashish',
            logType: "IN",
            time: DateTime.now(),
            customLatitude: "23.2599333",
            customLongitude: "77.41261499999996"));

        if (response['data'] != null) {
          // Saving the state of Check-In Button
          await prefHelper.updateCheckInStatus(true);

          getEmployeeCheckIns();
          getLastCheckInStatus();
        } else {
          Utils.showToast('Can\'t Check-In right now!', true);
        }
      } else {
        // Save Check-In in offline database.
        await dbHelper.insertCheckIn(CheckInModel(
            employee: 'HR-EMP-00002',
            employeeName: 'Ashish',
            logType: "IN",
            time: DateTime.now(),
            customLatitude: "23.2599333",
            customLongitude: "77.41261499999996"));

        // Saving the state of Check-In Button
        await prefHelper.updateCheckInStatus(true);

        getLastCheckInStatus();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      toggleButtonLoading(false);
    }
  }

  Future<void> onCheckOutButtonTap() async {
    toggleButtonLoading(true);
    try {
      if (isInternetConnected) {
        // Check-In directly on Network
        final response = await checkInRepo.createCheckInOut(CheckInModel(
            employee: 'HR-EMP-00002',
            employeeName: 'Ashish',
            logType: "OUT",
            time: DateTime.now(),
            customLatitude: "23.2599333",
            customLongitude: "77.41261499999996"));

        if (response['data'] != null) {
          // Saving the state of Check-In Button
          await prefHelper.updateCheckInStatus(false);

          getEmployeeCheckIns();
          getLastCheckInStatus();
        } else {
          Utils.showToast('Can\'t Check-In right now!', true);
        }
      } else {
        // Save Check-In in offline database.
        await dbHelper.insertCheckIn(CheckInModel(
            employee: 'HR-EMP-00002',
            employeeName: 'Ashish',
            logType: "OUT",
            time: DateTime.now(),
            customLatitude: "23.2599333",
            customLongitude: "77.41261499999996"));

        await prefHelper.updateCheckInStatus(false);
        getLastCheckInStatus();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      toggleButtonLoading(false);
    }
  }

  Future<void> getEmployeeCheckIns() async {
    toggleCheckInListLoading(true);
    try {
      checkInList = await checkInRepo.getEmployeeCheckIn();
    } catch (e) {
      log(e.toString());
    } finally {
      toggleCheckInListLoading(false);
    }
  }

  void getLastCheckInStatus() {
    hasLastCheckIn = prefHelper.getBool(PrefHelper.IS_CHECKIN) ?? false;
    notifyListeners();
  }

  void toggleButtonLoading(bool value) {
    isButtonLoading = value;
    notifyListeners();
  }

  void toggleCheckInListLoading(bool value) {
    isCheckInListLoading = value;
    notifyListeners();
  }
}
