import 'package:eschool_teacher/features/authentication/providers/auth_provider.dart';
import 'package:eschool_teacher/features/screens/screen2/class_tab/subjects_tab/subject_page.dart';
import 'package:eschool_teacher/utils/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../constants/colors.dart';
import '../../../../services/feature_services.dart';




class MyClass extends ConsumerWidget {


  final int class_sec_id;
  final String class_level_name;
  final String sec_name;
  final int teacher_id;
  MyClass({required this.class_sec_id,required this.sec_name,required this.class_level_name,required this.teacher_id});



  @override
  Widget build(BuildContext context,ref) {

    final auth = ref.watch(authProvider);

    final classSecSubjects = ref.watch(classSecSubjectProvider(class_sec_id));

    return Container(
      height: 100.h,
      // color: Colors.red,
      child: classSecSubjects.when(
        data: (data) => ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
              EdgeInsets.symmetric(vertical: 8.h),
              child: Card(
                elevation: 8,
                  color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 8.w, vertical: 8.h),
                  onTap: ()=>Get.to(()=> Subjects(
                      teacher_id: teacher_id ,
                      sec_name: sec_name,
                      class_level_name: class_level_name,
                      class_sec_id: class_sec_id,
                      subject_name: data[index].subject.subjectName,
                      subject_id: data[index].subject.id,
                    class_Sec_Sub_id: data[index].id,
                    classSecSubject: data[index],
                  )),

                  leading: Container(
                    height: 60.h,
                    width: 60.h,
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(10),
                        color: Colors.lightBlueAccent),
                    child: Center(
                      child: Text(
                          data[index].subject.subjectName.substring(0,1),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  
                  title: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.w),
                    child: Text(data[index].subject.subjectName,
                        style: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                ),
              ),
            );
          },
        ),
        loading: () => ShimmerListTile(),
        error: (error, stackTrace) => Text('Error: $error'),
      ),
    );
  }
}
