import 'package:eschool_teacher/constants/colors.dart';
import 'package:eschool_teacher/features/screens/screen2/class_tab/subjects_tab/subject_plan/subject_plan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../model/class_subject.dart';



class Chapters extends StatelessWidget {
  final ClassSecSubject classSecSubject;
  final String className;
  final String section ;


  Chapters({required this.classSecSubject,required this.className,required this.section});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width : 350.w,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
            child: Card(
              elevation: 8,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding:
                EdgeInsets.symmetric(horizontal:15.w, vertical: 8.h),
                onTap: ()=>Get.to(()=>SubjectPlan(classSecSubject: classSecSubject,className: className,section: section,)),
                title: Text('Subject Plan',style: TextStyle(color: Colors.black,fontSize: 15.sp),),
                trailing: const Icon(Icons.arrow_circle_right_rounded,color: Colors.black,),
              ),
            ),
          ),
        ),
        Container(
          width: 350.w,

          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 15.w),
                child: Card(
                  elevation: 8,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    // onTap: ()=>Get.to(()=>AssignmentPage()),
                    title: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Lesson name',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 12.sp)),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.edit,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  Icon(
                                    Icons.delete,
                                    color: abs_color,
                                  )
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          const Text('Lesson 1',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 30.h,
                          ),
                          Text('Lesson description',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12.sp)),
                          SizedBox(
                            height: 10.h,
                          ),
                          const Text('Basic Lessons',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
