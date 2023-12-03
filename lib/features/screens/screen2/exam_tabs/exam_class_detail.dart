




import 'package:eschool_teacher/features/model/exam_model.dart';
import 'package:eschool_teacher/features/services/feature_services.dart';
import 'package:eschool_teacher/features/screens/screen2/exam_tabs/exam_routine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../../utils/commonWidgets.dart';
import '../../../authentication/providers/auth_provider.dart';
import '../../../model/teacher_features.dart';
import '../../../services/exam_services.dart';
import '../../../services/info_services.dart';

class ExamClassDetails extends ConsumerWidget {
  final ExamDetail examDetail;
  final TeacherClass classInfo;
  final ExamClass examClass;

  ExamClassDetails({required this.examDetail,required this.classInfo,required this.examClass});

  @override
  Widget build(BuildContext context,ref) {

    final auth = ref.watch(authProvider);
    final String token = auth.user.token;
    final classSubject= ref.watch(secWiseSubjectProvider(classInfo.classSection.id));
    final teacherClass = ref.watch(teacherSubList(token));
    final infoData = ref.watch(employeeList(auth.user.token));
    final classList = ref.watch(examClassList(auth.user.token));
    final examClassInfo = ref.watch(classWiseExamProvider(examClass.id));

    print(examClass.id);

    return Scaffold(
      backgroundColor: Colors.white,
      body:Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.8 / 5,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(25))),
              child: Column(
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
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text(examDetail.name,style: TextStyle(color: Colors.white,fontSize: 25.sp),),
                        Text('Class ${classInfo.classSection.className.classLevel.name} - ${classInfo.classSection.section.sectionName}',style: TextStyle(color: Colors.white,fontSize: 15.sp),),

                      ],
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: 10.h,
          ),
          CommonCard2(
            onTap:()=> Get.to(()=>ExamRoutineTable(examClass: examClass,)),
              title: 'Routine',

          ),
          CommonCard2(
              title: 'Students',

          ),
          Divider(
            thickness: 1,
            color: Colors.black,
            indent: 15.w,
            endIndent: 15.w,

          ),
          Container(

            // color: Colors.red,
            child: classSubject.when(
              data: (data) {
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 30.w),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final subjectName = data[index].subject.subjectName;
                    final marks = '-';
                    return Table(
                      children: [
                        TableRow(
                          children: [
                            index == 0 ? Text('Subject',style: TextStyle(color: Colors.black,fontSize: 22.sp),) : SizedBox.shrink(),
                            index == 0 ? Text('Marks',style: TextStyle(color: Colors.black,fontSize: 22.sp),) : SizedBox.shrink(),
                          ],
                        ),
                        TableRow(

                          children: [
                            Text(subjectName,style: TextStyle(color: Colors.black,fontSize: 18.sp),),
                            Text('$marks',style: TextStyle(color: Colors.black,fontSize: 18.sp),),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
              error: (err, stack) => Center(child: Text('$err')),
              loading: () => Center(child: CircularProgressIndicator()),
            ),

          ),
        ],
      ) ,
    );
  }
}
