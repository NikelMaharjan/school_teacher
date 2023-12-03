import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'lesson_sample.dart';

void main() => runApp(const LessonTabs());

class LessonTabs extends StatefulWidget {
  const LessonTabs({super.key});

  @override
  State<LessonTabs> createState() => _LessonTabsState();
}

class _LessonTabsState extends State<LessonTabs> {
  final TextEditingController classController = TextEditingController();
  final TextEditingController subController = TextEditingController();
  ClassLabel? selectedClass;
  SubLabel? selectedSub;

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<ClassLabel>> classEntries =
        <DropdownMenuEntry<ClassLabel>>[];
    for (final ClassLabel grade in ClassLabel.values) {
      classEntries.add(DropdownMenuEntry<ClassLabel>(
          style: ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Colors.black)),
          value: grade,
          label: grade.grade,
          enabled: grade.grade != 'Grey'));
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
                  DropdownMenu<ClassLabel>(
                    controller: classController,
                    menuStyle: MenuStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white),
                    ),
                    width: 350.w,
                    inputDecorationTheme: InputDecorationTheme(
                        enabledBorder: OutlineInputBorder()),
                    initialSelection: ClassLabel.A,
                    textStyle: TextStyle(color: Colors.black),
                    label: const Text(
                      'Class',
                      style: TextStyle(color: Colors.black),
                    ),
                    dropdownMenuEntries: classEntries,
                    onSelected: (ClassLabel? color) {
                      setState(() {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        selectedClass = color;
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
                        FocusScope.of(context).requestFocus(new FocusNode());
                        selectedSub = icon;
                      });
                    },
                  )
                ],
              ),
            ),
            if (selectedClass != null && selectedSub != null)
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Container(
                      // color: Colors.blue,
                      height: MediaQuery.of(context).size.height * 2.5 / 5,
                      child: Lessons()))
            else
              const Text(
                'Please select a class and subject.',
                style: TextStyle(color: Colors.black),
              )
          ],
        ),
      )),
    );
  }
}

enum ClassLabel {
  A('9-A'),
  B('9-B'),
  C('9-C'),
  D('9-D');

  const ClassLabel(this.grade);

  final String grade;
}

enum SubLabel {
  MUSIC('Music'),
  ENG('English'),
  MATH('Math'),
  SCI('Science');

  const SubLabel(this.label);

  final String label;
}
