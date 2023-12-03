import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eschool_teacher/constants/snack_show.dart';
import 'package:eschool_teacher/features/authentication/providers/auth_provider.dart';
import 'package:eschool_teacher/features/screens/screen2/assignment_pages/add_assignment.dart';
import 'package:eschool_teacher/features/screens/screen2/assignment_pages/assignment_tabs.dart';
import 'package:eschool_teacher/features/screens/screen2/class_tab/subjects_tab/subject_announcements/add_announcements.dart';
import 'package:eschool_teacher/features/services/assignment_services.dart';
import 'package:eschool_teacher/features/services/feature_services.dart';

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
import '../../../providers/assignment_provider.dart';
import '../../../services/notice_services.dart';
import '../../../services/subject_class_service.dart';

class AssignmentPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<AssignmentPage> createState() => _AssignmentPageState();
}

class _AssignmentPageState extends ConsumerState<AssignmentPage> {

  TeacherClass className = TeacherClass(classSection: ClassSection.empty());

  ClassSecSubject subjectName = ClassSecSubject(id: 0, subject: Subject.empty(),);

  @override
  Widget build(BuildContext context,) {

    final auth = ref.watch(authProvider);
    final assignmentInfo = ref.watch(assignmentList(auth.user.token));
    final classSubInfo = ref.watch(classSubInfo2(auth.user.token));



    return ConnectivityChecker(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: bgColor,
          title: Text("Assignment", style: TextStyle(color: Colors.white),),
        ),
        backgroundColor: Colors.white,
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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

                 //   final class_data = models.where((element) => element.classSection.classTeacher.employeeName == auth.user.userInfo.name).toList();

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
                    final response = await Dio().get('${Api.classSecSubUrl}${className.classSection.id}/',
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
                  child: Text('Assignments',style: TextStyle(color: Colors.black,fontSize: 20.sp,fontWeight: FontWeight.bold),),
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
              child: classSubInfo.when(
                  data: (class_sub_data){
                    final subInfo =class_sub_data.where((element) => element.id == subjectName.id).toList();
                    if(subInfo.isNotEmpty){
                      return  assignmentInfo.when(
                        data: (data) {
                          if(subjectName == ''){
                            print(null);
                          }
                          else{
                            print(subjectName);
                          }

                          final assignment_data = data.where((element) => element.classSubject.id== subjectName.id).toList();
                          if (assignment_data.isNotEmpty) {
                            return Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      itemCount: assignment_data.length,
                                      itemBuilder: (context,index){
                                        return NoticeCard2(
                                            onLongPress: ()async{

                                              showDialog(
                                                  context: context,
                                                  builder: (context){
                                                    return AlertDialog(
                                                      backgroundColor: Colors.white,
                                                      title: Text('Do you want to delete the assignment',style: TextStyle(color: Colors.black),),
                                                      actions: [
                                                        TextButton(
                                                            style: TextButton.styleFrom(
                                                                backgroundColor: primary,
                                                                foregroundColor: Colors.white
                                                            ),
                                                            onPressed: (){
                                                              ref.read(assignmentProvider.notifier).delAssignment(assignment_data[index].id, auth.user.token).then((value) => ref.refresh(assignmentList(auth.user.token))).then((value) => Navigator.pop(context));
                                                            },
                                                            child: Text('Yes')
                                                        ),
                                                        TextButton(
                                                            onPressed: (){
                                                              Navigator.pop(context);
                                                            },
                                                            child: Text('No',style: TextStyle(color: Colors.black),)
                                                        )
                                                      ],
                                                    );
                                                  }
                                              );

                                            },

                                            onTap:()=> Get.to(()=>AssignmentTabs(assignment: assignment_data[index])),
                                            title: assignment_data[index].title,
                                            createdAt: DateFormat('MMMM dd').format(DateTime.parse(assignment_data[index].createdAt)));
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
                                          Get.to(()=>Add_Assignment(classSubject: subInfo.first));
                                        }
                                    ),
                                  ),
                                )
                              ],
                            );

                          }
                          else{
                            return Column(
                              children: [
                                Expanded(child: Center(child: Text('No assignment',style: TextStyle(color: Colors.black,fontSize: 30.sp),))),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 25.w),
                                    child: FloatingActionButton(
                                        backgroundColor: primary,
                                        child: Icon(Icons.add,color: Colors.white,),
                                        onPressed: (){
                                          Get.to(()=>Add_Assignment(classSubject: subInfo.first,));
                                        }
                                    ),
                                  ),
                                )
                              ],
                            );



                          }




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
                loading: () => null,
              )



            ),




          ],
        ),
      ),
    );

  }
}
