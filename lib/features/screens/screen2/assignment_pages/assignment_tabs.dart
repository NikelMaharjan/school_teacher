




import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../constants/colors.dart';
import '../../../../exceptions/internet_exceptions.dart';
import '../../../model/assignment.dart';
import 'assignment_details.dart';
import 'assignment_student.dart';

class AssignmentTabs extends ConsumerStatefulWidget {


  final Assignment assignment;
  final int class_subject_id;
  AssignmentTabs({required this.assignment, required this.class_subject_id});

  @override
  ConsumerState<AssignmentTabs> createState() => _AssignmentTabState();
}

class _AssignmentTabState extends ConsumerState<AssignmentTabs> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {






    TabController tabController = TabController(length: 2, vsync: this);
    return ConnectivityChecker(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 1.4 / 5,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(25))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      ],
                    ),

                    Center(
                      child: Text('Class ${widget.assignment.classSubject.classSection!.className.classLevel.name} ${widget.assignment.classSubject.classSection!.section.sectionName}',
                          style: TextStyle(color: Colors.white, fontSize: 25.sp)),
                    ),

                    Text(widget.assignment.classSubject.subject.subjectName, style: const TextStyle(color: Colors.white),),




                    SizedBox(
                      height: 10.h,
                    ),
                    TabBar(
                        controller: tabController,
                        padding: EdgeInsets.symmetric(
                            vertical: 15.h, horizontal: 30.w),
                        labelStyle: TextStyle(
                          fontSize: 18.sp,
                        ),
                        unselectedLabelStyle: TextStyle(
                          fontSize: 18.sp,
                        ),
                        isScrollable: false,
                        labelPadding: EdgeInsets.only(left: 15.w, right: 15.w),
                        labelColor: primary,
                        unselectedLabelColor: Colors.white,
                        // indicatorColor: primary,
                        indicator: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        tabs: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Tab(
                              text: 'Task',
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Tab(text: 'Students'),
                          ),
                        ])
                  ],
                )),
            Container(
              // color: Colors.red,
                height: MediaQuery.of(context).size.height * 3.6 / 5,
                child: TabBarView(
                  // physics: NeverScrollableScrollPhysics(),

                  controller: tabController,
                  children: [
                    AssignmentDetails(
                       id: widget.assignment.id,
                      assignment: widget.assignment,
                      classSubject : widget.assignment.classSubject,
                      class_subject_id: widget.class_subject_id,
                    ),
                    Student_Assignment(
                      assignment: widget.assignment,
                      class_id: widget.assignment.classSubject.classSection!.id,
                      section: widget.assignment.classSubject.classSection!.section.sectionName,
                      className: widget.assignment.classSubject.classSection!.className.classLevel.name,
                    )],
                  //MyClass(id: class_id, school_id: school_id, class_teacher: class_teacher, teacher_subject: teacher_subject, classSub_id: classSub_id,)
                )),
          ],
        ),

      ),
    );
  }
}
