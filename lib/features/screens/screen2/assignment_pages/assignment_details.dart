import 'package:eschool_teacher/constants/colors.dart';
import 'package:eschool_teacher/features/authentication/providers/auth_provider.dart';
import 'package:eschool_teacher/features/model/assignment.dart';
import 'package:eschool_teacher/features/providers/assignment_provider.dart';
import 'package:eschool_teacher/features/screens/screen2/assignment_pages/edit_assignment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../api.dart';
import '../../../model/class_subject.dart';

class AssignmentDetails extends ConsumerWidget {
  final Assignment assignment;
  final ClassSubject classSubject;
  AssignmentDetails({required this.assignment,required this.classSubject});

  Future<void> _redirect(String website) async {
    final Uri launchUri = Uri(
      scheme: 'https',
      path: website,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context,ref) {
    final auth = ref.watch(authProvider);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(height: 20.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width*1/2,
                  child: Text(assignment.title,style: TextStyle(color: Colors.black,fontSize: 20.sp),)),
              Row(
                children: [
                  IconButton(

                    onPressed: (){
                      Get.to(()=>Edit_Assignment(assignment: assignment, classSubject: classSubject));
                    },
                    icon: Icon(Icons.edit,color: Colors.black,),),

                ],
              )
            ],
          ),
          Divider(
            thickness: 1,
            color: Colors.black,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Description',style: TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.bold),),
              Text(DateFormat('MMMM dd').format(DateTime.parse(assignment.createdAt)),style: TextStyle(color: Colors.black,fontSize: 15.sp,),),
            ],
          ),
          SizedBox(height: 5.h,),
          Text(assignment.description,style: TextStyle(color: Colors.black),),
          SizedBox(height: 5.h,),
          assignment.link != null ? ListTile(
            onTap: (){
              _redirect(assignment.link!);
            },
            contentPadding: EdgeInsets.zero,
            title: Text('Link',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            subtitle: Text(assignment.link!,style: TextStyle(color: Colors.black),),
          ):SizedBox(),
          SizedBox(height: 5.h,),
          assignment.imageFile != null ? Container(
              height: 200.h,
              width: double.infinity,
              child: Image.network('${Api.basePicUrl}${assignment.imageFile}',fit: BoxFit.contain ,)):SizedBox(),
          Divider(
            thickness: 1,
            color: Colors.black,
          ),
          assignment.hasDeadline==true? Text('Deadline: ${DateFormat('MMMM dd').format(DateTime.parse(assignment.deadline!))}',style: TextStyle(color: Colors.black,fontSize: 20.sp),): Text(''),
        ],
      ),
    );
  }
}
