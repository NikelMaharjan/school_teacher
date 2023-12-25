




import 'package:eschool_teacher/features/authentication/providers/auth_provider.dart';
import 'package:eschool_teacher/features/screens/homepage/teacher_attendance/leave_note.dart';
import 'package:eschool_teacher/features/screens/screen2/class_tab/class_notice/class_notice.dart';
import 'package:eschool_teacher/features/services/info_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../utils/commonWidgets.dart';

class ClassNotice extends ConsumerWidget {

  @override
  Widget build(BuildContext context,ref) {

    final auth = ref.watch(authProvider);
    final String token = auth.user.token;
    final teacherClass = ref.watch(teacherSubList(token));
    final infoData = ref.watch(employeeList(auth.user.token));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text("Notice Board", style: TextStyle(color: Colors.white),),
      ),
      body:Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          infoData.when(
            data: (info_data){
              final infoData= info_data.firstWhere((element) => element.email==auth.user.userInfo.email);
              return teacherClass.when(
                data: (class_data){
                  return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      shrinkWrap: true,
                      itemCount: class_data.length,
                      itemBuilder: (context,index){
                        return  InfoTileWidget(
                            title: 'Class ${class_data[index].classSection.className.classLevel.name} ${class_data[index].classSection.section.sectionName}',
                              
                              text: class_data[index].classSection.className.classLevel.name.substring(0,1),

                              onTap: (){
                              Get.to(()=> ClassNoticeBoard(
                                  class_sec_id: class_data[index].classSection.id,
                                  teacher_id: class_data[index].classSection.classTeacher.id
                              )
                              );


                              },


                              // onTap: ()=> Get.to(() => ClassPage(
                              //
                              //   class_id: 12222,
                              //   class_sec_id: class_data[index].classSection.id, token: '$token', sec_name: class_data[index].classSection.section.sectionName, class_level_name: class_data[index].classSection.className.classLevel.name, teacher_id: infoData.id, class_teacher: class_data[index].classSection.classTeacher=='true' ? true:false,)),


                        );
                        //CommonCard(
                        //     onTap: () => Get.to(() => ClassPage(class_sec_id: class_data[index].id, token: '$token', sec_name: class_data[index].section, class_level_name: class_data[index].classLevel, teacher_id: infoData.id, school_id: 1,)),
                        //     time: 'Class ${class_data[index].classLevel}${class_data[index].section}',
                        //     className: '',
                        //     subjectName: class_data[index].classTeacher== true? 'Class Teacher' : ''
                        // );
                      }
                  );
                },
                error: (err, stack) => Center(child: Text('$err')),
                loading: () =>  ShimmerListTile(),

              );
            },
            error: (err, stack) => Center(child: Text('$err')),
            loading: () =>  ShimmerListTile(),
          ),
        ],
      ) ,
    );
  }
}
