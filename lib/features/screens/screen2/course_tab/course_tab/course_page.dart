//
// import 'package:eschool_teacher/exceptions/internet_exceptions.dart';
// import 'package:eschool_teacher/features/model/teacher_course.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import '../../../../../../constants/colors.dart';
//
// import '../../../../authentication/providers/auth_provider.dart';
// import '../../../../services/notice_services.dart';
// import '../../../../services/school_info_services.dart';
//
// import '../../class_tab/subjects_tab/subject_announcements/add_announcements.dart';
// import '../../create_pages/add_lessons.dart';
// import 'course_announcements/course_announcements.dart';
// import 'course_chapters.dart';
//
//
// class CoursesTab extends ConsumerStatefulWidget {
//
//   final TeacherClassCourse teacherClassCourse;
//
//
//   CoursesTab({required this.teacherClassCourse,});
//
//   @override
//   ConsumerState<CoursesTab> createState() =>
//       _CoursesState();
// }
//
// class _CoursesState extends ConsumerState<CoursesTab> with TickerProviderStateMixin {
//
//
//   late TabController _tabController;
//
//   int _currentIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(vsync: this, length: 2);
//
//   }
//
//
//   FloatingActionButton _buildFloatingActionButton() {
//     switch (_currentIndex) {
//       case 0:
//         return FloatingActionButton(
//           onPressed: () => Get.to(() => AddLessons()),
//           backgroundColor: primary,
//           child: Icon(
//             Icons.add,
//             color: Colors.white,
//           ),
//         );
//       case 1:
//         return FloatingActionButton(
//           onPressed: () => Get.to(() => SubjectNoticeForm(class_sec_id: widget.teacherClassCourse.className.id,  sub_id: widget.teacherClassCourse.courseName.id,)),
//
//
//
//           backgroundColor: primary,
//           child: Icon(
//             Icons.add,
//             color: Colors.white,
//           ),
//         );
//
//       default:
//         return FloatingActionButton(
//           onPressed: () {},
//           child: Icon(Icons.error),
//         );
//     }
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final auth = ref.watch(authProvider);
//
//     return DefaultTabController(
//       length: 2,
//       child: ConnectivityChecker(
//         child: Scaffold(
//             backgroundColor: Colors.white,
//             body:Column(
//               children: [
//                 Container(
//                   height: MediaQuery.of(context).size.height * 1.3 / 5,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                       color: bgColor,
//                       borderRadius:
//                       BorderRadius.vertical(bottom: Radius.circular(25))),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               Get.back();
//                             },
//                             icon: Icon(
//                               Icons.arrow_back,
//                               color: Colors.white,
//                             ),
//                           ),
//                           IconButton(
//                             onPressed: () async {
//                               await ref.refresh(schoolInfo(auth.user.token));
//                               await ref.refresh(subNoticeList(auth.user.token));
//                               print('refreshed');
//                             },
//                             icon: Icon(
//                               Icons.refresh,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
//
//                       Center(
//                         child: Column(
//                           children: [
//                             Text(
//                               widget.teacherClassCourse.courseName.courseName,
//                               style: TextStyle(color: Colors.white, fontSize: 25.sp),
//                             ),
//                             Text(
//                               '${widget.teacherClassCourse.className.className.classLevel.className} ${widget.teacherClassCourse.className.sectionName}',
//                               style: TextStyle(color: Colors.white, fontSize: 15.sp),
//                             ),
//                           ],
//                         ),
//                       ),
//
//
//                       SizedBox(height: 20.h),
//                       TabBar(
//                           controller: _tabController,
//                           onTap: (index) {
//                             setState(() {
//                               _currentIndex = index;
//                             });
//                           },
//                           padding: EdgeInsets.symmetric(
//                               vertical: 15.h, horizontal: 30.w),
//                           labelStyle: TextStyle(
//                             fontSize: 18.sp,
//                           ),
//                           unselectedLabelStyle: TextStyle(
//                             fontSize: 18.sp,
//                           ),
//                           isScrollable: false,
//                           labelPadding: EdgeInsets.only(left: 15.w, right: 15.w),
//                           labelColor: primary,
//                           unselectedLabelColor: Colors.white,
//                           // indicatorColor: primary,
//                           indicator: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(10)),
//                           tabs: [
//                             Tab(
//                               text: 'Chapters',
//                             ),
//                             Tab(text: 'Announcement'),
//                           ]),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   height: MediaQuery.of(context).size.height * 4 / 6,
//                   // color: Colors.red,
//                   child: TabBarView(
//                       controller: _tabController,
//                       children: [CourseChapters(teacherClassCourse:widget.teacherClassCourse ,className: widget.teacherClassCourse.className.className.classLevel.className,section: widget.teacherClassCourse.className.sectionName,),
//                         CourseNotices(teacherClassCourse:widget.teacherClassCourse)]),
//                 )
//               ],
//             ),
//             floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//             floatingActionButton:  _buildFloatingActionButton()
//         ),
//       ),
//     );
//   }
// }
