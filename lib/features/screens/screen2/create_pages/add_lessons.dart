import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../constants/colors.dart';

class AddLessons extends StatefulWidget {
  const AddLessons({Key? key}) : super(key: key);

  @override
  State<AddLessons> createState() => _AddLessonsState();
}

class _AddLessonsState extends State<AddLessons> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.9 / 5,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(25))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
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
                  Text('Add lessons',
                      style: TextStyle(color: Colors.white, fontSize: 18.sp)),
                ],
              )),
          SizedBox(
            height: 15.h,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: shimmerBaseColor,
                border: Border.all(color: Colors.grey)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
              child: const Text(
                'Class',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: shimmerBaseColor,
                border: Border.all(color: Colors.grey)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
              child: const Text(
                'Subject',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: shimmerBaseColor,
                  border: Border.all(color: Colors.grey)),
              child: TextFormField(
                controller: nameController,
                onFieldSubmitted: null,
                style: TextStyle(color: Colors.black, fontSize: 15.sp),
                decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: 'Lesson Name',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15.sp),
                    contentPadding: EdgeInsets.only(left: 8.w, bottom: 8.h)),
              )),
          SizedBox(
            height: 15.h,
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: shimmerBaseColor,
                  border: Border.all(color: Colors.grey)),
              child: TextFormField(
                maxLines: 6,
                controller: descController,
                onFieldSubmitted: null,
                style: TextStyle(color: Colors.black, fontSize: 15.sp),
                decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: 'Lesson Description',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 15.sp),
                    contentPadding: EdgeInsets.only(
                        top: 8.h, left: 8.w, bottom: 8.h, right: 8.w)),
              )),
          SizedBox(
            height: 15.h,
          ),
          DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(10),
            dashPattern: [5, 5],
            color: primary,
            strokeWidth: 1,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
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
                    style: TextStyle(color: Colors.black, fontSize: 15.sp),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
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
              onPressed: () {

              },
              child: Text(
                'Add lesson',
                style: TextStyle(
                  fontSize: 20.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
