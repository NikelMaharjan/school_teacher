import 'package:eschool_teacher/features/screens/screen2/result_tabs/result_sample.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() => runApp(const ResultTabs());

class ResultTabs extends StatefulWidget {
  const ResultTabs({super.key});

  @override
  State<ResultTabs> createState() => _ResultTabsState();
}

class _ResultTabsState extends State<ResultTabs> {
  final TextEditingController examController = TextEditingController();
  final TextEditingController subController = TextEditingController();
  ExamLabel? selectedExam;
  SubLabel? selectedSub;

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<ExamLabel>> examEntries =
        <DropdownMenuEntry<ExamLabel>>[];
    for (final ExamLabel exams in ExamLabel.values) {
      examEntries.add(DropdownMenuEntry<ExamLabel>(
          style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Colors.black)),
          value: exams,
          label: exams.exams,
          enabled: exams.exams != 'Grey'));
    }

    final List<DropdownMenuEntry<SubLabel>> subEntries =
        <DropdownMenuEntry<SubLabel>>[];
    for (final SubLabel subj in SubLabel.values) {
      subEntries.add(DropdownMenuEntry<SubLabel>(
          style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Colors.black)),
          value: subj,
          label: subj.label));
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        // color: Colors.red,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DropdownMenu<ExamLabel>(
                    controller: examController,
                    menuStyle: MenuStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                    ),
                    width: 350.w,
                    inputDecorationTheme: InputDecorationTheme(
                        enabledBorder: OutlineInputBorder()),
                    initialSelection: ExamLabel.A,
                    textStyle: TextStyle(color: Colors.black),
                    label: const Text(
                      'Exams',
                      style: TextStyle(color: Colors.black),
                    ),
                    dropdownMenuEntries: examEntries,
                    onSelected: (ExamLabel? examination) {
                      setState(() {
                        selectedExam = examination;
                      });
                    },
                  ),
                  SizedBox(height: 20.h),
                  DropdownMenu<SubLabel>(
                    menuStyle: MenuStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                    ),
                    width: 350.w,
                    inputDecorationTheme: InputDecorationTheme(
                        enabledBorder: OutlineInputBorder()),
                    enableFilter: false,
                    controller: subController,
                    textStyle: TextStyle(color: Colors.black),
                    label: const Text(
                      'Sub',
                      style: TextStyle(color: Colors.black),
                    ),
                    dropdownMenuEntries: subEntries,
                    onSelected: (SubLabel? icon) {
                      setState(() {
                        selectedSub = icon;
                      });
                    },
                  )
                ],
              ),
            ),
            if (selectedExam != null && selectedSub != null)
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Container(
                      // color: Colors.blue,
                      height: MediaQuery.of(context).size.height * 2.5 / 5,
                      child: Result()))
            else
              const Text(
                'Please select an exam and subject.',
                style: TextStyle(color: Colors.black),
              )
          ],
        ),
      )),
    );
  }
}

enum ExamLabel {
  A('Exam I'),
  B('Exam II'),
  C('Exam III'),
  D('Exam IV');

  const ExamLabel(this.exams);

  final String exams;
}

enum SubLabel {
  MUSIC('Music'),
  ENG('English'),
  MATH('Math'),
  SCI('Science');

  const SubLabel(this.label);

  final String label;
}
