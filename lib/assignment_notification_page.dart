

import 'package:eschool_teacher/api.dart';
import 'package:eschool_teacher/constants/snack_show.dart';
import 'package:eschool_teacher/features/authentication/providers/auth_provider.dart';
import 'package:eschool_teacher/features/providers/assignment_provider.dart';
import 'package:eschool_teacher/features/providers/status_provider.dart';
import 'package:eschool_teacher/features/services/assignment_services.dart';
import 'package:eschool_teacher/utils/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../constants/colors.dart';

class NotificationAssignmentPage extends ConsumerStatefulWidget {

  final String studentName;
  final int student_id;

  final int assignment_id;
  NotificationAssignmentPage({required this.studentName,required this.student_id, required this.assignment_id});

  @override
  ConsumerState<NotificationAssignmentPage> createState() => _NotificationAssignmentPageState();
}

class _NotificationAssignmentPageState extends ConsumerState<NotificationAssignmentPage> {



  final TextEditingController remarkController = TextEditingController();
  final _form = GlobalKey<FormState>();

  bool _accepted = false;
  bool _unaccepted = false;


  @override
  Widget build(BuildContext context) {




    final auth = ref.watch(authProvider);
    final studentAssignment = ref.watch(assignmentNotificationProvider(widget.assignment_id));
    final assignmentStatus = ref.watch(assignmentStatusList(auth.user.token));
    final assignment = ref.watch(assignmentProvider);
    print('student id ${widget.student_id}');


    ref.listen(statusProvider, (previous, next) {
      if(next.errorMessage.isNotEmpty){
        Navigator.of(context).pop();
        SnackShow.showFailure(context, next.errorMessage);
      }else if(next.isSuccess){
        ref.invalidate(assignmentStatusList(auth.user.token));

        Navigator.of(context).pop();
        SnackShow.showSuccess(context, 'Success');

      }
    });



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



          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: studentAssignment.when(
                data: (stud_data){

                  if(stud_data != null ){
                    final url = Uri.parse('${Api.basePicUrl}${stud_data[0].studentAssignment.path}');



                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        SizedBox(height: 20.h,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(


                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,


                                children: [
                                  Text("Title", style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text(stud_data[0].assignment.title,style: TextStyle(color: Colors.black,fontSize: 15.sp),maxLines: null,),

                                  SizedBox( height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Submitted By", style: TextStyle(fontWeight: FontWeight.bold),),
                                      Text(stud_data[0].student.studentName),
                                    ],
                                  )
                                ],
                              )),
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                          indent: 15.w,
                          endIndent: 15.w,
                        ),
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

                              if(stud_data[0].studentAssignment.path.endsWith('.jpg')||stud_data[0].studentAssignment.path.endsWith('.jpeg')||stud_data[0].studentAssignment.path.endsWith('.png')){
                                print('${Api.basePicUrl}${stud_data[0].studentAssignment.path}');
                                launchUrlString('${Api.basePicUrl}${stud_data[0].studentAssignment.path}');
                              }
                              else if(stud_data[0].studentAssignment.path.endsWith('.doc')||stud_data[0].studentAssignment.path.endsWith('.docx')||stud_data[0].studentAssignment.path.endsWith('.pdf')){
                                print('http://docs.google.com/viewer?url=${Api.basePicUrl}${stud_data[0].studentAssignment.path}');
                                launchUrlString('http://docs.google.com/viewer?url=${Api.basePicUrl}${stud_data[0].studentAssignment.path}');
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
                              final status = status_data.firstWhereOrNull((element) => element.studentAssignment.id == stud_data[0].id);

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
                                                    return Consumer(
                                                      builder: (context, ref, child){
                                                        final load = ref.watch(statusProvider);

                                                        return AlertDialog(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                          ),
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
                                                            ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                  backgroundColor: primary
                                                              ),
                                                              onPressed: load.isLoad ? null : () {
                                                                _form.currentState!.save();
                                                                if(_form.currentState!.validate()){
                                                                  if(_accepted == false && _unaccepted==false){
                                                                    SnackShow.showFailure(context, 'Please check one of the status box');
                                                                  }
                                                                  else {

                                                                    setState((){

                                                                      ref.read(statusProvider.notifier).addStatus(
                                                                          remarks: remarkController.text.trim(),
                                                                          status: _accepted == true? 'Accepted' : 'Unaccepted',
                                                                          notifications: true,
                                                                          studentAssignment: stud_data[0].id,
                                                                          token: auth.user.token
                                                                      );

                                                                    });

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
                                                        return Consumer(
                                                            builder: (context, ref, child){
                                                              final load = ref.watch(statusProvider);

                                                              return AlertDialog(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                                                                ),
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
                                                                  ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        backgroundColor: primary
                                                                    ),
                                                                    onPressed: load.isLoad ? null :() {
                                                                      _form.currentState!.save();
                                                                      if(_form.currentState!.validate()){
                                                                        if(_accepted == false && _unaccepted==false){
                                                                          SnackShow.showFailure(context, 'Please check one of the status box');
                                                                        }
                                                                        else {
                                                                          ref.read(statusProvider.notifier).editStatus(
                                                                              id: status.id,
                                                                              remarks: remarkController.text.trim(),
                                                                              status: _accepted == true? 'Accepted' : 'Unaccepted',
                                                                              notifications: false,
                                                                              studentAssignment: stud_data[0].id,
                                                                              token: auth.user.token
                                                                          );

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
                                                            }
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
                loading: () => Container(
                    height: 100.h,
                    child: ShimmerListTile3())
            ),
          ),





        ],
      ),
    );
  }
}
