import 'package:eschool_teacher/constants/snack_show.dart';
import 'package:eschool_teacher/features/authentication/providers/auth_provider.dart';
import 'package:eschool_teacher/features/providers/attendance_provider.dart';
import 'package:eschool_teacher/features/services/attendance_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../../constants/colors.dart';
import '../../../../../api.dart';
import '../../../../services/feature_services.dart';
import '../../../../../utils/commonWidgets.dart';

class Attendance_add extends ConsumerStatefulWidget {
  final int class_id;

  const Attendance_add({super.key, required this.class_id});

  @override
  ConsumerState<Attendance_add> createState() => _Attendance_addState();
}

class _Attendance_addState extends ConsumerState<Attendance_add> {
  Map<int, bool> toggleStates = {};
  final String date = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final studentList = ref.watch(classWiseStudentProvider(widget.class_id));
    final attendanceDate = ref.watch(attendanceDateStudent(auth.user.token));
    final attendload = ref.watch(attendanceProvider);




    return Scaffold(
      backgroundColor: Colors.white,
      body: attendanceDate.when(
        data: (data) {
          final attendDate = data.firstWhere((element) => element.date == date);
          return studentList.when(
            data: (studData) {
              return Column(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height * 0.9 / 5,
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
                                width: 80.w,
                              ),
                            ],
                          ),
                          Text('Take Attendance',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.sp)),
                          Text(
                            attendDate.date,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )),
                  Expanded(
                    child: ListView.builder(
                        itemCount: studData.length,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          if (!toggleStates.containsKey(studData[index].student.id)) {
                            toggleStates[studData[index].student.id] = true;
                          }
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.h),
                            child: Card(
                              elevation: 8,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                                leading: studData[index].student.studentPhoto!=null?  CircleAvatar(
                                  radius: 20.sp,
                                  backgroundImage: NetworkImage('${Api.basePicUrl}${studData[index].student.studentPhoto}'),
                                ):  CircleAvatar(
                                  radius: 20.sp,
                                  backgroundColor: Colors.black,
                                ),
                                title: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        studData[index].student.studentName,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        'Roll no. ${studData[index].rollNo}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                trailing: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: toggleStates[studData[index].student.id]! ? primary : abs_color,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.all(0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      toggleStates[studData[index].student.id] = !toggleStates[studData[index].student.id]!;
                                    });
                                  },
                                  child: toggleStates[studData[index].student.id]!
                                      ? Text(
                                    'Present',
                                    style: TextStyle(fontSize: 12.sp),
                                  )
                                      : Text(
                                    'Absent',
                                    style: TextStyle(fontSize: 12.sp),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: primary,
                          foregroundColor: Colors.white,
                          fixedSize: Size.fromWidth(320.w),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                color: Colors.black,
                              ))),
                      onPressed: () async {
                        for (var i = 0; i < studData.length; i++) {
                          if (toggleStates[studData[i].student.id] == true) {
                            await ref.read(attendanceProvider.notifier).addAttendanceStudent(
                                token: auth.user.token,
                                attendance: attendDate.id,
                                student: studData[i].student.id,
                                status: 'Present'
                            );
                          }
                          else {
                            await ref.read(attendanceProvider.notifier).addAttendanceStudent(
                                token: auth.user.token,
                                attendance: attendDate.id,
                                student: studData[i].student.id,
                                status: 'Absent'
                            );
                          }
                        }
                       Navigator.pop(context);
                      },

                      child:attendload.isLoad? const CircularProgressIndicator(): Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
            error: (err, stack) => Center(child: Text('$err')),
            loading: () => const ShimmerListTile(),
          );
        },
        error: (err, stack) => Center(child: Text('$err')),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

