
import 'dart:ffi';
import 'dart:io';

import 'package:eschool_teacher/api.dart';
import 'package:eschool_teacher/constants/snack_show.dart';
import 'package:eschool_teacher/features/authentication/providers/auth_provider.dart';
import 'package:eschool_teacher/features/providers/assignment_provider.dart';
import 'package:eschool_teacher/features/services/assignment_services.dart';
import 'package:eschool_teacher/utils/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../constants/colors.dart';
import '../../../model/assignment.dart';
import 'package:open_filex/open_filex.dart';
import 'package:url_launcher/url_launcher.dart';

class AssignmentStatus extends ConsumerStatefulWidget {

  final Assignment assignment;
  final String studentName;
  final int student_id;
  AssignmentStatus({required this.assignment,required this.studentName,required this.student_id});

  @override
  ConsumerState<AssignmentStatus> createState() => _AssignmentStatusState();
}

class _AssignmentStatusState extends ConsumerState<AssignmentStatus> {


  final TextEditingController remarkController = TextEditingController();
  final _form = GlobalKey<FormState>();

  bool _accepted = false;
  bool _unaccepted = false;

  @override
  Widget build(BuildContext context) {



    final auth = ref.watch(authProvider);
    final studentAssignment = ref.watch(studentAssignmentProvider(auth.user.token));
    final assignmentStatus = ref.watch(assignmentStatusList(auth.user.token));
    print('assignment id ${widget.assignment.id}');
    print('student id ${widget.student_id}');



    _launchURL(String url) async {
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {
        throw 'Could not launch $url';
      }
    }



    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text(widget.studentName, style: TextStyle(color: Colors.white),),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [


          SizedBox(height: 20.h,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w),

              child: Column(
                children: [
                  Text("Title", style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(widget.assignment.title,style: TextStyle(color: Colors.black,fontSize: 15.sp),maxLines: null,),
                ],
              )),
          Divider(
            thickness: 1,
            color: Colors.black,
            indent: 15.w,
            endIndent: 15.w,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: studentAssignment.when(
                data: (data){
                  final stud_data = data.firstWhereOrNull((element) => element.assignment.id == widget.assignment.id&& element.student.id == widget.student_id);
                  if(stud_data != null ){
                    final url = Uri.parse('${Api.basePicUrl}${stud_data.studentAssignment.path}');



                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(

                          decoration: BoxDecoration(
                              color: shimmerHighlightColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.black
                              )
                          ),
                          child: ListTile(
                            onTap: () {

                              if(stud_data.studentAssignment.path.endsWith('.jpg')||stud_data.studentAssignment.path.endsWith('.jpeg')||stud_data.studentAssignment.path.endsWith('.png')){
                                print('${Api.basePicUrl}${stud_data.studentAssignment.path}');
                                launchUrlString('${Api.basePicUrl}${stud_data.studentAssignment.path}');
                              }
                              else if(stud_data.studentAssignment.path.endsWith('.doc')||stud_data.studentAssignment.path.endsWith('.docx')||stud_data.studentAssignment.path.endsWith('.pdf')){
                                print('http://docs.google.com/viewer?url=${Api.basePicUrl}${stud_data.studentAssignment.path}');
                                launchUrlString('http://docs.google.com/viewer?url=${Api.basePicUrl}${stud_data.studentAssignment.path}');
                              }
                              else{
                                SnackShow.showFailure(context, 'Submitted in wrong format');
                              }


                              // launchUrl(url);
                            },
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('View Assignment',style: TextStyle(color: Colors.black),),
                                Icon(Icons.arrow_circle_right_sharp,color: Colors.black,)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h,),

                        assignmentStatus.when(
                            data: (status_data){
                              final status = status_data.firstWhereOrNull((element) => element.studentAssignment.id == stud_data.id);

                              if(status == null){
                                return Container(

                                    decoration: BoxDecoration(
                                        color: shimmerHighlightColor,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.black
                                        )
                                    ),
                                    child: ListTile(
                                      onTap: (){
                                        showDialog(
                                            context: context,
                                            builder: (context){
                                              return StatefulBuilder(
                                                builder: (BuildContext context, StateSetter setState) {
                                                  return AlertDialog(
                                                    backgroundColor: Colors.white,
                                                    title: Text('Status',style: TextStyle(color: Colors.black),),
                                                    content: Form(
                                                      key: _form,
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          CheckboxListTile(
                                                            side: BorderSide(
                                                              color : Colors.black
                                                            ),
                                                            activeColor: pre_color,
                                                            checkboxShape:RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(5),

                                                            ),
                                                            title: Text('Accepted',style: TextStyle(color: Colors.black)),
                                                            value: _accepted,
                                                            onChanged: (newValue) {
                                                              setState(() {
                                                                _accepted = newValue!;
                                                                if (_accepted) {
                                                                  _unaccepted = false;
                                                                }
                                                              });
                                                            },
                                                          ),
                                                          CheckboxListTile(
                                                            side: BorderSide(
                                                                color : Colors.black
                                                            ),
                                                            activeColor: abs_color,
                                                            checkboxShape:RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(5),

                                                            ),
                                                            title: Text('Unaccepted',style: TextStyle(color: Colors.black)),
                                                            value: _unaccepted,
                                                            onChanged: (newValue) {
                                                              setState(() {
                                                                _unaccepted = newValue!;
                                                                if (_unaccepted) {
                                                                  _accepted = false;
                                                                }
                                                              });
                                                            },
                                                          ),
                                                          SizedBox(height: 5.h,),
                                                          Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                  color: shimmerHighlightColor,
                                                                  border: Border.all(color: Colors.black)),
                                                              child: TextFormField(
                                                                maxLines: 2,
                                                                controller: remarkController,
                                                                validator: (value) {
                                                                  if (value!.isEmpty) {
                                                                    return SnackShow.showFailure(context, 'Remarks cannot be empty');
                                                                  }else if(value.length >50){
                                                                    return SnackShow.showFailure(context, 'Word limit exceeded');
                                                                  }
                                                                  return null;
                                                                },
                                                                style: TextStyle(
                                                                    color: Colors.black, fontSize: 15.sp),
                                                                decoration: InputDecoration(
                                                                    focusedBorder: InputBorder.none,
                                                                    border: InputBorder.none,
                                                                    hintText: 'Remarks',
                                                                    hintStyle: TextStyle(
                                                                        color: Colors.black, fontSize: 15.sp),
                                                                    contentPadding: EdgeInsets.only(
                                                                        top: 8.h,
                                                                        left: 8.w,
                                                                        bottom: 8.h,
                                                                        right: 8.w)),
                                                              )),
                                                        ],
                                                      ),
                                                    ),

                                                    actionsAlignment: MainAxisAlignment.spaceEvenly,
                                                    actions: [
                                                      TextButton(
                                                        style: TextButton.styleFrom(
                                                            backgroundColor: primary
                                                        ),
                                                        onPressed: () {
                                                          _form.currentState!.save();
                                                          if(_form.currentState!.validate()){
                                                            if(_accepted == false && _unaccepted==false){
                                                            SnackShow.showFailure(context, 'Please check one of the status box');
                                                          }
                                                          else {
                                                            ref.read(assignmentProvider.notifier).addStatus(
                                                                remarks: remarkController.text.trim(),
                                                                status: _accepted == true? 'Accepted' : 'Unaccepted',
                                                                notifications: false,
                                                                studentAssignment: stud_data.id,
                                                                token: auth.user.token
                                                            ).then((value) => ref.refresh(assignmentStatusList(auth.user.token)))
                                                                .then((value) => Navigator.pop(context));
                                                          }
                                                          }
                                                        },


                                                        child: Text('Submit',style: TextStyle(color: Colors.white),),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text('Cancel',style: TextStyle(color: Colors.black)),
                                                      ),

                                                    ],
                                                  );
                                                },
                                              );

                                            }
                                        );
                                      },
                                      title: Text('Status',style: TextStyle(color: Colors.black),),
                                      trailing:Text('Pending',style: TextStyle(color: Colors.grey),)
                                    )
                                );
                              }

                              else{
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(

                                        decoration: BoxDecoration(
                                            color: status.status == 'Accepted' ? pre_color : abs_color,
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.black
                                            )
                                        ),
                                        child: ListTile(
                                            onTap: (){
                                              showDialog(
                                                  context: context,
                                                  builder: (context){
                                                    return StatefulBuilder(
                                                      builder: (BuildContext context, StateSetter setState) {
                                                        return AlertDialog(
                                                          backgroundColor: Colors.white,
                                                          title: Text('Edit Status',style: TextStyle(color: Colors.black),),
                                                          content: Form(
                                                            key: _form,
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                CheckboxListTile(
                                                                  side: BorderSide(
                                                                      color : Colors.black
                                                                  ),
                                                                  activeColor: pre_color,
                                                                  checkboxShape:RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(5),

                                                                  ),
                                                                  title: Text('Accepted',style: TextStyle(color: Colors.black)),
                                                                  value: _accepted,
                                                                  onChanged: (newValue) {
                                                                    setState(() {
                                                                      _accepted = newValue!;
                                                                      if (_accepted) {
                                                                        _unaccepted = false;
                                                                      }
                                                                    });
                                                                  },
                                                                ),
                                                                CheckboxListTile(
                                                                  side: BorderSide(
                                                                      color : Colors.black
                                                                  ),
                                                                  activeColor: abs_color,
                                                                  checkboxShape:RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(5),

                                                                  ),
                                                                  title: Text('Unaccepted',style: TextStyle(color: Colors.black)),
                                                                  value: _unaccepted,
                                                                  onChanged: (newValue) {
                                                                    setState(() {
                                                                      _unaccepted = newValue!;
                                                                      if (_unaccepted) {
                                                                        _accepted = false;
                                                                      }
                                                                    });
                                                                  },
                                                                ),
                                                                SizedBox(height: 5.h,),
                                                                Container(
                                                                    decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.circular(10),
                                                                        color: shimmerHighlightColor,
                                                                        border: Border.all(color: Colors.black)),
                                                                    child: TextFormField(
                                                                      maxLines: 2,
                                                                      controller: remarkController,
                                                                      validator: (value) {
                                                                        if (value!.isEmpty) {
                                                                          return SnackShow.showFailure(context, 'Remarks cannot be empty');
                                                                        }else if(value.length >50){
                                                                          return SnackShow.showFailure(context, 'Word limit exceeded');
                                                                        }
                                                                        return null;
                                                                      },
                                                                      style: TextStyle(
                                                                          color: Colors.black, fontSize: 15.sp),
                                                                      decoration: InputDecoration(
                                                                          focusedBorder: InputBorder.none,
                                                                          border: InputBorder.none,
                                                                          hintText: 'Remarks',
                                                                          hintStyle: TextStyle(
                                                                              color: Colors.black, fontSize: 15.sp),
                                                                          contentPadding: EdgeInsets.only(
                                                                              top: 8.h,
                                                                              left: 8.w,
                                                                              bottom: 8.h,
                                                                              right: 8.w)),
                                                                    )),
                                                              ],
                                                            ),
                                                          ),

                                                          actionsAlignment: MainAxisAlignment.spaceEvenly,
                                                          actions: [
                                                            TextButton(
                                                              style: TextButton.styleFrom(
                                                                  backgroundColor: primary
                                                              ),
                                                              onPressed: () {
                                                                _form.currentState!.save();
                                                                if(_form.currentState!.validate()){
                                                                  if(_accepted == false && _unaccepted==false){
                                                                    SnackShow.showFailure(context, 'Please check one of the status box');
                                                                  }
                                                                  else {
                                                                    ref.read(assignmentProvider.notifier).editStatus(
                                                                         id: status.id,
                                                                        remarks: remarkController.text.trim(),
                                                                        status: _accepted == true? 'Accepted' : 'Unaccepted',
                                                                        notifications: false,
                                                                        studentAssignment: stud_data.id,
                                                                        token: auth.user.token
                                                                    ).then((value) => ref.refresh(assignmentStatusList(auth.user.token))).then((value) => Navigator.pop(context));

                                                                  }

                                                                }
                                                              },
                                                              child: Text('Submit',style: TextStyle(color: Colors.white),),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(context);
                                                              },
                                                              child: Text('Cancel',style: TextStyle(color: Colors.black)),
                                                            ),

                                                          ],
                                                        );
                                                      },
                                                    );

                                                  }
                                              );
                                            },
                                            title: Text('Status',style: TextStyle(color: Colors.white),),
                                            trailing:Text(status.status,style: TextStyle(color: Colors.white),)
                                        )
                                    ),
                                    NoticeCard(
                                        title: 'Remarks',
                                        description: status.remarks,
                                        createdAt: status.createdAt
                                    )
                                  ],
                                );
                              }


                            },
                            error: (err, stack) => Center(child: Text('$err')),
                            loading: () =>
                                Container(
                                    height:100.h,
                                    child: ShimmerListTile3())
                        ),



                      ],
                    );

                  }
                  else{
                    return Container(
                      child: Text(
                        'No Submission',style: TextStyle(color: Colors.black,fontSize: 15.sp,fontWeight: FontWeight.bold),
                      ),
                    );

                  }

                },
                error: (err, stack) => Center(child: Text('$err')),
                loading: () =>
                    Container(
                        height: 100.h,
                        child: ShimmerListTile3())),
          ),





        ],
      ),
    );
  }
}

