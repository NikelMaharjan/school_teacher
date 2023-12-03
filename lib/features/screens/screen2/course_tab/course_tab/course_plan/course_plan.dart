//
//
//
//
// import 'package:eschool_teacher/features/authentication/providers/auth_provider.dart';
// import 'package:eschool_teacher/features/model/features.dart';
// import 'package:eschool_teacher/features/model/teacher_course.dart';
// import 'package:eschool_teacher/features/screens/screen2/class_tab/subjects_tab/subject_plan/edit_subject_plan.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import '../../../../../../constants/colors.dart';
// import '../../../../../services/course_class_service.dart';
// import '../../../../../services/subject_class_service.dart';
// import 'add_course_plan.dart';
// import 'edit_course_plan.dart';
//
// class CoursePlanPage extends ConsumerWidget {
//   final TeacherClassCourse teacherClassCourse;
//   final String className;
//   final String section ;
//
//   CoursePlanPage({required this.teacherClassCourse,required this.section,required this.className});
//
//
//   @override
//   Widget build(BuildContext context,ref) {
//
//     final auth = ref.watch(authProvider);
//     final planList = ref.watch(coursePlanList(auth.user.token));
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height * 1 / 5,
//             width: double.infinity,
//             decoration: BoxDecoration(
//                 color: bgColor,
//                 borderRadius:
//                 BorderRadius.vertical(bottom: Radius.circular(25))),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         Get.back();
//                       },
//                       icon: Icon(
//                         Icons.arrow_back,
//                         color: Colors.white,
//                       ),
//                     ),
//
//                   ],
//                 ),
//
//                 Center(
//                   child: Column(
//                     children: [
//                       Text(
//                         'Subject Plan',
//                         style: TextStyle(color: Colors.white, fontSize: 28.sp),
//                       ),
//                       Text(
//                         '${teacherClassCourse.courseName.courseName} | Class ${className} ${section}',
//                         style: TextStyle(color: Colors.white, fontSize: 15.sp),
//                       )
//                     ],
//                   ),
//                 ),
//
//
//                 SizedBox(height: 20.h),
//
//               ],
//             ),
//           ),
//           Container(
//             // color: Colors.red,
//               padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
//               child: planList.when(
//                 data: (data){
//                   final plan_data = data.firstWhereOrNull((element) => element.course==teacherClassCourse.id);
//                   if(plan_data!=null){
//                     return  Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Container(
//                           padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
//                           decoration: BoxDecoration(
//                               color: shimmerHighlightColor,
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(
//                                   color: Colors.black
//                               )
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('Teaching duration',style: TextStyle(color: Colors.black,fontSize: 15.sp),),
//                               Text(plan_data.teachingDuration,style: TextStyle(color: Colors.black,fontSize: 15.sp,),),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 10.h,),
//                         Container(
//                           padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
//                           decoration: BoxDecoration(
//                               color: shimmerHighlightColor,
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(
//                                   color: Colors.black
//                               )
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('Expected Outcome',style: TextStyle(color: Colors.black,fontSize: 15.sp,),),
//                               Text(plan_data.expectedOutcome,style: TextStyle(color: Colors.black,fontSize: 15.sp,),),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 20.h,),
//                         Text('Description',style: TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.bold),),
//                         Divider(
//                           thickness: 1,
//                           color: Colors.black,
//                         ),
//                         Container(
//                           height: MediaQuery.of(context).size.height * 2.5/5,
//                           child: Text(plan_data.description,style: TextStyle(color: Colors.black,fontSize: 15.sp,),),
//
//                         ),
//                         Align(
//                           alignment: Alignment.bottomRight,
//                           child: FloatingActionButton(
//                               backgroundColor: primary,
//                               child: Icon(Icons.edit,color: Colors.white,),
//                               onPressed: (){
//                                 Get.to(()=>EditCoursePlan(coursePlan: plan_data));
//                               }
//                           ),
//                         )
//
//
//
//                       ],
//                     );
//                   } else {
//                     return Center(child: Column(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
//                           decoration: BoxDecoration(
//                               color: shimmerHighlightColor,
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(
//                                   color: Colors.black
//                               )
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('Teaching duration',style: TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.bold),),
//                               Text('-',style: TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.bold),),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 10.h,),
//                         Container(
//                           padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
//                           decoration: BoxDecoration(
//                               color: shimmerHighlightColor,
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(
//                                   color: Colors.black
//                               )
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text('Expected Outcome',style: TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.bold),),
//                               Text('-',style: TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.bold),),
//                             ],
//                           ),
//                         ),
//                         SizedBox(height: 20.h,),
//                         Container(
//                             height: MediaQuery.of(context).size.height * 2.5/5,
//                             child: Text('Add a plan',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20.sp),)),
//                         Align(
//                           alignment: Alignment.bottomRight,
//                           child: FloatingActionButton(
//                               backgroundColor: primary,
//                               child: Icon(Icons.edit,color: Colors.white,),
//                               onPressed: (){
//                                 Get.to(()=>AddCoursePlan(teacherClassCourse: teacherClassCourse,));
//                               }
//                           ),
//                         )
//                       ],
//                     ));
//                   }
//
//
//                 },
//                 error: (err, stack) => Center(child: Text('$err')),
//                 loading: () => CircularProgressIndicator(),
//               )
//
//
//
//
//           )
//         ],
//       ),
//     );
//   }
// }
