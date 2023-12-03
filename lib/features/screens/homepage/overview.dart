import 'package:eschool_teacher/exceptions/internet_exceptions.dart';
import 'package:eschool_teacher/utils/commonWidgets.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../../api.dart';
import '../../../../../../constants/colors.dart';
import '../../../notification_service.dart';
import '../../../testpage/testpage.dart';
import 'teacher_attendance/attend_dialog.dart';
import '../screen2/class_tab/attendance_tab/edit_attendance.dart';
import '../../authentication/providers/auth_provider.dart';
import '../../services/info_services.dart';
import '../screen2/class_tab/class_page.dart';
import 'allClasses.dart';
import 'information_items/subject_announcement.dart';
import 'information_items/assignment.dart';
import 'information_items/exams.dart';
import 'information_items/calender.dart';
import 'information_items/lessons.dart';
import 'information_items/results.dart';
import 'information_items/topics.dart';
import 'notice_page.dart';

// OVERVIEW TEACHER

class Overview extends ConsumerStatefulWidget {
  @override
  ConsumerState<Overview> createState() => _OverviewState();
}

class _OverviewState extends ConsumerState<Overview> {



  @override
  void initState() {
    super.initState();

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 2. This method only call when App in foreground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
          (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);

        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    getToken();
  }



  Future<void> getToken()async{
    final response = await FirebaseMessaging.instance.getToken();
    print(response);
  }



  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    
    
    
    final String token = auth.user.token;
    final teacherClass = ref.watch(teacherSubList(token));
    final infoData = ref.watch(employeeList(auth.user.token));
    
    


    return ConnectivityChecker(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: bgColor,
        ),
          resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          child: Column(
            children: [


              Text("MY CLASS", style: TextStyle(
                fontSize: 18,
              ),),


              SizedBox(
                height: 20,
              ),



              Container(
                // color: Colors.blue,
                  height: MediaQuery.of(context).size.height * 1.2 / 4,
                  padding: EdgeInsets.only(left: 30.w),

                  child: teacherClass.when(
                    data: (class_data){

                    //  final class_data = data.where((element) => element.classSection.classTeacher.employeeName == auth.user.userInfo.name).toList();




                      return GridView.builder(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 2.w / 1.3.h, crossAxisCount: 2, mainAxisSpacing: 5.h, crossAxisSpacing: 3.w),
                          itemCount: class_data.length,
                          itemBuilder: (context,index){
                            return Stack(
                              children: [
                                GridTile(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: InkWell(
                                    onTap: () => Get.to(() => ClassPage(
                                      class_sec_id: class_data[index].classSection.id,
                                      token: '$token',
                                      class_teacher_name: class_data[index].classSection.classTeacher.employeeName,
                                      sec_name: class_data[index].classSection.section.sectionName,
                                      class_level_name: class_data[index].classSection.className.classLevel.name,
                                      teacher_id: class_data[index].classSection.classTeacher.id,
                                      class_teacher: false,
                                      class_id: class_data[index].classSection.className.id,
                                    )
                                    ),
                                      child: Container(
                                          height: 80.h,
                                          width: 150.w,
                                          color: primary,
                                          child: Center(
                                              child: Text(
                                                'Class ${class_data[index].classSection.className.classLevel.name} - ${class_data[index].classSection.section.sectionName}',
                                                style: TextStyle(color: Colors.white, fontSize: 15.sp),
                                              ))),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment(-0.20, 0.55),
                                  child: Card(
                                    elevation: 3,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.black,
                                        size: 20.sp,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }
                      );


                    },
                    error: (err, stack) => Center(child: Text('$err')),
                    loading: () =>  GridShimmer(),

                  )
              ),
              
              




            ],
          ),
        )




      ),
    );
  }
}


