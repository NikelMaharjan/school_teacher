import 'package:eschool_teacher/features/authentication/providers/auth_provider.dart';

import 'package:eschool_teacher/features/services/info_services.dart';
import 'package:eschool_teacher/features/services/notice_services.dart';
import 'package:eschool_teacher/features/services/student_services.dart';
import 'package:eschool_teacher/features/services/teacher_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../utils/connectivity.dart';

class ConnectivityChecker extends ConsumerWidget {
  final Widget child;
  ConnectivityChecker({required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final connectivityStatus = ref.watch(connectionProvider);
    final auth = ref.watch(authProvider);
    final String token = auth.user.token;

    if (connectivityStatus == ConnectivityStatus.OFF) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              content: Container(
                height: 290,
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/jsons/no_internet.json',
                      fit: BoxFit.contain,
                    ),
                    Text(
                      'No internet connection',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                TextButton(
                  onPressed: () async {
                    ref.refresh(authProvider);
                    ref.refresh(employeeList(token));
                    ref.refresh(noticeList(token));
                    ref.refresh(studentList(token));

                    Navigator.pop(context);

                  },
                  child: Text('Try Again'),
                ),
              ],
            );
          },
        );
      });
    }

    return child;
  }
}