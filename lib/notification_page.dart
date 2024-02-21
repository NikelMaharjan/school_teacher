import 'package:connectivity/connectivity.dart';
import 'package:eschool_teacher/features/providers/notification_provider.dart';
import 'package:eschool_teacher/features/screens/homepage/information_items/assignment.dart';
import 'package:eschool_teacher/features/screens/homepage/information_items/calender.dart';
import 'package:eschool_teacher/features/screens/homepage/information_items/exams.dart';
import 'package:eschool_teacher/features/screens/homepage/notice_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../constants/colors.dart';
import '../../../../../../utils/commonWidgets.dart';
import '../../../../../exceptions/internet_exceptions.dart';
import 'assignment_notification_page.dart';
import 'features/authentication/providers/auth_provider.dart';
import 'notification_service.dart';










class NotificationPage extends ConsumerStatefulWidget {

  final String notification_token;
  NotificationPage({required this.notification_token});


  @override
  ConsumerState<NotificationPage> createState() =>
      _ClassNoticeBoardState();
}

class _ClassNoticeBoardState extends ConsumerState<NotificationPage>
    with TickerProviderStateMixin {

  final notificationTypes = [ 'Calendar events','Notice', 'Invigillator info', 'Class section', 'Class notice','Assignment', 'Student assignment', 'Student total fee', 'Exam class', 'Admit card', 'Total exam marks', 'Assignment status'];



  late TabController _tabController;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);

  }




  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    print('notification page : ${widget.notification_token}');
    final notificationData = ref.watch(notificationProvider2(widget.notification_token));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text("Notification", style: TextStyle(color: Colors.white),),
      ),
      backgroundColor: Colors.white,
      body:SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              notificationData.when(
                data: (data) {
                  data.sort((a, b) => b.id.compareTo(a.id));
                  return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final types=data[index].notificationType;
                        return NotificationCard(
                          title: data[index].title,
                          description: data[index].body,
                          color: data[index].seen == true? Colors.white : Colors.red.withOpacity(0.2),
                          onTap: (){


                            ref.read(notificationUpdater.notifier).updateSeen(
                              id: data[index].id,
                              token: auth.user.token,
                            ).then((value) => ref.refresh(notificationProvider2(widget.notification_token)))
                                .then((value) => print('Successful'));


                            if(types==notificationTypes[0]){
                              Get.to(()=>Calender());
                            }
                            else if(types==notificationTypes[1]||types==notificationTypes[4]){
                              Get.to(()=>NoticeBoard());
                            }
                            else if(types==notificationTypes[6]){

                              Get.to(()=>NotificationAssignmentPage(studentName: '', student_id: 1, assignment_id: data[index].objectId,));
                            }
                            else if(types==notificationTypes[8]){
                              Get.to(()=>ExamPage());
                            }
                            else if(types==notificationTypes[10]){

                            }
                            else{
                              return;
                            }




                          },
                        );
                      });
                },
                error: (err, stack) => Center(child: Text('$err',style: TextStyle(color: Colors.black),)),
                loading: () => NoticeShimmer(),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.small(
        backgroundColor: bgColor,
        child: Icon(Icons.refresh, color: Colors.white,),
          onPressed: (){
        ref.invalidate(notificationProvider2("123"));
      }),

    );
  }
}
