import 'package:eschool_teacher/features/authentication/providers/auth_provider.dart';
import 'package:eschool_teacher/features/model/exam_model.dart';
import 'package:eschool_teacher/features/screens/screen2/exam_tabs/exam_classes.dart';
import 'package:eschool_teacher/utils/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../services/exam_services.dart';

class TestExam extends ConsumerWidget {
  final String tabType;
  const TestExam({Key? key, required this.tabType}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final auth = ref.watch(authProvider);
    final exams = ref.watch(examList(auth.user.token));
    return exams.when(
      data: (data) {
        List<ExamDetail> filteredExams;
        if (tabType == 'Upcoming') {
          filteredExams = data
              .where((exam) => DateTime.parse(exam.examStartDate).isAfter(DateTime.now()))
              .toList();
        } else if (tabType == 'Ongoing') {
          filteredExams = data
              .where((exam) =>
          DateTime.parse(exam.examStartDate).isBefore(DateTime.now()) &&
              DateTime.parse(exam.examEndDate).isAfter(DateTime.now()))
              .toList();
        } else if (tabType == 'Completed') {
          filteredExams = data
              .where((exam) => DateTime.parse(exam.examEndDate).isBefore(DateTime.now()))
              .toList();
        } else{
          filteredExams = data.toList();
        }

        return ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: filteredExams.length,
            itemBuilder: (context, index) {
              return ExamCard(
                  onTap: () => Get.to(() =>
                      ExamClasses(examDetail: filteredExams[index])),
                  title: filteredExams[index].name,
                  date:
                  '${filteredExams[index].examStartDate} to ${filteredExams[index].examEndDate}');
            });
      },
      error: (err, stack) => Center(child: Text('$err')),
      loading: () => ShimmerListTile(),
    );
  }
}

