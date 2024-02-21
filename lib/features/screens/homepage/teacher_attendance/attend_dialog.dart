
import 'package:dart_ipify/dart_ipify.dart';
import 'package:eschool_teacher/constants/snack_show.dart';
import 'package:eschool_teacher/features/providers/attendance_provider.dart';
import 'package:eschool_teacher/features/screens/homepage/overview.dart';
import 'package:eschool_teacher/features/screens/homepage/teacher_attendance/leave_note.dart';
import 'package:eschool_teacher/features/services/teacher_attendance_service.dart';
import 'package:eschool_teacher/teacher_attendance_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../constants/colors.dart';
import '../../../authentication/providers/auth_provider.dart';

class TeacherAttendanceDialog extends ConsumerStatefulWidget {
  final int teacher_id;
  double lat;
  double lng;
  TeacherAttendanceDialog({required this.teacher_id, required this.lat, required this.lng});
  @override
  _TeacherAttendanceState createState() => _TeacherAttendanceState();
}

class _TeacherAttendanceState extends ConsumerState<TeacherAttendanceDialog> {
  String _ipAddress = '';



  @override
  void initState() {
    super.initState();
    _getIPAddress();
  }

  Future<void> _getIPAddress() async {
    String? ipAddress = await Ipify.ipv4();
    setState(() {
      _ipAddress = ipAddress;
    });
  }



  @override
  Widget build(BuildContext context) {
    final String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
    final auth = ref.watch(authProvider);
    final attend = ref.watch(attendanceProvider);
    final attendanceDate = ref.watch(attendanceDateTeacher(auth.user.token));
    final attendanceInfo = ref.watch(teacherAttendanceProvider(widget.teacher_id));
    // List<String> parts = _ipAddress.split('.');
    // String ipWifi = parts.getRange(0,3).join('.');

    ref.listen(attendanceProvider, (previous, next) {

      if(next.isAttendanceSuccess == false){

        print(1);

        showDialog(
          barrierDismissible: false,

            context: context,
            builder: (context){
              return AlertDialog(

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),

                backgroundColor: Colors.white,
                title: Text(
                  "Error",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),),
                content: Container(
                  child:Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        next.attendanceErrorMessage!,
                        style: TextStyle(color: Colors.red),
                        maxLines: null,
                      ),
                      SizedBox(height: 5.h,),

                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: (){

                      // Get.offAll(()=> Overview());

                      Get.back();



                    },
                    child: Text("Ok"),
                  )
                ],
                actionsAlignment: MainAxisAlignment.start,
              );
            }
        );
      }
      else if(next.isAttendanceSuccess == true){

        print("2");
        // ref.invalidate(subNoticeProvider);
        // ref.invalidate(subNoticeList(auth.user.token));
        //
        // ref.invalidate(attendanceDateTeacher(auth.user.token));
        // ref.invalidate(teacherAttendanceProvider(widget.teacher_id));

        showDialog(
            barrierDismissible: false,

            context: context,
            builder: (context){
              return AlertDialog(

                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),

                backgroundColor: Colors.white,
                title: Text(
                  "Success",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),),
                content: Container(
                  child:Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                       "Your Attendance was Submitted",
                        style: TextStyle(color: bgColor),
                        maxLines: null,
                      ),
                      SizedBox(height: 5.h,),

                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: (){

                      Get.offAll(()=> Overview());


                    },
                    child: Text("Ok"),
                  )
                ],
                actionsAlignment: MainAxisAlignment.start,
              );
            }
        );
        // SnackShow.showSuccess(context, "Succefully Added");
        // Get.off(Overview());
      }
    });


    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      backgroundColor: Colors.white,
      content: attendanceDate.when(
          data: (attend_data){

            final data = attend_data.firstWhereOrNull((element) => DateFormat('yyyy-MM-dd').format(element.date).toString()== currentDate);
            if(data != null){
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(

                    children: [
                      Text(
                        'Date:',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10.w,),
                      Text(
                        '${DateFormat('yyyy-MM-dd').format(data.date)}',
                        style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 10.h,
                  ),

                  attendanceInfo.when(
                      data: (attend_info){
                        final attendance = attend_info.firstWhereOrNull((element) => element.attendance?.id == data.id);
                        if(attendance==null){
                          return  Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.h, horizontal: 8.w),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: primary,
                                      foregroundColor: Colors.white,
                                      fixedSize: Size.fromWidth(320.w),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          side: BorderSide(
                                            color: Colors.black,
                                          ))),
                                    onPressed: ()  {




                                    ref.read(attendanceProvider.notifier).addAttendanceTeacher(
                                        attendance: data.id,
                                        ip_address: _ipAddress,
                                        employee: widget.teacher_id,
                                        status: 'Present',
                                        token: auth.user.token,
                                        long:  widget.lng,
                                        lat:  widget.lat
                                    );


                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.h, horizontal: 8.w),
                                    child: attend.isLoad?CircularProgressIndicator(): Text(
                                      'Take Attendance',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 5.h,),


                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.h, horizontal: 8.w),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: primary,
                                      foregroundColor: Colors.white,
                                      fixedSize: Size.fromWidth(320.w),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          side: BorderSide(
                                            color: Colors.black,
                                          ))),
                                  onPressed: () {
                                    Navigator.pop(context);



                                  Get.to(()=> TeacherAttendaceStatus(teacher_id: widget.teacher_id, teacher_name: "test"));

                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.h, horizontal: 8.w),
                                    child: auth.isLoad?CircularProgressIndicator(): Text(
                                      'View Attendance History',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),



                              SizedBox(height: 5.h,),

                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.h, horizontal: 8.w),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: abs_color,
                                      foregroundColor: Colors.white,
                                      fixedSize: Size.fromWidth(320.w),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          side: BorderSide(
                                            color: Colors.black,
                                          ))),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Get.to(()=>AddNote(teacher_id: widget.teacher_id));

                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.h, horizontal: 8.w),
                                    child: auth.isLoad?CircularProgressIndicator(): Text(
                                      'Add a leave note',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        else{
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Attendance already taken',style: TextStyle(color: Colors.black,fontSize: 20.sp),),
                              SizedBox(height: 5.h),
                              TextButton(


                                onPressed: (){
                                  Navigator.pop(context);

                                },
                                child: Text('Ok',style: TextStyle(color: bgColor),),
                              ),
                              TextButton(

                                onPressed: (){
                                  Navigator.pop(context);

                                  Get.to(()=> TeacherAttendaceStatus(teacher_id: widget.teacher_id, teacher_name: "Nikel"));


                                },
                                child: Text('View Attendance History',style: TextStyle(color: bgColor),),
                              )
                            ],
                          );
                        }
                      },
                      error: (err,stack)=>Center(child: Text('$err',style: TextStyle(color: Colors.black),),),
                      loading: ()=>Center(child: CircularProgressIndicator(),)
                  )




                ],
              );
            }
            else{
              return Center(child: Column(
                children: [
                  Text('Something wrong. Try again later',style: TextStyle(color: Colors.black),),
                  SizedBox(height: 10.h,),
                  CircleAvatar(
                    radius: 20.sp,
                    backgroundColor: primary,
                    child: IconButton(
                      onPressed: (){
                        ref.refresh(attendanceDateTeacher(auth.user.token));
                      },
                      icon: Icon(Icons.refresh,color: Colors.white,),
                    ),
                  )
                ],
              ), );
            }
          },
          error: (err,stack)=>Center(child: Text('$err',style: TextStyle(color: Colors.black),)),
          loading: ()=>Container(
            height: 100.h,
            child: Center(child: CircularProgressIndicator(),),
          )
      ),
    );


  }
}
