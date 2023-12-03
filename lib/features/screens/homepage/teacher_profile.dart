import 'package:eschool_teacher/api.dart';
import 'package:eschool_teacher/utils/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../constants/colors.dart';
import '../../../exceptions/internet_exceptions.dart';
import '../../authentication/providers/auth_provider.dart';
import '../../services/info_services.dart';

class  Teacher extends ConsumerStatefulWidget {
  @override
  ConsumerState<Teacher> createState() => _TeacherState();
}

class _TeacherState extends ConsumerState<Teacher> {


  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _makeEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(launchUri);
  }


  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final _infoData = ref.watch(employeeList(auth.user.token));



    return ConnectivityChecker(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: _infoData.when(
            data: (data) {
              final userWall = data.firstWhere(
                  (element) => element.email == auth.user.userInfo.email);

              // print(userWall.picture);
              return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(children: [
                    Container(
                      // color: Colors.blue,
                      height: MediaQuery.of(context).size.height * 1.9 / 5,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 170.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(40),
                                ),
                                color: Color(0xff205578)),
                          ),
                          Container(
                            // color: Colors.blueGrey,
                            height: MediaQuery.of(context).size.height * 1.9 / 5,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 50.h,
                                ),
                                Text('Profile',
                                    style: TextStyle(
                                        fontSize: 20.sp, color: Colors.white)),
                                SizedBox(
                                  height: 45.h,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 55.sp,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            '${Api.basePicUrl}${userWall.employee_photo}'),
                                        radius: 50.sp,
                                      )),
                                ),
                                Text(
                                  '${userWall.name}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 30.sp),
                                ),
                                Divider(
                                  thickness: 1.h,
                                  height: 20.h,
                                  color: Colors.grey,
                                  indent: 15.w,
                                  endIndent: 15.w,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      // color: Colors.red,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Personal Details',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15.sp),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            IconTextRow(
                                onTap: (){
                                  _makeEmail(userWall.email);
                                },
                                title: 'Email',
                                icon:  Icons.person,
                                text: userWall.email
                            ),

                            SizedBox(
                                height: 30.h
                            ),
                            IconTextRow(
                                onTap: (){
                                  _makePhoneCall(userWall.mobile_no);
                                },
                                title: 'Phone Number',
                                icon:  Icons.phone,
                                text: userWall.mobile_no
                            ),

                            SizedBox(
                              height: 30.h,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 50.h,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: primary,
                                  ),
                                  child: userWall.gender == ['male', 'Male','MALE']
                                      ? Icon(
                                          Icons.male_rounded,
                                          size: 35.sp,
                                        )
                                      : Icon(
                                          Icons.female_rounded,
                                          size: 35.sp,
                                        ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Gender',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15.sp),
                                    ),
                                    Text(
                                      userWall.gender,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15.sp),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 50.h,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: primary,
                                  ),
                                  child: Icon(
                                    Icons.expand_circle_down_outlined,
                                    size: 35.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Experience',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15.sp),
                                    ),
                                    Text(
                                      userWall.experience,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15.sp),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 50.h,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: primary,
                                  ),
                                  child: Icon(
                                    Icons.school,
                                    size: 35.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Qualification',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15.sp),
                                    ),
                                    Text(
                                      userWall.education,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15.sp),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 50.h,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: primary,
                                  ),
                                  child: Icon(
                                    Icons.person_pin_circle_outlined,
                                    size: 35.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Current Address',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15.sp),
                                    ),
                                    Text(
                                      userWall.current_address,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15.sp),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 50.h,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: primary,
                                  ),
                                  child: Icon(
                                    Icons.pin_drop,
                                    size: 35.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Permanent Address',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15.sp),
                                    ),
                                    Text(
                                      userWall.permanent_address,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15.sp),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 120.h,
                            ),
                          ],
                        ),
                      ),
                    )
                  ]));
            },
            error: (err, stack) => Center(child: Text('$err')),
            loading: () => Center(child: CircularProgressIndicator()),
          )),
    );
  }
}
