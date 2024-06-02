import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static showToast(String message, bool isError) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: isError ? Colors.red : Colors.black,
        textColor: Colors.white);
  }

  static Widget getLoader({Color color = Colors.black}) {
    return CircularProgressIndicator(
      color: color,
      strokeWidth: 1,
    );
  }
}

extension MySizedBox on num {
  SizedBox get ph => SizedBox(height: toDouble());
  SizedBox get pw => SizedBox(width: toDouble());
}
