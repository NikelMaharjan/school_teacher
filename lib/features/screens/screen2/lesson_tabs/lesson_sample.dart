import 'package:eschool_teacher/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Lessons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350.w,
      height: 100.h,
      child: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Card(
              elevation: 8,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                // onTap: ()=>Get.to(()=>AssignmentPage()),
                title: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Lesson name',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 12.sp)),
                          Row(
                            children: [
                              Icon(
                                Icons.edit,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Icon(
                                Icons.delete,
                                color: abs_color,
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text('Lesson 1',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 30.h,
                      ),
                      Text('Lesson description',
                          style:
                              TextStyle(color: Colors.black, fontSize: 12.sp)),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text('Basic Lessons',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
