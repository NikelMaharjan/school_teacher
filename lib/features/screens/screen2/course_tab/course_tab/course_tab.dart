// import 'package:eschool_teacher/features/authentication/providers/auth_provider.dart';
// import 'package:eschool_teacher/features/screens/screen2/class_tab/subjects_tab/subject_page.dart';
// import 'package:eschool_teacher/features/screens/screen2/course_tab/course_tab/course_page.dart';
// import 'package:eschool_teacher/utils/commonWidgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:shimmer/shimmer.dart';
//
// import '../../../../../constants/colors.dart';
// import '../../../../services/feature_services.dart';
//
//
//
//
// class MyCourse extends ConsumerWidget {
//
//
//   final int class_sec_id;
//   final String class_level_name;
//   final String sec_name;
//   final int teacher_id;
//   MyCourse({required this.class_sec_id,required this.sec_name,required this.class_level_name,required this.teacher_id});
//
//
//
//   @override
//   Widget build(BuildContext context,ref) {
//     print('${class_sec_id}');
//     final auth = ref.watch(authProvider);
//     final teacherCourseList = ref.watch(teacherClassCourseProvider(class_sec_id));
//
//     return Container(
//       height: 100.h,
//       // color: Colors.red,
//       child: teacherCourseList.when(
//         data: (data) => ListView.builder(
//           padding: EdgeInsets.zero,
//           itemCount: data.length,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding:
//               EdgeInsets.symmetric(vertical: 8.h),
//               child: Card(
//                 elevation: 8,
//                 color: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius:
//                   BorderRadius.circular(10),
//                 ),
//                 child: ListTile(
//                   contentPadding: EdgeInsets.symmetric(
//                       horizontal: 8.w, vertical: 8.h),
//                   onTap: ()=>Get.to(()=> CoursesTab(teacherClassCourse: data[index])),
//
//                   leading: Container(
//                     height: 60.h,
//                     width: 80.h,
//                     decoration: BoxDecoration(
//                         borderRadius:
//                         BorderRadius.circular(10),
//                         color: Colors.lightBlueAccent),
//                   ),
//                   title: Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: 8.w),
//                     child: Text(data[index].courseName.courseName,
//                         style: TextStyle(
//                           color: Colors.black,
//                         )),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//         loading: () => ShimmerListTile(),
//         error: (error, stackTrace) => Text('Error: $error'),
//       ),
//     );
//   }
// }
