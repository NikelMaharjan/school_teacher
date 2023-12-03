import 'package:flutter/material.dart';

class SnackShow {
  static showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message,style: TextStyle(color: Colors.black),),
      duration: Duration(seconds: 1),
    ));
  }

  static showFailure(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.black,
      content: Text(message,style: TextStyle(color: Colors.white)),
      duration: Duration(seconds: 1),
    ));
  }
}
