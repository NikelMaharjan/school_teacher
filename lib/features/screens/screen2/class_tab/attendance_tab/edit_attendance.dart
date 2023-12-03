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
import '../../../../model/attendance_student.dart';
import '../../../../services/feature_services.dart';
import '../../../../../utils/commonWidgets.dart';

class EditAttendance extends ConsumerStatefulWidget {
  final int class_id;
  final Attendance attendance;

  EditAttendance({required this.class_id,required this.attendance});

  @override
  ConsumerState<EditAttendance> createState() => _TestAttendanceState();
}

class _TestAttendanceState extends ConsumerState<EditAttendance> {
  Map<int, bool> toggleStates = {};
  final String date = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final studentList = ref.watch(classWiseStudentProvider(widget.class_id));
    final attendanceDate = ref.watch(attendanceDateStudent(auth.user.token));
    final attendload = ref.watch(attendanceProvider);
    final attendanceList = ref.watch(studentClassAttendanceProvider(widget.attendance.id));


    return Scaffold(
      backgroundColor: Colors.white,
      body: attendanceList.when(
        data: (data){
          return Column(
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.9 / 5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(25))),
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
                            icon: Icon(
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
                        '${DateFormat('yyyy-MM-dd').format(DateTime.now())}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )),

              Expanded(
                child: ListView.builder(
                    itemCount: data.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      if (!toggleStates.containsKey(data[index].student.id)) {
                        if(data[index].status == 'Present'){
                          toggleStates[data[index].student.id] = true;
                        }
                        else{
                          toggleStates[data[index].student.id] = false;
                        }

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
                            leading:data[index].student.studentPhoto!=null?  CircleAvatar(
                              radius: 20.sp,
                              backgroundImage: NetworkImage('${Api.basePicUrl}${data[index].student.studentPhoto}'),
                            ):  CircleAvatar(
                              radius: 20.sp,
                              backgroundColor: Colors.black,
                            ),
                            title:  Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Text(
                                data[index].student.studentName,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            trailing: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: toggleStates[data[index].student.id]! ? primary : abs_color,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),

                              onPressed: () {
                                setState(() {
                                  toggleStates[data[index].student.id] = !toggleStates[data[index].student.id]!;
                                });
                              },
                              child: toggleStates[data[index].student.id]!
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
                          side: BorderSide(
                            color: Colors.black,
                          ))),
                  onPressed: () async {
                    for (var i = 0; i < data.length; i++) {
                      if (toggleStates[data[i].student.id] == true) {
                        await ref.read(attendanceProvider.notifier).editAttendanceStudent(
                            token: auth.user.token,
                            attendance: data[i].attendance.id,
                            student: data[i].student.id,
                            status: 'Present',
                            id: data[i].id
                        );
                      }
                      else {
                        await ref.read(attendanceProvider.notifier).editAttendanceStudent(
                            token: auth.user.token,
                            attendance: data[i].attendance.id,
                            student: data[i].student.id,
                            status: 'Absent',
                            id:data[i].id
                        );
                      }
                    }
                    ref.refresh(studentClassAttendanceProvider(widget.attendance.id));
                    Navigator.pop(context);
                  },

                  child:attendload.isLoad? CircularProgressIndicator(): Text(
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
        loading: () => Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

