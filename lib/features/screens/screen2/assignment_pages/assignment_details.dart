import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:eschool_teacher/constants/colors.dart';
import 'package:eschool_teacher/features/authentication/providers/auth_provider.dart';
import 'package:eschool_teacher/features/model/assignment.dart';
import 'package:eschool_teacher/features/providers/assignment_provider.dart';
import 'package:eschool_teacher/features/screens/screen2/assignment_pages/edit_assignment.dart';
import 'package:eschool_teacher/features/services/assignment_services.dart';
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
  final int class_subject_id;
  AssignmentDetails({required this.assignment,required this.classSubject, required this.class_subject_id});

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
    final assignment = ref.watch(assignmentDetailProvider(class_subject_id));


    return assignment.when(
        data: (data){
          return ListView.builder(
            physics: BouncingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index){

                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      Text('Title',style: TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.bold),),

                      SizedBox(height: 5.h,),
                      Text(data[index].title,style: TextStyle(color: Colors.black),),
                      SizedBox(height: 10.h,),

                      Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),

                      Text('Description',style: TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.bold),),
                      SizedBox(height: 5.h,),
                      Text(data[index].description,style: TextStyle(color: Colors.black),),
                      SizedBox(height: 10.h,),
                      Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      data[index].link != null ? Column(
                        children: [
                          ListTile(
                            onTap: (){
                              _redirect(data[index].link!);
                            },
                            contentPadding: EdgeInsets.zero,
                            title: Text('Link',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                            subtitle: Text(data[index].link!,style: TextStyle(color: bgColor, fontStyle: FontStyle.italic, decoration: TextDecoration.underline),),
                          ),
                          Divider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                        ],
                      ):SizedBox(),
                      SizedBox(height: 5.h,),
                      data[index].imageFile != null ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Image',style: TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.bold),),
                          InkWell(
                            onTap: () {
                              showImageViewer(context, CachedNetworkImageProvider('${Api.basePicUrl}${data[index].imageFile}'),
                                  swipeDismissible: false);
                            },
                            child: Text(data[index].imageFile!, style: TextStyle(color: bgColor, fontStyle: FontStyle.italic, decoration: TextDecoration.underline),),
                          ),
                        ],
                      ):SizedBox(),
                      SizedBox(height: 10.h,),

                      Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      data[index].hasDeadline==true? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text('Deadline',style: TextStyle(color: Colors.black,fontSize: 18.sp,fontWeight: FontWeight.bold),),

                          Text('${DateFormat('MMMM dd').format(DateTime.parse(data[index].deadline!))}',style: TextStyle(color: Colors.black,fontSize: 16.sp),),

                        ],
                      ): Text(''),
                    ],
                  ),
                );
              }
          );
        },
        error: (e, s) => Center(child: Text(e.toString()),),
        loading: () => Center(child: CircularProgressIndicator(),)
    );
  }
}
