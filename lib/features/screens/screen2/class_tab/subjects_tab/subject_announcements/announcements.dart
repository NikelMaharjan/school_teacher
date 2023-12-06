import 'package:eschool_teacher/exceptions/internet_exceptions.dart';
import 'package:eschool_teacher/features/authentication/model/auth_state.dart';
import 'package:eschool_teacher/features/model/notice.dart';
import 'package:eschool_teacher/features/providers/notice_providers.dart';
import 'package:eschool_teacher/features/screens/screen2/class_tab/subjects_tab/subject_announcements/edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../constants/colors.dart';
import '../../../../../../utils/commonWidgets.dart';
import '../../../../../authentication/providers/auth_provider.dart';

import '../../../../../services/notice_services.dart';
import '../../../../../services/school_info_services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SubjectNotices extends ConsumerWidget {
  final int sub_id;
  final String sub_name;
  final int class_sec_id;
  final String token;
  final int teacher_id;
  final int class_sec_sub_id;

  SubjectNotices({required this.sub_id,required this.sub_name,required this.class_sec_id,required this.token,required this.teacher_id,required this.class_sec_sub_id});

  @override
  Widget build(BuildContext context, ref) {
    final auth = ref.watch(authProvider);
    final subNotices = ref.watch(subNoticeList(auth.user.token));
    // print('sub ${sub_id}');
    // print('class ${class_sec_id}');
    // print(class_sec_sub_id);

    return ConnectivityChecker(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: subNotices.when(
          data: (subNotices_data){
          //  print('sub plan ${class_sec_sub_id}');
            final sub_notices = subNotices_data.where((element) => element.subjectName?.id == class_sec_sub_id).toList();
            if(sub_notices.isNotEmpty){
              return ListView.builder (
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: sub_notices.length,
                  itemBuilder: (context, index){



                    return Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 5.h,
                          horizontal: 20.w),
                      child: Slidable(
                        closeOnScroll: true,


                        endActionPane: ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                borderRadius: BorderRadius.circular(10),
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                autoClose: true,
                                flex: 1,
                                backgroundColor: primary,
                                foregroundColor: Colors.white,
                                icon: Icons.edit,
                                onPressed: (context) => Get.to(()=> EditSubNotice(
                                  class_sec_id: class_sec_id,
                                  sub_id: sub_id,
                                  subjectNotice: sub_notices[index],class_sub_id:
                                  sub_notices[index].subjectName!.id,)
                                ),

                              ),
                              SizedBox(width: 5.w,),
                              SlidableAction(
                                  borderRadius: BorderRadius.circular(10),
                                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                                  flex: 1,
                                  autoClose: true,
                                  backgroundColor: abs_color,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  onPressed: (context) =>  showDialog(
                                      context: context,
                                      builder: (context){
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          alignment: Alignment.center,
                                          title: Text('Do you want to delete the notice?',style: TextStyle(color: Colors.black),),
                                          actionsAlignment: MainAxisAlignment.spaceEvenly,
                                          actions: [
                                            TextButton(
                                                style: TextButton.styleFrom(
                                                    backgroundColor: primary
                                                ),
                                                onPressed: () async {
                                                  await ref.read(subNoticeProvider.notifier).deleteData(sub_notices[index].id, auth.user.token).then((value) => ref.refresh(subNoticeList(auth.user.token))).then((value) => Navigator.pop(context));
                                                },
                                                child: Text('Yes',style: TextStyle(color: Colors.white),)
                                            ),
                                            TextButton(
                                                style: TextButton.styleFrom(
                                                    backgroundColor: shimmerBaseColor
                                                ),
                                                onPressed: (){
                                                  Navigator.pop(context);
                                                },
                                                child: Text('No',style: TextStyle(color: Colors.black),)
                                            ),
                                          ],
                                        );
                                      })



                              )
                            ]
                        ),
                        child: NoticeCard(
                            title: sub_notices[index].title,
                            description: sub_notices[index].message,
                            createdAt: '${sub_notices[index].createdAt}'),
                      ),
                    );
                  }
              );

            }
            else{
              return Center(child: Text('No announcement',style: TextStyle(color: Colors.black),),);
            }

          },
          error: (err, stack) => Center(child: Text('$err')),
          loading: () => NoticeShimmer(),
        )
      ),
    );
  }

}


