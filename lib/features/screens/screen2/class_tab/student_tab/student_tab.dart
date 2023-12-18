import 'package:auto_size_text/auto_size_text.dart';
import 'package:eschool_teacher/features/model/class_subject.dart';
import 'package:eschool_teacher/features/screens/screen2/class_tab/student_tab/student_details.dart';
import 'package:eschool_teacher/features/services/feature_services.dart';
import 'package:eschool_teacher/utils/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../api.dart';
import '../../../../../constants/colors.dart';
import '../../../../authentication/providers/auth_provider.dart';
import '../../../../services/student_services.dart';

class ApiStudents extends ConsumerWidget {

  final int class_id;
  final String className;
  final String section;
  final int sec_id;

  ApiStudents({required this.class_id,required this.section,required this.className, required this.sec_id});






  @override
  Widget build(BuildContext context,ref) {


    final auth = ref.watch(authProvider);
    final studentList = ref.watch(classWiseStudentProvider(sec_id));



    return Container(
      height: 200.h,
      // color: Colors.red,
      child: studentList.when(
          data: (student_data) {
            student_data.sort((a, b) => a.rollNo.compareTo(b.rollNo));
            return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: student_data.length,
                itemBuilder: (context, index) {

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Card(
                      elevation: 8,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 8.h),
                        
                          onTap: () => Get.to(() => StudentDetails(
                            student_id: student_data[index].student.id,
                            className: className,
                            section: section,
                            student: student_data[index],
                          )),
                        

                        
                        
                        
                        leading:student_data[index].student.studentPhoto!=null?  CircleAvatar(
                          radius: 20.sp,
                          backgroundImage: NetworkImage('${Api.basePicUrl}${student_data[index].student.studentPhoto}'),
                        ):  CircleAvatar(
                          radius: 20.sp,
                          backgroundColor: Colors.black,
                        ),

                        title: Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 8.w),
                          child: AutoSizeText(
                            student_data[index].student.studentName,
                            style: TextStyle(color: Colors.black),
                            maxLines: 1,
                          ),
                        ),
                        trailing: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Text('Roll no. ${student_data[index].rollNo}',style: TextStyle(color: Colors.black),),
                        ),
                      ),
                    ),
                  );
                });
          },
          error: (err, stack) => Center(child: Text('$err')),
          loading: () => ShimmerListTile()),
    );
  }
}
