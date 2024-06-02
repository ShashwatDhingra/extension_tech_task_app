import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static showToast(String message, bool isError) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: isError ? Colors.red : Colors.black,
        textColor: Colors.white);
  }
}

extension MySizedBox on num {
  SizedBox get ph => SizedBox(height: toDouble());
  SizedBox get pw => SizedBox(width: toDouble());
}
