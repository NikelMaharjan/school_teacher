import 'package:eschool_teacher/features/authentication/providers/auth_provider.dart';
import 'package:eschool_teacher/features/services/feature_services.dart';
import 'package:eschool_teacher/utils/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../model/teacher_features.dart';

class Routine extends ConsumerWidget {

  final String day;
  Routine({required this.day});

  @override
  Widget build(BuildContext context,ref) {

    final auth = ref.watch(authProvider);
    final routine = ref.watch(teacherRoutineProvider(day));

    return routine.when(
        data: (data){
          final routineInfo = data.where((element) => element.classRoutine.isNotEmpty).toList();
          return  routineInfo.isEmpty ? Center(child: Text("No Routine at the moment"),) : ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: routineInfo.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              // Sort the class routine by start time
              List<ClassRoutine> sortedRoutine =
              List.from(routineInfo[index].classRoutine);
              sortedRoutine.sort((a, b) => DateFormat('HH:mm').parse(a.startTime).compareTo(DateFormat('HH:mm').parse(b.startTime)));

              // Define the date format to show only the hour and minute
              final timeFormat = DateFormat('hh:mm');

              return CommonCard(
                time:
                "${sortedRoutine.map((e) => '${timeFormat.format(DateFormat('HH:mm').parse(e.startTime))}-${timeFormat.format(DateFormat('HH:mm').parse(e.endTime))}').join(', ')}",
                className:
                "${routineInfo[index].classSection.className.classLevel.name}-${routineInfo[index].classSection.section.sectionName}",
                subjectName:
                "${sortedRoutine.map((e) => e.classSubject.subject.subjectName).join(', ')}",
              );
            },
          );







        },
      error: (err, stack) => Center(child: Text('$err')),
      loading: () => NoticeShimmer(),
    );
  }
}
