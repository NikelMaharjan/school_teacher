import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:eschool_teacher/constants/colors.dart';
import 'package:eschool_teacher/features/screens/homepage/information_items/assignment.dart';
import 'package:eschool_teacher/features/screens/homepage/overview.dart';
import 'package:eschool_teacher/features/screens/homepage/settings_teacher.dart';
import 'package:eschool_teacher/features/screens/homepage/teacher_profile.dart';
import 'package:eschool_teacher/features/screens/homepage/time_schedule/timetable.dart';
import 'package:eschool_teacher/time_table.dart';
import 'package:eschool_teacher/utils/commonWidgets.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lottie/lottie.dart';


import '../../../status_page.dart';
import '../../authentication/presentation/loginpage/teacher_login.dart';
import '../../authentication/providers/auth_provider.dart';

import '../../services/info_services.dart';
import '../../services/school_info_services.dart';
import '../../services/teacher_services.dart';

class DefaultTeacher extends ConsumerStatefulWidget {






  @override
  ConsumerState<DefaultTeacher> createState() => _DefaultTeacherState();
}



class _DefaultTeacherState extends ConsumerState<DefaultTeacher>
    with TickerProviderStateMixin {




  int _index = 0;
  double boxX = 0;
  double boxY = 2;

  final List<Widget> _pages = [
     Overview(),
    TimeTable(),

    AssignmentPage(),
    //Teacher(),
    Settings_teacher()
  ];

  @override
  void initState() {
    super.initState();



    // Rebuild the screen after 3s which will process the animation from green to blue
    Future.delayed(Duration(milliseconds: 300)).then((value) => setState(() {
          boxX = 0;
          boxY = 0.9;
        }));

  }






  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final String token = auth.user.token;

    return Scaffold(
        resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          _pages.elementAt(_index),
          AnimatedContainer(
            alignment: Alignment(boxX, boxY),
            curve: Curves.bounceIn,
            duration: Duration(milliseconds: 500),
            child: Card(
              elevation: 5,
              color: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: 350.w,
                  height: 70.h,
                  child: Theme(
                    data:
                        Theme.of(context).copyWith(canvasColor: Colors.white),
                    child: BottomNavigationBar(
                        // backgroundColor: Colors.blue,
                        selectedItemColor: pre_color,
                        unselectedItemColor: Colors.white,
                        showSelectedLabels: true,
                        showUnselectedLabels: false,
                        onTap: (int index) {
                          setState(() {
                            _index = index;
                          });
                        },
                        currentIndex: _index,
                        items: [
                          BottomNavigationBarItem(
                              icon: DecoratedIcon(
                                icon: Icon(
                                  EvaIcons.home,
                                  size: 27.sp,
                                ),
                                decoration: IconDecoration(
                                    border: IconBorder(width: 1.w)),
                              ),
                              label: 'Home'),
                          BottomNavigationBarItem(
                              icon: DecoratedIcon(
                                icon: Icon(
                                  EvaIcons.calendarOutline,
                                  size: 27.sp,
                                ),
                                decoration: IconDecoration(
                                    border: IconBorder(width: 1.w)),
                              ),
                              label: 'Schedule'),

                          BottomNavigationBarItem(
                              icon: DecoratedIcon(
                                icon: Icon(
                                  EvaIcons.activity,
                                  size: 27.sp,
                                ),
                                decoration: IconDecoration(
                                    border: IconBorder(width: 1.w)),
                              ),
                              label: 'Assignments'),


                          // BottomNavigationBarItem(
                          //     icon: DecoratedIcon(
                          //       icon: Icon(
                          //         EvaIcons.person,
                          //         size: 27.sp,
                          //       ),
                          //       decoration: IconDecoration(
                          //           border: IconBorder(width: 1.w)),
                          //     ),
                          //     label: 'Profile'),
                          BottomNavigationBarItem(
                              icon: DecoratedIcon(
                                icon: Icon(
                                  EvaIcons.settings,
                                  size: 27.sp,
                                ),
                                decoration: IconDecoration(
                                    border: IconBorder(width: 1.w)),
                              ),
                              label: 'Menu'),
                        ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      )


    );
  }
}

Future<bool> _onBackPressed(BuildContext context,ref, String token) async {
  return (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Center(
                child: Text(
              'Do you want to logout?',
              style: TextStyle(color: Colors.black),
            )),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              new TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Text("Yes"),
                onPressed: ()async {
                  final auth = ref.watch(authProvider);
                  await ref.read(authProvider.notifier).userLogout(auth.user!.token);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Teacher_login()),
                        (route) => false,
                  );
                },
              ),
              new TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10))),
                child: Text("No"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      )) ??
      false;
}
