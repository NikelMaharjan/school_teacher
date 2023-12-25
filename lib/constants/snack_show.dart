import 'package:eschool_teacher/constants/colors.dart';
import 'package:flutter/material.dart';

class SnackShow {
  static showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: bgColor,

      content: Text(message,style: TextStyle(color: Colors.white),),
      duration: Duration(seconds: 2),
    ));
  }

  static showFailure(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(message,style: TextStyle(color: Colors.white)),
      duration: Duration(seconds: 3),
    ));
  }
}
