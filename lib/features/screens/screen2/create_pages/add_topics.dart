import 'package:dotted_border/dotted_border.dart';
import 'package:eschool_teacher/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Add_Topics extends StatefulWidget {
  const Add_Topics({super.key});

  @override
  State<Add_Topics> createState() => _Add_TopicsState();
}

class _Add_TopicsState extends State<Add_Topics> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  final TextEditingController classController = TextEditingController();
  final TextEditingController subController = TextEditingController();
  final TextEditingController chapController = TextEditingController();
  ClassLabel? selectedClass;
  SubLabel? selectedSub;
  ChapLabel? selectedChap;
  bool isSwitched = false;

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuEntry<ClassLabel>> classEntries =
        <DropdownMenuEntry<ClassLabel>>[];
    for (final ClassLabel grade in ClassLabel.values) {
      classEntries.add(DropdownMenuEntry<ClassLabel>(
          style: const ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Colors.black)),
          value: grade,
          label: grade.grade));
    }

    final List<DropdownMenuEntry<SubLabel>> subEntries =
        <DropdownMenuEntry<SubLabel>>[];
    for (final SubLabel subj in SubLabel.values) {
      subEntries.add(DropdownMenuEntry<SubLabel>(
          style: const ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Colors.black)),
          value: subj,
          label: subj.label));
    }

    final List<DropdownMenuEntry<ChapLabel>> chapEntries =
        <DropdownMenuEntry<ChapLabel>>[];
    for (final ChapLabel chap in ChapLabel.values) {
      chapEntries.add(DropdownMenuEntry<ChapLabel>(
          style: const ButtonStyle(
              foregroundColor: MaterialStatePropertyAll(Colors.black)),
          value: chap,
          label: chap.label));
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
              // color: Colors.red,
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height * 0.6 / 5,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: bgColor,
                          borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(25))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 100.w,
                              ),
                            ],
                          ),
                          Text('Add Topics',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.sp)),
                        ],
                      )),
                  Container(
                    height: MediaQuery.of(context).size.height * 4.1 / 5,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                DropdownMenu<ClassLabel>(
                                  hintText: 'Class',

                                  controller: classController,

                                  menuStyle: const MenuStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.white),
                                  ),
                                  width: 350.w,

                                  inputDecorationTheme: InputDecorationTheme(
                                      hintStyle: const TextStyle(color: Colors.black),
                                      filled: true,
                                      fillColor: shimmerHighlightColor,
                                      enabledBorder: const OutlineInputBorder(),
                                      focusedBorder: InputBorder.none),

                                  textStyle: const TextStyle(color: Colors.black),

                                  // label: Text('Class',style: TextStyle(color: Colors.black),),
                                  dropdownMenuEntries: classEntries,
                                  onSelected: (ClassLabel? color) {
                                    setState(() {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      selectedClass = color;
                                    });
                                  },
                                ),
                                SizedBox(height: 20.h),
                                DropdownMenu<SubLabel>(
                                  hintText: 'Subject',

                                  menuStyle: const MenuStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.white),
                                  ),

                                  width: 350.w,
                                  inputDecorationTheme: InputDecorationTheme(
                                      hintStyle: const TextStyle(color: Colors.black),
                                      filled: true,
                                      fillColor: shimmerHighlightColor,
                                      enabledBorder: const OutlineInputBorder(),
                                      focusedBorder: InputBorder.none),

                                  controller: subController,
                                  textStyle: const TextStyle(color: Colors.black),

                                  // label: const Text('Sub',style: TextStyle(color: Colors.black),),
                                  dropdownMenuEntries: subEntries,
                                  onSelected: (SubLabel? icon) {
                                    setState(() {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      selectedSub = icon;
                                    });
                                  },
                                ),
                                SizedBox(height: 20.h),
                                DropdownMenu<ChapLabel>(
                                  hintText: 'Lesson',

                                  menuStyle: const MenuStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.white),
                                  ),

                                  width: 350.w,
                                  inputDecorationTheme: InputDecorationTheme(
                                      hintStyle: const TextStyle(color: Colors.black),
                                      filled: true,
                                      fillColor: shimmerHighlightColor,
                                      enabledBorder: const OutlineInputBorder(),
                                      focusedBorder: InputBorder.none),

                                  controller: chapController,
                                  textStyle: const TextStyle(color: Colors.black),

                                  // label: const Text('Sub',style: TextStyle(color: Colors.black),),
                                  dropdownMenuEntries: chapEntries,
                                  onSelected: (ChapLabel? chapter) {
                                    setState(() {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      selectedChap = chapter;
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: shimmerHighlightColor,
                                  border: Border.all(color: Colors.black)),
                              child: TextFormField(
                                controller: nameController,
                                onFieldSubmitted: null,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15.sp),
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    hintText: 'Topic Title',
                                    hintStyle: TextStyle(
                                        color: Colors.black, fontSize: 15.sp),
                                    contentPadding: EdgeInsets.only(
                                        left: 8.w, bottom: 8.h)),
                              )),
                          SizedBox(
                            height: 15.h,
                          ),
                          Container(
                              height: MediaQuery.of(context).size.height * 0.15,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: shimmerHighlightColor,
                                  border: Border.all(color: Colors.black)),
                              child: TextFormField(
                                maxLines: 6,
                                controller: descController,
                                onFieldSubmitted: null,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15.sp),
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    hintText: 'Topic Description',
                                    hintStyle: TextStyle(
                                        color: Colors.black, fontSize: 15.sp),
                                    contentPadding: EdgeInsets.only(
                                        top: 8.h,
                                        left: 8.w,
                                        bottom: 8.h,
                                        right: 8.w)),
                              )),
                          SizedBox(
                            height: 15.h,
                          ),
                          DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            dashPattern: const [5, 5],
                            color: primary,
                            strokeWidth: 1,
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 20.sp,
                                      backgroundColor: primary,
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Text(
                                      'Study Materials',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15.sp),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 8.w),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: primary,
                                  foregroundColor: Colors.white,
                                  fixedSize: Size.fromWidth(250.w),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                        color: Colors.black,
                                      ))),
                              onPressed: () {},
                              child: Text(
                                'Add Topic',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ))),
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

enum ChapLabel {
  I('Lesson I'),
  II('Lesson II'),
  III('Lesson III'),
  IV('Lesson IV');

  const ChapLabel(this.label);

  final String label;
}
