import 'package:eschool_teacher/utils/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constants/colors.dart';
import '../../../api.dart';
import '../../../exceptions/internet_exceptions.dart';
import '../../authentication/providers/auth_provider.dart';
import '../../services/notice_services.dart';





class NoticeBoard extends ConsumerWidget {
  const NoticeBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final auth = ref.watch(authProvider);
    final noticeData = ref.watch(noticeList(auth.user.token));
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
                        final allNotice = data
                            .where((element) => element.forAllClass == true)
                            .toList();
                        return ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: allNotice.length,
                            itemBuilder: (context, index) {
                            print('${Api.basePicUrl}${allNotice[index].image}');
                              return NoticeCard3(
                                  title: allNotice[index].title,
                                  description: allNotice[index].description,
                                  createdAt: allNotice[index].createdAt,
                                  image: allNotice[index].image != null ?'${Api.basePicUrl}${allNotice[index].image}' : null,
                              );
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
                  onPressed: ()  {
                    ref.refresh(noticeList(auth.user.token));
                  },
                  icon: Icon(Icons.refresh, color: Colors.white, size: 25.sp)),
            ),
          ],
        ),
      ),
    );
  }
}
