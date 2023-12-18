import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:eschool_teacher/features/model/class_subject.dart';
import 'package:eschool_teacher/features/screens/screen2/class_tab/student_tab/result_sample.dart';
import 'package:eschool_teacher/features/screens/screen2/class_tab/student_tab/student_attendance_stat.dart';
import 'package:eschool_teacher/utils/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../api.dart';
import '../../../../authentication/providers/auth_provider.dart';

import '../../../../services/attendance_services.dart';
import '../../../../services/school_info_services.dart';
import '../../../../services/student_services.dart';

class StudentDetails extends ConsumerWidget {
  final int student_id;
  final String className;
  final ClassWiseStudent student;
  final String section;



  StudentDetails({required this.student_id,required this.className,required this.section, required this.student});

  @override
  Widget build(BuildContext context, ref) {

    print("STUDENT ID IS $student_id");

    final auth = ref.watch(authProvider);

    final attendanceStatus = ref.watch(studentAttendanceProvider(student_id));
    final studentInfo = ref.watch(studentList(auth.user.token));

    return Scaffold(
      appBar: AppBar(
        title: Text("Student Details", style: TextStyle(
          color: Colors.white
        ),),
        backgroundColor: bgColor,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [


            // studentInfo.when(
            //     data: (data) {
            //       final student_data = data.firstWhere((element) => element.id == student_id);
            //       print('ID ${student_data.id}');
            //       return Column(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           Padding(
            //             padding: EdgeInsets.symmetric(vertical: 5.h),
            //             child: Card(
            //                 elevation: 0,
            //                 color: Colors.grey.withOpacity(0.1),
            //                 shape: RoundedRectangleBorder(
            //                   side: BorderSide(
            //                     color: Colors.black
            //                   ),
            //                     borderRadius: BorderRadius.circular(10)),
            //                 child: SizedBox(
            //                   height: 110.h,
            //                   width: 350.w,
            //                   child: ListTile(
            //                     contentPadding:
            //                         EdgeInsets.symmetric(vertical: 0.h),
            //                     title: Padding(
            //                       padding: EdgeInsets.symmetric(
            //                           vertical: 8.h, horizontal: 8.w),
            //                       child: Row(
            //                         children: [
            //                           CircleAvatar(
            //                             radius: 30.sp,
            //                             backgroundImage: NetworkImage(
            //                                 '${Api.basePicUrl}${student_data.studentPhoto}'),
            //                           ),
            //                           SizedBox(width: 15.w),
            //                           Column(
            //                             mainAxisAlignment:
            //                                 MainAxisAlignment.center,
            //                             crossAxisAlignment:
            //                                 CrossAxisAlignment.start,
            //                             mainAxisSize: MainAxisSize.min,
            //                             children: [
            //                               Text(
            //                                 student_data.studentName,
            //                                 style: TextStyle(
            //                                     color: Colors.black,
            //                                     fontSize: 18.sp,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                               Container(
            //                                 width: 255.w,
            //                                 // color: Colors.red,
            //                                 child: Row(
            //                                   mainAxisAlignment:
            //                                       MainAxisAlignment.spaceBetween,
            //                                   children: [
            //                                     Column(
            //                                       crossAxisAlignment:
            //                                           CrossAxisAlignment.start,
            //                                       children: [
            //                                         Text(
            //                                           'Class: ${className} ${section}',
            //                                           style: TextStyle(
            //                                               color: Colors.black45,
            //                                               fontSize: 10.sp),
            //                                         ),
            //                                         Text(
            //                                           'DOB: ${student_data.dateOfBirthEng}',
            //                                           style: TextStyle(
            //                                               color: Colors.black45,
            //                                               fontSize: 10.sp),
            //                                         ),
            //                                         Text(
            //                                           'Email: ${student_data.email}',
            //                                           style: TextStyle(
            //                                               color: Colors.black45,
            //                                               fontSize: 10.sp),
            //                                         ),
            //                                       ],
            //                                     ),
            //                                     Column(
            //                                       crossAxisAlignment:
            //                                           CrossAxisAlignment.start,
            //                                       children: [
            //                                         Text(
            //                                           'Gender: ${student_data.gender}',
            //                                           style: TextStyle(
            //                                               color: Colors.black54,
            //                                               fontSize: 10.sp),
            //                                         ),
            //
            //                                       ],
            //                                     ),
            //                                   ],
            //                                 ),
            //                               )
            //                             ],
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //                 )),
            //           ),
            //           Padding(
            //             padding: EdgeInsets.symmetric(vertical: 5.h),
            //             child: Card(
            //                 elevation: 0,
            //                 color: Colors.grey.withOpacity(0.1),
            //                 shape: RoundedRectangleBorder(
            //                     side: BorderSide(
            //                         color: Colors.black
            //                     ),
            //                     borderRadius: BorderRadius.circular(10)),
            //                 child: SizedBox(
            //                   height: 110.h,
            //                   width: 350.w,
            //                   child: ListTile(
            //                     contentPadding:
            //                         EdgeInsets.symmetric(vertical: 0.h),
            //                     title: Padding(
            //                       padding: EdgeInsets.symmetric(
            //                           vertical: 8.h, horizontal: 8.w),
            //                       child: Row(
            //                         children: [
            //                           CircleAvatar(
            //                             radius: 30.sp,
            //                             backgroundColor: pre_color,
            //                           ),
            //                           SizedBox(width: 15.w),
            //                           Column(
            //                             mainAxisAlignment:
            //                                 MainAxisAlignment.center,
            //                             crossAxisAlignment:
            //                                 CrossAxisAlignment.start,
            //                             mainAxisSize: MainAxisSize.min,
            //                             children: [
            //                               AutoSizeText(
            //                                 student_data.fatherName,
            //                                 style: TextStyle(
            //                                     color: Colors.black,
            //                                     fontSize: 18.sp,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                               Text(
            //                                 'Father',
            //                                 style: TextStyle(
            //                                     color: Colors.black54,
            //                                     fontSize: 15.sp),
            //                               ),
            //                             ],
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //                 )),
            //           ),
            //           Padding(
            //             padding: EdgeInsets.symmetric(vertical: 5.h),
            //             child: Card(
            //                 elevation: 0,
            //                 color: Colors.grey.withOpacity(0.1),
            //                 shape: RoundedRectangleBorder(
            //                     side: BorderSide(
            //                         color: Colors.black
            //                     ),
            //                     borderRadius: BorderRadius.circular(10)),
            //                 child: SizedBox(
            //                   height: 110.h,
            //                   width: 350.w,
            //                   child: ListTile(
            //                     contentPadding:
            //                         EdgeInsets.symmetric(vertical: 0.h),
            //                     title: Padding(
            //                       padding: EdgeInsets.symmetric(
            //                           vertical: 8.h, horizontal: 8.w),
            //                       child: Row(
            //                         children: [
            //                           CircleAvatar(
            //                             radius: 30.sp,
            //                             backgroundColor: pre_color,
            //                           ),
            //                           SizedBox(width: 15.w),
            //                           Column(
            //                             mainAxisAlignment:
            //                                 MainAxisAlignment.center,
            //                             crossAxisAlignment:
            //                                 CrossAxisAlignment.start,
            //                             mainAxisSize: MainAxisSize.min,
            //                             children: [
            //                               AutoSizeText(
            //                                 student_data.motherName,
            //                                 style: TextStyle(
            //                                     color: Colors.black,
            //                                     fontSize: 18.sp,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                               Text(
            //                                 'Mother',
            //                                 style: TextStyle(
            //                                     color: Colors.black54,
            //                                     fontSize: 15.sp),
            //                               ),
            //                             ],
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //                 )),
            //           ),
            //         ],
            //       );
            //     },
            //     error: (err, stack) => Center(child: Text('$err')),
            //     loading: () => Container(
            //         height: MediaQuery.of(context).size.height*1/2,
            //         child: ShimmerListTile2())),



            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                height: 150,
                  child: CachedNetworkImage(imageUrl: "${Api.basePicUrl}${student.student.studentPhoto}", fit: BoxFit.fill,)),
            ),

            DataTable(
              // datatable widget
              columns: [
                // column to set the name
                DataColumn(label: Text('Student Name', style: TextStyle(fontWeight: FontWeight.normal),),),
                DataColumn(label: Text(student.student.studentName, style: TextStyle(fontWeight: FontWeight.normal ),),),
              ],

              rows: [
                // row to set the values
                DataRow(
                    cells: [
                  DataCell(Text('Gender')),
                  DataCell(Text(student.student.gender)),
                ]
                ),

                DataRow(
                    cells: [
                      DataCell(Text('Date of Birth')),
                      DataCell(Text(student.student.date_of_birth_eng)),
                    ]
                ),


                DataRow(
                    cells: [
                      DataCell(Text('Email')),
                      DataCell(Text(student.student.email)),
                    ]
                ),

                DataRow(
                    cells: [
                      DataCell(Text('Address')),
                      DataCell(Text(student.student.residental_address)),
                    ]
                ),

                DataRow(
                    cells: [
                      DataCell(Text('Mobile')),
                      DataCell(Text(student.student.mobile_number.toString())),
                    ]
                ),

                DataRow(
                    cells: [
                      DataCell(Text('Roll')),
                      DataCell(Text(student.student.student_roll_no)),
                    ]
                ),

                DataRow(
                    cells: [
                      DataCell(Text('Father Name')),
                      DataCell(Text(student.student.father_name)),
                    ]
                ),

                DataRow(
                    cells: [
                      DataCell(Text('Mother Name')),
                      DataCell(Text(student.student.mother_name)),
                    ]
                ),
              ],
            ),


            Container(
              height: 140.h,
              child: attendanceStatus.when(
                data: (data){

                  int presentCount = 0;
                  int absentCount = 0;

                  for(int i=0; i<data.length; i++) {
                    if(data[i].status == 'Present') {
                      presentCount++;
                    } else if(data[i].status == 'Absent') {
                      absentCount++;
                    }
                  }

                  return InkWell(
                    onTap: ()=>Get.to(()=>AttendanceStatus(student_id: student_id)),
                    child: Padding(
                      padding: EdgeInsets.all(10.h),
                      child: Card(
                          elevation: 0,
                          color: Colors.grey.withOpacity(0.1),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: SizedBox(
                            width: 350.w,
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(vertical: 0.h),
                              title: Padding(
                                padding:
                                EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Attendance Stat',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          height: 40.h,
                                          width: 150.w,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              border:
                                              Border.all(width: 1.w, color: primary)),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Total Present',
                                                style: TextStyle(
                                                    color: Colors.black, fontSize: 12.sp),
                                              ),
                                              Text(
                                                '$presentCount',
                                                style: TextStyle(
                                                    color: Colors.black, fontSize: 10.sp),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 40.h,
                                          width: 150.w,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              border:
                                              Border.all(width: 1.w, color: primary)),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Total Absent',
                                                style: TextStyle(
                                                    color: Colors.black, fontSize: 12.sp),
                                              ),
                                              Text(
                                                '$absentCount',
                                                style: TextStyle(
                                                    color: Colors.black, fontSize: 10.sp),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )),
                    ),
                  );
                },
                error: (err, stack) => Center(child: Text('$err')),
                loading: () => Center(child: CircularProgressIndicator(),),
              ),
            ),



            // Padding(
            //   padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
            //   child: TextButton(
            //     style: TextButton.styleFrom(
            //         backgroundColor: Colors.white,
            //         foregroundColor: primary,
            //         fixedSize: Size.fromWidth(350.w),
            //         shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(10),
            //             side: BorderSide(color: primary, width: 1.w))),
            //     onPressed: () {
            //       Get.to(() => StudentResult());
            //     },
            //     child: Padding(
            //       padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 8.w),
            //       child: Text(
            //         'View Result',
            //         style:
            //             TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
