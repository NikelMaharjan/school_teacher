import 'package:eschool_teacher/features/driver/driver_overview.dart';
import 'package:eschool_teacher/features/services/user_info_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'features/authentication/presentation/loginpage/teacher_login.dart';
import 'features/authentication/providers/auth_provider.dart';
import 'features/screens/homepage/default_teacher.dart';

class StatusPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final auth = ref.watch(authProvider);
    // print('token : ${auth.user.token}');
    // print('userInfo : ${auth.user.userInfo.userType}');

    if(auth.user.token.isNotEmpty){
      if(auth.user.userInfo.userType == 'Teacher'){
        return DefaultTeacher();
      }
      else if(auth.user.userInfo.userType == 'Driver'){
        return DriverPage();
      }
      else{
        return Teacher_login();
      }
    }

   else{
     return Teacher_login();
    }
  }
}

