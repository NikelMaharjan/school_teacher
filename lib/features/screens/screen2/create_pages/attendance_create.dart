// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// import '../../../../../constants/colors.dart';
//
// class Attendance_add extends StatefulWidget {
//   const Attendance_add({Key? key}) : super(key: key);
//
//   @override
//   State<Attendance_add> createState() => _Attendance_addState();
// }
//
// class _Attendance_addState extends State<Attendance_add> {
//   bool toggle = true;
//
//   DateTime date = DateTime.now();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           Container(
//               height: MediaQuery.of(context).size.height * 0.9 / 5,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                   color: bgColor,
//                   borderRadius:
//                       BorderRadius.vertical(bottom: Radius.circular(25))),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     height: 20.h,
//                   ),
//                   Row(
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           Get.back();
//                         },
//                         icon: Icon(
//                           Icons.arrow_back,
//                           color: Colors.white,
//                         ),
//                       ),
//                       SizedBox(
//                         width: 80.w,
//                       ),
//                     ],
//                   ),
//                   Text('Take Attendance',
//                       style: TextStyle(color: Colors.white, fontSize: 18.sp)),
//                   Text(
//                     DateFormat.yMMMd().format(DateTime.now()),
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               )),
//           Container(
//               width: MediaQuery.of(context).size.width * 0.9,
//               height: MediaQuery.of(context).size.height * 0.7,
//               child: ListView(
//                 shrinkWrap: true,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.symmetric(vertical: 8.h),
//                     child: Card(
//                       elevation: 8,
//                       color: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: ListTile(
//                         contentPadding: EdgeInsets.symmetric(
//                             horizontal: 8.w, vertical: 8.h),
//                         leading: Container(
//                           height: 60.h,
//                           width: 60.h,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(10),
//                               color: Colors.lightBlueAccent),
//                         ),
//                         title: Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 8.w),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('Student Name',
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold)),
//                               SizedBox(
//                                 height: 10.h,
//                               ),
//                               Text('Roll Number',
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 12.sp)),
//                             ],
//                           ),
//                         ),
//                         trailing: TextButton(
//                             style: TextButton.styleFrom(
//                                 backgroundColor: toggle ? primary : errorColor,
//                                 foregroundColor: Colors.white,
//                                 padding: EdgeInsets.all(0),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(5),
//                                 )),
//                             onPressed: () {
//                               setState(() {
//                                 toggle = !toggle;
//                               });
//                             },
//                             child: toggle
//                                 ? Text(
//                                     'Present',
//                                     style: TextStyle(fontSize: 12.sp),
//                                   )
//                                 : Text(
//                                     'Absent',
//                                     style: TextStyle(fontSize: 12.sp),
//                                   )),
//                       ),
//                     ),
//                   ),
//                 ],
//               )),
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
//             child: TextButton(
//               style: TextButton.styleFrom(
//                   backgroundColor: primary,
//                   foregroundColor: Colors.white,
//                   fixedSize: Size.fromWidth(320.w),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       side: BorderSide(
//                         color: Colors.black,
//                       ))),
//               onPressed: () {},
//               child: Text(
//                 'Submit',
//                 style: TextStyle(
//                   fontSize: 18.sp,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
