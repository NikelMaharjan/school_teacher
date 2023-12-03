import 'package:eschool_teacher/constants/colors.dart';
import 'package:eschool_teacher/exceptions/internet_exceptions.dart';
import 'package:eschool_teacher/features/screens/homepage/time_schedule/routine_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../default_teacher.dart';




class TimeTable extends StatefulWidget {
  const TimeTable({Key? key}) : super(key: key);

  @override
  State<TimeTable> createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 7, vsync: this);
    return ConnectivityChecker(
      child: Scaffold(
        appBar: AppBar(
          title: Text("TIme Table", style: TextStyle(color: Colors.white),),
          backgroundColor: bgColor,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [

            SizedBox(height: 20,),

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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Tab(text: 'MON'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Tab(text: 'TUE'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Tab(text: 'WED'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Tab(text: 'THU'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Tab(text: 'FRI'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Tab(text: 'SAT'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Tab(text: 'SUN'),
                      ),
                    ])),
            Container(
              width: 350.w,
              height: MediaQuery.of(context).size.height * 4 / 6,
              child: TabBarView(controller: _tabController, children: [
                Routine(day: 'Monday',),
                Routine(day: 'Tuesday',),
                Routine(day: 'Wednesday',),
                Routine(day: 'Thursday'),
                Routine(day: 'Friday'),
                Routine(day: 'Saturday'),
                Routine(day: 'Sunday'),

              ]),
            )
          ],
        ),
      ),
    );
  }
}
