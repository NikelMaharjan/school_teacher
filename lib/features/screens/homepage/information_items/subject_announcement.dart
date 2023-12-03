import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eschool_teacher/constants/snack_show.dart';
import 'package:eschool_teacher/features/authentication/providers/auth_provider.dart';
import 'package:eschool_teacher/features/screens/screen2/class_tab/subjects_tab/subject_announcements/add_announcements.dart';

import 'package:eschool_teacher/utils/commonWidgets.dart';
import 'package:eschool_teacher/utils/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../api.dart';
import '../../../../constants/colors.dart';
import '../../../../exceptions/internet_exceptions.dart';
import '../../../model/class_subject.dart';
import '../../../model/teacher_features.dart';
import '../../../services/notice_services.dart';
import '../../../services/subject_class_service.dart';

class AnnouncementPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends ConsumerState<AnnouncementPage> {

  TeacherClass className = TeacherClass(classSection: ClassSection.empty());

  ClassSecSubject subjectName = ClassSecSubject(id: 0, subject: Subject.empty(),);

  @override
  Widget build(BuildContext context,) {

    final auth = ref.watch(authProvider);
    final classSubNotice = ref.watch(subNoticeList(auth.user.token));
    final classSub = ref.watch(classSubInfo2(auth.user.token));


    return ConnectivityChecker(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.7 / 5,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(25))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Announcement',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 40.h,
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                )),
            SizedBox(height: 20.h,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              width: 350.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Colors.black
                  )
              ),
              child: DropdownSearch<TeacherClass>(

                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (val){
                  if(val == null){
                    return 'Field can\'t be empty';
                  }
                  return null;
                },
                popupProps:  PopupProps.menu(
                  containerBuilder: (BuildContext context, Widget child) {
                    return Container(
                      constraints: BoxConstraints(minHeight: 100),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: child,
                    );
                  },
                  loadingBuilder: (context, index) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  itemBuilder: (BuildContext context, dynamic item, bool isSelected) {
                    return Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.grey[300] : null,
                      ),
                      child: ListTile(
                        title: Text(
                          item.toString(),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                dropdownDecoratorProps: const DropDownDecoratorProps(
                    textAlign: TextAlign.start,
                    baseStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w500,color: Colors.black),
                    dropdownSearchDecoration: InputDecoration(
                        label: Text('Class'),
                        labelStyle: TextStyle(color: Colors.grey)
                    )
                ),
                asyncItems: (String filter) async {
                  try{
                    final response = await Dio().get(
                        Api.teacherClass,
                        options: Options(
                            headers: {HttpHeaders.authorizationHeader: 'token ${auth.user.token}'})
                    );
                    final models = (response.data['data'] as List).map((e) => TeacherClass.fromJson(e)).toList();
                    return models;
                  }catch(err){
                    throw 'Check your connection';
                  }

                },
                onChanged: (TeacherClass? data) {
                  setState(() {
                    className = data!;
                  });
                },
              ),
            ),
            SizedBox(height: 10.h,),


            Container(

              padding: EdgeInsets.symmetric(horizontal: 10.w),
              width: 350.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Colors.black
                  )
              ),
              child: DropdownSearch<ClassSecSubject>(

                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (val){
                  if(val == null){
                    return 'Field can\'t be empty';
                  }
                  return null;
                },
                popupProps:  PopupProps.menu(
                  containerBuilder: (BuildContext context, Widget child) {
                    return Container(
                      constraints: BoxConstraints(minHeight: 100),
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: child,
                    );
                  },
                  loadingBuilder: (context, index) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  itemBuilder: (BuildContext context, dynamic item, bool isSelected) {
                    return Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.grey[300] : null,
                      ),
                      child: ListTile(
                        title: Text(
                          item.toString(),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  },


                ),


                dropdownDecoratorProps: const DropDownDecoratorProps(
                    textAlign: TextAlign.start,
                    baseStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w500,color: Colors.black),
                    dropdownSearchDecoration: InputDecoration(
                        label: Text('Subject',),
                        labelStyle: TextStyle(color: Colors.grey)
                    )
                ),
                asyncItems: (String filter) async {
                  try{
                    final response = await Dio().get(
                        '${Api.classSecSubUrl}${className.classSection.id}/',
                        options: Options(
                            headers: {HttpHeaders.authorizationHeader: 'token ${auth.user.token}'})
                    );
                    final models = (response.data['data'] as List).map((e) => ClassSecSubject.fromJson(e)).toList();
                    return models;
                  }catch(err){
                    print(err);
                    if(className.classSection == ClassSection.empty()){
                      throw 'Please select class first';
                    }
                    else {
                      throw 'No internet connection';
                    }
                  }

                },
                onChanged: (ClassSecSubject? data) {
                  setState(() {
                    subjectName = data!;
                  });
                },
              ),
            ),

            SizedBox(height: 10.h,),

            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 15.w),
                  child: Text('Announcements',style: TextStyle(color: Colors.black,fontSize: 20.sp,fontWeight: FontWeight.bold),),
                )),
            Divider(
              height: 20.h,
              thickness: 1,
              color: Colors.black,
              indent: 15.h,
              endIndent: 15.h,
            ),

            Container(
              // color: Colors.red,
              height: MediaQuery.of(context).size.height*3/5,
              child: classSub.when(
                data: (data){
                  print('class sec ${className.classSection.id}');
                  print('sub ${subjectName.subject.id}');
                  print('class sub ${subjectName.id}');

                  final class_sub = data.where((element) => element.id == subjectName.id).toList();

                  if(class_sub.isNotEmpty){
                    print('${class_sub.first.id}');
                    return classSubNotice.when(
                      data: (notice_data) {
                        final notice_list = notice_data.where((element) => element.subjectName?.id == class_sub.first.id).toList();
                        if (notice_list.length == 0) {
                          return Column(
                            children: [
                              Expanded(child: Center(child: Text('No announcement',style: TextStyle(color: Colors.black,fontSize: 30.sp),))),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 25.w),
                                  child: FloatingActionButton(
                                      backgroundColor: primary,
                                      child: Icon(Icons.add,color: Colors.white,),
                                      onPressed: (){
                                        Get.to(()=>SubjectNoticeForm(class_sec_id: className.classSection.id, sub_id: subjectName.id));
                                      }
                                  ),
                                ),
                              )
                            ],
                          );
                        }
                        return Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                  shrinkWrap: true,

                                  itemCount: notice_list.length,
                                  itemBuilder: (context,index){
                                    return NoticeCard(
                                        title: notice_list[index].title,
                                        description: notice_list[index].message,
                                        createdAt: '${notice_list[index].createdAt}'
                                    );
                                  }
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 25.w),
                                child: FloatingActionButton(
                                    backgroundColor: primary,
                                    child: Icon(Icons.add,color: Colors.white,),
                                    onPressed: (){
                                      Get.to(()=>SubjectNoticeForm(class_sec_id: className.classSection.id, sub_id: subjectName.id));
                                    }
                                ),
                              ),
                            )
                          ],
                        );
                      },
                      error: (err, stack) => Center(child: Text('$err')),
                      loading: () => null,
                    );

                  } else {
                    return Text(
                      'Please select both class and subject',
                      style: TextStyle(color: Colors.black),
                    );
                  }







                },
                error: (err, stack) => Center(child: Text('$err')),
                loading: () =>  null,

              ),
            ),




          ],
        ),
      ),
    );

  }
}
