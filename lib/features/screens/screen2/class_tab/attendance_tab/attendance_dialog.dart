

import 'package:eschool_teacher/constants/colors.dart';
import 'package:eschool_teacher/features/authentication/providers/auth_provider.dart';
import 'package:eschool_teacher/features/providers/attendance_provider.dart';
import 'package:eschool_teacher/features/services/attendance_services.dart';
import 'package:eschool_teacher/features/screens/screen2/class_tab/attendance_tab/attendance.dart';
import 'package:eschool_teacher/features/screens/screen2/class_tab/attendance_tab/edit_attendance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AttendanceAlertDialog extends ConsumerStatefulWidget {
  final int class_sec_id;
  final int teacher_id;
  final String className;
  final String section;

  AttendanceAlertDialog({required this.class_sec_id,required this.teacher_id,required this.className,required this.section});

  @override
  ConsumerState<AttendanceAlertDialog> createState() => _AttendanceAlertDialogState();
}

class _AttendanceAlertDialogState extends ConsumerState<AttendanceAlertDialog> {
  @override
  Widget build(BuildContext context) {

    final String date = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();

    final auth=ref.watch(authProvider);
    final attend=ref.watch(attendanceProvider);
    final attendanceDate = ref.watch(attendanceDateStudent(auth.user.token));
    print('attend class id ${widget.class_sec_id}');
    print('teacher id ${widget.teacher_id}');

    return attendanceDate.when(
        data: (data){
          final attendDate = data.firstWhereOrNull((element) => element.date == date && element.addedBy.id == widget.teacher_id);
          if(attendDate == null){
            return AlertDialog(

              shape: RoundedRectangleBorder(borderRadius:
              BorderRadius.all(Radius.circular(10))),
              backgroundColor: Colors.white,
              title: Text("Create Attendance",style: TextStyle(color: Colors.black),),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Class: ${widget.className} ${widget.section}',style: TextStyle(color: Colors.black),),
                  Text('Date: $date',style: TextStyle(color: Colors.black),)
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: attend.isLoad ? CircularProgressIndicator() : Text("Yes"),
                  onPressed: () {
                    ref.read(attendanceProvider.notifier).addDate(
                        token: auth.user.token,
                        date: date,
                        bachelorClass: false,
                        classSection: widget.class_sec_id,
                        teacher_id: widget.teacher_id
                    ).then((value) => ref.refresh(attendanceDateStudent(auth.user.token))).then((value) {
                      Future.delayed(const Duration(milliseconds: 600), () {
                        setState(() {
                          Navigator.pop(context);
                          Get.to(()=>Attendance_add(class_id: widget.class_sec_id));
                        });

                      });

                    });
                  },
                ),
                TextButton(
                  child: Text("No"),
                  onPressed: () {
                    // Perform some action
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
          else {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius:
              BorderRadius.all(Radius.circular(15))),
              backgroundColor: Colors.white,
              title: Text("Attendance Already Added",style: TextStyle(color: Colors.black),),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Class: ${widget.className} ${widget.section}',style: TextStyle(color: Colors.black),),
                  Text('Date: $date',style: TextStyle(color: Colors.black),),
                  SizedBox(height: 5.h,),
                  Text('Go to Attendance page ?',style: TextStyle(color: Colors.black,fontSize: 12.sp),)
                ],
              ),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: primary
                  ),
                  child: attend.isLoad
                      ? CircularProgressIndicator()
                      : Text("Yes",style: TextStyle(color: Colors.white),),
                  onPressed: () {
                    Navigator.pop(context);
                    Get.to(()=>EditAttendance(class_id: widget.class_sec_id ,attendance: attendDate,));
                  },
                ),
                TextButton(
                  child: Text("No",style: TextStyle(color: Colors.black),),
                  onPressed: () {
                    // Perform some action
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
        },
        error: (err, stack) => Center(child: Text('$err')),
        loading: () => Center(child: CircularProgressIndicator(),)
    );
  }
}
