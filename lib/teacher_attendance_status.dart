



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../../../../constants/colors.dart';
import '../../../../../constants/snack_show.dart';
import '../../../../../utils/commonWidgets.dart';
import 'features/services/teacher_attendance_service.dart';

class TeacherAttendaceStatus extends ConsumerWidget {

  final int teacher_id;
  final String teacher_name;
  TeacherAttendaceStatus({required this.teacher_id, required this.teacher_name});

  @override
  Widget build(BuildContext context,ref) {

    final attendStatus = ref.watch(teacherAttendanceProvider(teacher_id));



    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor  ,
        title: Text("STATUS", style: TextStyle(color: Colors.white),),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            // color: Colors.red,
              height: MediaQuery.of(context).size.height*4.2/5,
              child:  attendStatus.when(
                data: (data){
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(

                        color: Colors.white,
                        shape: Border.all(
                            color: Colors.black
                        ),
                        child: ListTile(
                          onTap: ()async{
                            if(data[index].status=='Present'){
                              SnackShow.showSuccess(context, 'you was present');
                            }
                            else{
                              // await showDialog(
                              //
                              //     context: context,
                              //     builder: (context){
                              //       return attendNote.when(
                              //         data: (note_data) {
                              //           final note = note_data.firstWhereOrNull((element) => element.startDate == data[index].attendance.date && element.student == data[index].student.id);
                              //           return AlertDialog(
                              //             shape: RoundedRectangleBorder(
                              //               borderRadius: BorderRadius.circular(15.0),
                              //             ),
                              //             backgroundColor: Colors.white,
                              //             title: Row(
                              //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //               children: [
                              //                 Text('Absent Note', style: TextStyle(color: Colors.black, fontSize: 12.sp),),
                              //                 Text(data[index].attendance.date, style: TextStyle(color: Colors.black, fontSize: 12.sp),),
                              //               ],
                              //             ),
                              //             content: Text(note == null ? 'No reason given' : note.reason!, style: TextStyle(color: Colors.black),),
                              //           );
                              //         },
                              //         error: (err, stack) => AlertDialog(
                              //           backgroundColor: Colors.white,
                              //           title: Text('Reason', style: TextStyle(color: Colors.black),),
                              //           content: Text('No reason given', style: TextStyle(color: Colors.black),),
                              //         ),
                              //         loading: () => FutureBuilder(
                              //           future: Future.delayed(Duration(seconds: 10)), // Set timeout duration
                              //           builder: (context, snapshot) {
                              //             if (snapshot.connectionState == ConnectionState.done) {
                              //               // Show error message after timeout
                              //               return AlertDialog(
                              //                 backgroundColor: Colors.white,
                              //                 title: Row(
                              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //                   children: [
                              //                     Text('Absent Note', style: TextStyle(color: Colors.black, fontSize: 12.sp),),
                              //                     Text(data[index].attendance.date, style: TextStyle(color: Colors.black, fontSize: 12.sp),),
                              //                   ],
                              //                 ),
                              //                 content: Text( 'No reason given', style: TextStyle(color: Colors.black),),
                              //               );
                              //             } else {
                              //               // Show loading indicator during the timeout period
                              //               return Center(child: CircularProgressIndicator());
                              //             }
                              //           },
                              //         ),
                              //       );
                              //
                              //     }
                              // );
                            }
                          },
                          title: Text(data[index].attendance.date.toString().substring(0,10),style: TextStyle(color: Colors.black),),
                          trailing: CircleAvatar(
                            radius: 10.sp,
                            backgroundColor: data[index].status == 'Present' ? pre_color: abs_color,
                          ),
                        ),
                      );

                    },
                  );

                },
                error: (err, stack) => Center(child: Text('$err')),
                loading: () => NoticeShimmer(),
              )



          )
        ],
      ),
    );
  }
}