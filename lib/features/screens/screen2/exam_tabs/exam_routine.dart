import 'package:eschool_teacher/constants/colors.dart';
import 'package:eschool_teacher/exceptions/internet_exceptions.dart';
import 'package:eschool_teacher/features/model/exam_model.dart';
import 'package:eschool_teacher/features/screens/homepage/time_schedule/routine_tab.dart';
import 'package:eschool_teacher/features/screens/screen2/exam_tabs/exan_routine_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';




class ExamRoutineTable extends StatefulWidget {
  final ExamClass examClass;

  ExamRoutineTable({required this.examClass});

  @override
  State<ExamRoutineTable> createState() => _ExamRoutineTableState();
}

class _ExamRoutineTableState extends State<ExamRoutineTable> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 7, vsync: this);
    return ConnectivityChecker(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 120.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(40),
                  ),
                  color: Color(0xff205578)),
            ),
            Center(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 1 / 6,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(40),
                        ),
                        color: Color(0xff205578)),
                    child: Center(
                      child: Text('Schedule',
                          style: TextStyle(fontSize: 20.sp, color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                      height: 50.h,
                      // width: 280.h,
                      child: TabBar(
                          labelStyle: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.bold),
                          unselectedLabelStyle: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.bold),
                          controller: _tabController,
                          isScrollable: true,
                          labelPadding: EdgeInsets.only(left: 15.w, right: 15.w),
                          labelColor: Colors.white,
                          unselectedLabelColor: primary,
                          indicator: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(10)),
                          tabs: [
                            Tab(text: 'MON'),
                            Tab(text: 'TUE'),
                            Tab(text: 'WED'),
                            Tab(text: 'THU'),
                            Tab(text: 'FRI'),
                            Tab(text: 'SAT'),
                            Tab(text: 'SUN'),
                          ])),
                  Container(
                    width: 350.w,
                    height: MediaQuery.of(context).size.height * 4 / 6,
                    child: TabBarView(controller: _tabController, children: [
                      ExamRoutineTab(day: 'Monday',examClass: widget.examClass,),
                      ExamRoutineTab(day: 'Tuesday',examClass: widget.examClass,),
                      ExamRoutineTab(day: 'Wednesday',examClass: widget.examClass,),
                      ExamRoutineTab(day: 'Thursday',examClass: widget.examClass,),
                      ExamRoutineTab(day: 'Friday',examClass: widget.examClass,),
                      ExamRoutineTab(day: 'Saturday',examClass: widget.examClass,),
                      ExamRoutineTab(day: 'Sunday',examClass: widget.examClass,),


                    ]),
                  )
                ],
              ),
            ),
            Positioned(
              left: 15.w,
              top: 40.h,
              child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 25.sp)),
            ),
          ],
        ),
      ),
    );
  }
}
