// import 'package:eschool_teacher/exceptions/internet_exceptions.dart';
// import 'package:eschool_teacher/features/model/auth_state.dart';
// import 'package:eschool_teacher/features/model/notice.dart';
// import 'package:eschool_teacher/features/providers/notice_providers.dart';
// import 'package:eschool_teacher/features/screens/screen2/class_tab/subjects_tab/subject_announcements/edit_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:shimmer/shimmer.dart';
// import '../../../../../../constants/colors.dart';
// import '../../../../../../utils/commonWidgets.dart';
// import '../../../../../authentication/providers/auth_provider.dart';
// import '../../../../../model/teacher_course.dart';
// import '../../../../../services/classes_service.dart';
// import '../../../../../services/notice_services.dart';
// import '../../../../../services/school_info_services.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
//
// class CourseNotices extends ConsumerWidget {
//   final TeacherClassCourse teacherClassCourse;
//
//   CourseNotices({required this.teacherClassCourse});
//
//   @override
//   Widget build(BuildContext context, ref) {
//     final auth = ref.watch(authProvider);
//     final classSecSub = ref.watch(classSubInfo(auth.user.token));
//     final subNotices = ref.watch(subNoticeList(auth.user.token));
//     print('sub ${teacherClassCourse.courseName.id}');
//     print('class ${teacherClassCourse.className.id}');
//     print(teacherClassCourse.id);
//
//     return ConnectivityChecker(
//       child: Scaffold(
//           backgroundColor: Colors.white,
//           // body: subNotices.when(
//           //   data: (subNotices_data){
//           //     final sub_notices = subNotices_data.where((element) => element.subjectName == teacherClassCourse.id.toString()).toList();
//           //     return ListView.builder(
//           //         padding: EdgeInsets.zero,
//           //         shrinkWrap: true,
//           //         itemCount: sub_notices.length,
//           //         itemBuilder: (context, index){
//           //           String createdAtString = sub_notices[index].createdAt;
//           //           DateTime createdAt = DateTime.parse(createdAtString);
//           //
//           //
//           //           return Padding(
//           //             padding: EdgeInsets.symmetric(
//           //                 vertical: 5.h,
//           //                 horizontal: 20.w),
//           //             child: Slidable(
//           //               closeOnScroll: true,
//           //
//           //
//           //               // endActionPane: ActionPane(
//           //               //     motion: ScrollMotion(),
//           //               //     children: [
//           //               //       SlidableAction(
//           //               //         borderRadius: BorderRadius.circular(10),
//           //               //         padding: EdgeInsets.symmetric(horizontal: 5.w),
//           //               //         autoClose: true,
//           //               //         flex: 1,
//           //               //         backgroundColor: primary,
//           //               //         foregroundColor: Colors.white,
//           //               //         icon: Icons.edit,
//           //               //          onPressed: (context) => Get.to(()=>EditSubNotice(class_sec_id: teacherClassCourse.className.id, sub_id: teacherClassCourse.courseName.id, subjectNotice: sub_notices[index],class_sub_id: sub_notices[index].subjectName!,)),
//           //               //
//           //               //       ),
//           //               //       SizedBox(width: 5.w,),
//           //               //       SlidableAction(
//           //               //           borderRadius: BorderRadius.circular(10),
//           //               //           padding: EdgeInsets.symmetric(horizontal: 5.w),
//           //               //           flex: 1,
//           //               //           autoClose: true,
//           //               //           backgroundColor: errorColor,
//           //               //           foregroundColor: Colors.white,
//           //               //           icon: Icons.delete,
//           //               //           onPressed: (context) =>  showDialog(
//           //               //               context: context,
//           //               //               builder: (context){
//           //               //                 return AlertDialog(
//           //               //                   backgroundColor: Colors.white,
//           //               //                   alignment: Alignment.center,
//           //               //                   title: Text('Do you want to delete the notice?',style: TextStyle(color: Colors.black),),
//           //               //                   actionsAlignment: MainAxisAlignment.spaceEvenly,
//           //               //                   actions: [
//           //               //                     TextButton(
//           //               //                         style: TextButton.styleFrom(
//           //               //                             backgroundColor: primary
//           //               //                         ),
//           //               //                         onPressed: () async {
//           //               //                           await ref.read(subNoticeProvider.notifier).deleteData(sub_notices[index].id, auth.user.token)
//           //               //                               .then((value) => ref.refresh(subNoticeList(auth.user.token))).then((value) => Navigator.pop(context));
//           //               //                         },
//           //               //                         child: Text('Yes',style: TextStyle(color: Colors.white),)
//           //               //                     ),
//           //               //                     TextButton(
//           //               //                         style: TextButton.styleFrom(
//           //               //                             backgroundColor: shimmerBaseColor
//           //               //                         ),
//           //               //                         onPressed: (){
//           //               //                           Navigator.pop(context);
//           //               //                         },
//           //               //                         child: Text('No',style: TextStyle(color: Colors.black),)
//           //               //                     ),
//           //               //                   ],
//           //               //                 );
//           //               //               })
//           //               //
//           //               //
//           //               //
//           //               //       )
//           //               //     ]
//           //               // ),
//           //               child: NoticeCard(
//           //                   title: sub_notices[index].title,
//           //                   description: sub_notices[index].message,
//           //                   createdAt: '${DateFormat('MMMM dd').format(createdAt)}'),
//           //             ),
//           //           );
//           //         }
//           //     );
//           //   },
//           //   error: (err, stack) => Center(child: Text('$err')),
//           //   loading: () => NoticeShimmer(),
//           // )
//       ),
//     );
//   }
//
// }
//
//
