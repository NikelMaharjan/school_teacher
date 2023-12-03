import 'package:eschool_teacher/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../screen2/create_pages/add_lesson2.dart';
import '../../screen2/lesson_tabs/lesson_tabs.dart';

class LessonPage extends StatefulWidget {
  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 1, vsync: this);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.7 / 5,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(25))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Lessons',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40.h,
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 10.h,
                  ),
                ],
              )),
          Container(
              height: MediaQuery.of(context).size.height * 4.8 / 6,
              width: 360.w,
              child: LessonTabs())
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddLesson2()),
        backgroundColor: primary,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
