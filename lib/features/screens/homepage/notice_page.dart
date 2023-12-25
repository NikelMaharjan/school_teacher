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
        appBar: AppBar(
          backgroundColor: bgColor,
          title: Text("School Notice", style: TextStyle(color: Colors.white),),
        ),
        backgroundColor: Colors.white,
        body: noticeData.when(
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
        )
      ),
    );
  }
}
