




import 'package:eschool_teacher/features/model/exam_model.dart';
import 'package:eschool_teacher/features/screens/screen2/exam_tabs/exam_class_detail.dart';
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

class ExamClasses extends ConsumerWidget {
  final ExamDetail examDetail;

  ExamClasses({required this.examDetail});

  @override
  Widget build(BuildContext context,ref) {

    final auth = ref.watch(authProvider);
    final String token = auth.user.token;
    final teacherClass = ref.watch(teacherSubList(token));
    final infoData = ref.watch(employeeList(auth.user.token));
    final classList = ref.watch(examClassList(auth.user.token));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text(examDetail.name, style: TextStyle(color: Colors.white),),
      ),
      backgroundColor: Colors.white,
      body:Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Container(
            // color: Colors.blue,
              height: MediaQuery.of(context).size.height * 4.1/5,
              // padding: EdgeInsets.only(left: 30.w),

              child: teacherClass.when(
                data: (teacher_class) {
                  return classList.when(
                    data: (data) {
                      final exam_data = data.where((element) => element.exam.id == examDetail.id).toList();
                      List<TeacherClass> class_data = [];
                      for (var i = 0; i < exam_data.length; i++) {
                        List<TeacherClass> filtered = teacher_class.where((element) => element.classSection.className.id == exam_data[i].examClass.id).toList();
                        class_data.addAll(filtered);
                      }
                      if (class_data.isNotEmpty) {
                        return ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            shrinkWrap: true,
                            itemCount: class_data.length,
                            itemBuilder: (context,index) {
                              final exam_class= exam_data.firstWhere((element) => element.examClass.id==class_data[index].classSection.className.id);
                              return InfoTileWidget(
                                  title: 'Class ${class_data[index].classSection.className.classLevel.name} - ${class_data[index].classSection.section.sectionName}',
                                  onTap: () {

                                      Get.to(()=>ExamClassDetails(examDetail: examDetail, classInfo: class_data[index], examClass: exam_class));


                                  }
                              );
                            }
                        );
                      }
                      return Center(
                        child: Container(
                            child: Text('No Classes',style: TextStyle(color: Colors.black),)
                        ),
                      );
                    },
                    error: (err, stack) => Center(child: Text('$err')),
                    loading: () => ShimmerListTile(),
                  );
                },
                error: (err, stack) => Center(child: Text('$err')),
                loading: () => ShimmerListTile(),
              )


          ),
        ],
      ) ,
    );
  }
}
