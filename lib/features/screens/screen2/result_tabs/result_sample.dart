import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  const Result({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1 / 5,
      child: Center(
        child: Text(
          'No Result',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
