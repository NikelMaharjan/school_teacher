
import 'package:eschool_teacher/exceptions/internet_exceptions.dart';
import 'package:eschool_teacher/utils/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../constants/colors.dart';
import '../../../../authentication/providers/auth_provider.dart';
import '../../../../providers/notice_providers.dart';
import '../../../../services/notice_services.dart';
import 'add_class_notice.dart';
import 'edit_class_notice.dart';

class ClassNoticeBoard extends ConsumerWidget {
  final int class_sec_id;

  final int teacher_id;

  ClassNoticeBoard({required this.class_sec_id,required this.teacher_id});

  @override
  Widget build(BuildContext context, ref) {
    final auth = ref.watch(authProvider);
    final classNotice = ref.watch(classNoticeList(auth.user.token));
    final noticeInfo = ref.watch(noticeList(auth.user.token));
    final noticeData = ref.watch(classNoticeProvider2(class_sec_id));
    print(class_sec_id);

    return ConnectivityChecker(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.8 / 5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(40),
                        ),
                        color: Color(0xff205578)),
                    child: Center(
                      child: Text('Notice Board',
                          style: TextStyle(fontSize: 20.sp, color: Colors.white)),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 4 / 5,
                    // color: Colors.red,
                    child: noticeData.when(
                      data: (data) {
                        final allNotice = data.where((element) => element.notice.forAllClass == false).toList();

                        return ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 15.w),
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: allNotice.length,
                            itemBuilder: (context, index) {
                              return NoticeCard(
                                  title: allNotice[index].notice.title,
                                  description: allNotice[index].notice.description,
                                  createdAt: allNotice[index].createdAt);
                            });
                      },
                      error: (err, stack) => Center(child: Text('$err')),
                      loading: () => NoticeShimmer(),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              left: 15.w,
              top: 40.h,
              child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 25.sp)),
            ),
            Positioned(
              right: 15.w,
              top: 40.h,
              child: IconButton(
                  onPressed: () async {
                    ref.refresh(classNoticeList(auth.user.token));
                  },
                  icon: Icon(Icons.refresh, color: Colors.white, size: 25.sp)),
            ),
          ],
        ),

        floatingActionButton:
        FloatingActionButton(
            onPressed: (){
              Get.to(()=>AddNotice(teacher_id: teacher_id, class_sec_id: class_sec_id));
            },
          backgroundColor: primary,
          child: Icon(Icons.add,color: Colors.white,),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
