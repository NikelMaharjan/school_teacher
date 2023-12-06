

import 'package:eschool_teacher/constants/colors.dart';
import 'package:eschool_teacher/exceptions/internet_exceptions.dart';
import 'package:eschool_teacher/features/authentication/providers/auth_provider.dart';
import 'package:eschool_teacher/features/screens/homepage/time_schedule/routine_tab.dart';
import 'package:eschool_teacher/features/screens/homepage/time_schedule/timetable.dart';
import 'package:eschool_teacher/features/services/info_services.dart';
import 'package:eschool_teacher/utils/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';





class TimeTable1 extends ConsumerStatefulWidget {

  @override
  ConsumerState<TimeTable1> createState() => _TimeTable1State();
}

class _TimeTable1State extends ConsumerState<TimeTable1>  {
  @override
  Widget build(BuildContext context) {

    final auth = ref.watch(authProvider);

    final String token = auth.user.token;

    final teacherClass = ref.watch(teacherSubList(token));

    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule", style: TextStyle(color: Colors.white),),
        backgroundColor: bgColor,
      ),
      body: Column(
        children: [

          SizedBox(height: 20,),

          Container(
            // color: Colors.blue,
              height: MediaQuery.of(context).size.height * 1.2 / 4,
              padding: EdgeInsets.only(left: 30.w),

              child: teacherClass.when(
                data: (class_data){


                  return GridView.builder(
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 2.w / 1.3.h, crossAxisCount: 2, mainAxisSpacing: 5.h, crossAxisSpacing: 3.w),
                      itemCount: class_data.length,
                      itemBuilder: (context,index){
                        return InkWell(
                          onTap: (){
                            Get.to(TimeTable(), transition: Transition.leftToRight);
                          },
                          child: Stack(
                            children: [
                              GridTile(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
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
                          ),
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

    );




  }
}
