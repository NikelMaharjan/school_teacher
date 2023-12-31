import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../constants/colors.dart';

class StudentResult extends StatelessWidget {
  const StudentResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.8 / 5,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(25))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 120.w,
                      ),
                    ],
                  ),
                  Text('Result',
                      style: TextStyle(color: Colors.white, fontSize: 20.sp)),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
