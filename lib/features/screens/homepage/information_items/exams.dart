import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../constants/colors.dart';
import '../../screen2/exam_tabs/exam_tabs.dart';

class ExamPage extends StatefulWidget {
  const ExamPage({Key? key}) : super(key: key);

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text("Exam", style: TextStyle(color: Colors.white),),
      ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 4.8 / 6,
                width: 360.w,
                child: ExamTabs())
          ],
        ));
  }
}
