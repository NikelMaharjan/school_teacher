//
//
//
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import '../../../constants/colors.dart';
// import '../../../utils/commonWidgets.dart';
// import '../../authentication/providers/auth_provider.dart';
// import '../../services/info_services.dart';
// import '../screen2/class_tab/class_page.dart';
//
// class AllCourses extends ConsumerWidget {
//
//   @override
//   Widget build(BuildContext context,ref) {
//
//     final auth = ref.watch(authProvider);
//     final String token = auth.user.token;
//     final teacherCourse = ref.watch(teacherCourseList(token));
//     final infoData = ref.watch(employeeList(auth.user.token));
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body:Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//               height: MediaQuery.of(context).size.height * 0.8 / 5,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                   color: bgColor,
//                   borderRadius:
//                   BorderRadius.vertical(bottom: Radius.circular(25))),
//               child: Column(
//                 children: [
//                   SizedBox(
//                     height: 20.h,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
//                     ],
//                   ),
//                   Center(
//                     child: Text('All Courses',style: TextStyle(color: Colors.white,fontSize: 25.sp),),
//                   ),
//                 ],
//               )),
//           SizedBox(
//             height: 10.h,
//           ),
//           Container(
//             // color: Colors.blue,
//               height: MediaQuery.of(context).size.height * 4.1/5,
//               // padding: EdgeInsets.only(left: 30.w),
//
//               child: infoData.when(
//                 data: (info_data){
//                   final infoData= info_data.firstWhere((element) => element.email==auth.user.userInfo.email);
//                   return teacherCourse.when(
//                     data: (class_data){
//                       return ListView.builder(
//                           padding: EdgeInsets.symmetric(horizontal: 15.w),
//                           shrinkWrap: true, itemCount: class_data.length,
//                           itemBuilder: (context,index){
//                             return  InfoTileWidget(
//                               title: '${class_data[index].classLevel.className.classLevel.className}-${class_data[index].classLevel.sectionName}',
//                               onTap: ()=> Get.to(() => ClassPage(class_sec_id: class_data[index].classLevel.id, token: '$token', sec_name: class_data[index].classLevel.sectionName, class_level_name: class_data[index].classLevel.className.classLevel.className, teacher_id: infoData.id,)),
//
//                             );
//                             //CommonCard(
//                             //     onTap: () => Get.to(() => ClassPage(class_sec_id: class_data[index].id, token: '$token', sec_name: class_data[index].section, class_level_name: class_data[index].classLevel, teacher_id: infoData.id, school_id: 1,)),
//                             //     time: 'Class ${class_data[index].classLevel}${class_data[index].section}',
//                             //     className: '',
//                             //     subjectName: class_data[index].classTeacher== true? 'Class Teacher' : ''
//                             // );
//                           }
//                       );
//                     },
//                     error: (err, stack) => Center(child: Text('$err')),
//                     loading: () =>  ShimmerListTile(),
//
//                   );
//                 },
//                 error: (err, stack) => Center(child: Text('$err')),
//                 loading: () =>  ShimmerListTile(),
//               )
//           ),
//         ],
//       ) ,
//     );
//   }
// }
