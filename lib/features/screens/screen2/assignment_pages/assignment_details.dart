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

    final Uri url = Uri.parse(website);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch $url";
    }

  }

  @override
  Widget build(BuildContext context,ref) {



    final auth = ref.watch(authProvider);
    final assignment = ref.watch(assignmentDetailProvider(class_subject_id));


    return assignment.when(
        data: (data){
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index){

                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      DataTable(
                        // datatable widget
                        columns: [
                          // column to set the name
                          const DataColumn(label: Text('Title'),),
                          DataColumn(label: Text(data[index].title),),
                        ],

                        rows: [
                          // row to set the values
                          DataRow(
                              cells: [
                                const DataCell(Text('Description')),
                                DataCell(InkWell(

                                  onTap: (){
                                    showDialog (
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: const RoundedRectangleBorder(borderRadius:
                                          BorderRadius.all(Radius.circular(10))),
                                          title: const Text('Description!'),
                                          content: Text(data[index].description),
                                          actions: [

                                            TextButton(
                                              child: const Text('OK',),
                                              onPressed: () {

                                                Navigator.of(context).pop();


                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },

                                  child: SizedBox(
                                    width: 180.w,
                                    child: Text(data[index].description, style: TextStyle(
                                        color: bgColor,
                                        decoration: TextDecoration.underline,
                                        fontStyle: FontStyle.italic,
                                        overflow: TextOverflow.ellipsis

                                    ),
                                    ),
                                  ),
                                )),
                              ]
                          ),


                          DataRow(
                              cells: [
                                const DataCell(Text('Link')),
                                DataCell(data[index].link != null ? InkWell(
                                    onTap: (){
                                      _redirect(data[index].link!);

                                    },
                                    child: SizedBox(
                                      width: 180.w,
                                      child: Text(data[index].link!, style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: bgColor,
                                          overflow: TextOverflow.ellipsis,

                                          decoration: TextDecoration.underline
                                      ),),
                                    )) : const Text("")),
                              ]
                          ),


                          DataRow(
                              cells: [
                                const DataCell(Text('Reference')),
                                DataCell(data[index].imageFile != null ? InkWell(
                                    onTap: (){
                                      showImageViewer(context, CachedNetworkImageProvider('${Api.basePicUrl}${data[index].imageFile}'),
                                          swipeDismissible: false);
                                    },
                                    child: SizedBox(
                                      width: 180.w,
                                        child: Text(data[index].imageFile!, style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: bgColor,
                                            decoration: TextDecoration.underline,
                                             overflow: TextOverflow.ellipsis,
                                        ),))) : const Text("")),
                              ]
                          ),

                          DataRow(
                              cells: [
                                const DataCell(Text('Deadline')),
                                DataCell(data[index].hasDeadline == true ? Text(DateFormat('MMMM dd').format(DateTime.parse(data[index].deadline!))) : const Text("")),
                              ]
                          ),

                        ],
                      ),

                    ],
                  ),
                );
              }
          );
        },
        error: (e, s) => Center(child: Text(e.toString()),),
        loading: () => const Center(child: CircularProgressIndicator(),)
    );
  }
}
