// import 'package:connectivity/connectivity.dart';
// import 'package:eschool_teacher/exceptions/internet_exceptions.dart';
// import 'package:eschool_teacher/features/screens/screen2/class_tab/class_notice/class_notice.dart';
// import 'package:eschool_teacher/features/screens/screen2/class_tab/student_tab/student_tab.dart';
// import 'package:eschool_teacher/features/screens/screen2/class_tab/subjects_tab/subject_tab.dart';
// import 'package:eschool_teacher/features/screens/screen2/course_tab/course_tab/course_tab.dart';
// import 'package:eva_icons_flutter/eva_icons_flutter.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// import '../../../../../constants/colors.dart';
// import '../../../../utils/commonWidgets.dart';
// import '../../../authentication/providers/auth_provider.dart';
// import '../../../model/notice.dart';
// import '../../../services/classes_service.dart';
// import '../../../services/info_services.dart';
// import '../../../services/school_info_services.dart';
// import '../../../services/teacher_services.dart';
// import '../create_pages/attendance_create.dart';
// class CoursePage extends ConsumerStatefulWidget {
//
//   final int class_sec_id;
//   final String class_level_name;
//   final String sec_name;
//   final String token;
//   final int teacher_id;
//
//
//   CoursePage({required this.class_sec_id, required this.token,required this.sec_name,required this.class_level_name,required this.teacher_id});
//
//   @override
//   ConsumerState<CoursePage> createState() => _ClassTabsState(class_sec_id: class_sec_id, token: token, sec_name: sec_name,class_level_name: class_level_name, teacher_id: teacher_id);
// }
//
// class _ClassTabsState extends ConsumerState<CoursePage> with TickerProviderStateMixin {
//
//   final int class_sec_id;
//   final String token;
//   final String class_level_name;
//   final String sec_name;
//   final int teacher_id;
//
//
//
//
//   _ClassTabsState({
//     required this.class_sec_id,
//     required this.token,
//     required this.sec_name,
//     required this.class_level_name,
//
//     required this.teacher_id
//   });
//
//
//   @override
//   void initState() {
//     super.initState();
//
//
//   }
//
//
//
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     final auth = ref.watch(authProvider);
//
//     TabController _tabController = TabController(length: 2, vsync: this);
//     return ConnectivityChecker(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body:
//         Column(
//           children: [
//             Container(
//                 height: MediaQuery.of(context).size.height * 1.4 / 5,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                     color: bgColor,
//                     borderRadius:
//                     BorderRadius.vertical(bottom: Radius.circular(25))),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       height: 20.h,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             Get.back();
//                           },
//                           icon: Icon(
//                             Icons.arrow_back,
//                             color: Colors.white,
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             print('tapped');
//                             Get.to(() => ClassNoticeBoard(class_sec_id: class_sec_id, teacher_id: teacher_id,));
//                           },
//                           icon: Icon(
//                             Icons.notifications,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     Center(
//                       child: Text('${class_level_name} ${sec_name}',
//                           style: TextStyle(color: Colors.white, fontSize: 25.sp)),
//                     ),
//
//
//
//
//                     SizedBox(
//                       height: 10.h,
//                     ),
//                     TabBar(
//                         controller: _tabController,
//                         padding: EdgeInsets.symmetric(
//                             vertical: 15.h, horizontal: 30.w),
//                         labelStyle: TextStyle(
//                           fontSize: 18.sp,
//                         ),
//                         unselectedLabelStyle: TextStyle(
//                           fontSize: 18.sp,
//                         ),
//                         isScrollable: false,
//                         labelPadding: EdgeInsets.only(left: 15.w, right: 15.w),
//                         labelColor: primary,
//                         unselectedLabelColor: Colors.white,
//                         // indicatorColor: primary,
//                         indicator: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10)),
//                         tabs: [
//                           Tab(
//                             text: 'Students',
//                           ),
//                           Tab(text: 'Subjects'),
//                         ])
//                   ],
//                 )),
//             Container(
//               // color: Colors.red,
//                 height: MediaQuery.of(context).size.height * 3.6 / 5,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 15.w),
//                   child: TabBarView(
//                     // physics: NeverScrollableScrollPhysics(),
//
//                     controller: _tabController,
//                     children: [ApiStudents( class_id: class_sec_id, section: sec_name, className: class_level_name,), MyCourse(class_sec_id: class_sec_id, sec_name: sec_name, class_level_name: class_level_name,teacher_id: teacher_id,)],
//                     //MyClass(id: class_id, school_id: school_id, class_teacher: class_teacher, teacher_subject: teacher_subject, classSub_id: classSub_id,)
//                   ),
//                 )),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () => Get.to(() => Attendance_add()),
//           backgroundColor: primary,
//           child: Icon(
//             EvaIcons.calendarOutline,
//             color: Colors.white,
//           ),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//       ),
//     );
//   }
// }
