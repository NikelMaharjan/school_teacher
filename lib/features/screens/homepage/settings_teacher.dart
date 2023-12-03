import 'package:eschool_teacher/constants/colors.dart';
import 'package:eschool_teacher/exceptions/internet_exceptions.dart';
import 'package:eschool_teacher/features/authentication/presentation/loginpage/teacher_login.dart';
import 'package:eschool_teacher/features/screens/homepage/settings_items/about_us.dart';
import 'package:eschool_teacher/features/screens/homepage/settings_items/contact_us.dart';
import 'package:eschool_teacher/status_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../authentication/providers/auth_provider.dart';

class Settings_teacher extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final auth = ref.watch(authProvider);

    return ConnectivityChecker(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: bgColor,
          title: Text("Settings", style: TextStyle(color: Colors.white),),
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(


                  children: [

                    Container(
                      width: 350.w,
                      height: 320.h,
                      child: ListView(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        children: [
                          ListTile(
                            visualDensity: VisualDensity(vertical: -3),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Change Password',
                                    style: TextStyle(color: Colors.black)),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 15.sp,
                                )
                              ],
                            ),
                          ),
                          ListTile(
                            visualDensity: VisualDensity(vertical: -4),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Privacy Policy',
                                    style: TextStyle(color: Colors.black)),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 15.sp,
                                )
                              ],
                            ),
                          ),
                          ListTile(
                            visualDensity: VisualDensity(vertical: -3),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Terms & Condition',
                                    style: TextStyle(color: Colors.black)),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 15.sp,
                                )
                              ],
                            ),
                          ),
                          ListTile(
                            onTap: ()=>Get.to(()=>AboutUs()),
                            visualDensity: VisualDensity(vertical: -3),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('About Us',
                                    style: TextStyle(color: Colors.black)),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 15.sp,
                                )
                              ],
                            ),
                          ),
                          ListTile(
                            onTap: ()=> Get.to(()=>ContactUs()),
                            visualDensity: VisualDensity(vertical: -3),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Contact Us',
                                    style: TextStyle(color: Colors.black)),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 15.sp,
                                )
                              ],
                            ),
                          ),
                          ListTile(
                            visualDensity: VisualDensity(vertical: -3),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Rate Us',
                                    style: TextStyle(color: Colors.black)),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 15.sp,
                                )
                              ],
                            ),
                          ),
                          ListTile(
                            visualDensity: VisualDensity(vertical: -3),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Share',
                                    style: TextStyle(color: Colors.black)),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                  size: 15.sp,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () async {
                          await ref.read(authProvider.notifier).userLogout(auth.user!.token);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Teacher_login()),
                                (route) => false,
                          );


                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.logout,
                                size: 15.sp,
                              ),
                              SizedBox(
                                width: 5.h,
                              ),
                              Text('Log Out'),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
