// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class fluttertoast {
  void toast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
