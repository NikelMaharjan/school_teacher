//for courses in the overview page ....
//
// Padding(
// padding:
// EdgeInsets.symmetric(horizontal: 30.w, vertical: 8.h),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// Text('My Courses',
// style: TextStyle(
// fontSize: 20.sp,
// fontWeight: FontWeight.bold,
// color: Colors.black)),
// TextButton(
// onPressed: (){
// Get.to(()=>AllCourses());
// },
// child: Text('View all >',style: TextStyle(color: Colors.grey),)
// )
// ],
// ),
// ),
// Container(
// // color: Colors.blue,
// height: MediaQuery.of(context).size.height * 0.5 / 4,
// padding: EdgeInsets.only(left: 30.w),
//
// child: infoData.when(
// data: (info_data){
// final infoData= info_data.firstWhere((element) => element.email==auth.user.userInfo.email);
// return teacherCourse.when(
// data: (class_data){
//
// return GridView.builder(
// padding: EdgeInsets.zero,
// physics: NeverScrollableScrollPhysics(),
// shrinkWrap: true,
// gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 2.w / 1.3.h, crossAxisCount: 2, mainAxisSpacing: 5.h, crossAxisSpacing: 3.w),
// itemCount: 2,
// itemBuilder: (context,index){
// return Stack(
// children: [
// GridTile(
// child: ClipRRect(
// borderRadius: BorderRadius.circular(10),
// child: InkWell(
// onTap: () => Get.to(() => CoursePage(class_sec_id: class_data[index].classLevel.id, token: '$token', sec_name: class_data[index].classLevel.sectionName, class_level_name: class_data[index].classLevel.className.classLevel.className, teacher_id: infoData.id,)),
// child: Container(
// height: 80.h,
// width: 150.w,
// color: primary,
// child: Center(
// child: Text(
// '${class_data[index].classLevel.className.classLevel.className} - ${class_data[index].classLevel.sectionName}',
// style: TextStyle(color: Colors.white, fontSize: 15.sp),
// ))),
// ),
// ),
// ),
// Align(
// alignment: Alignment(-0.20, 0.55),
// child: Card(
// elevation: 3,
// color: Colors.white,
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(100),
// ),
// child: Padding(
// padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
// child: Icon(
// Icons.arrow_forward_ios,
// color: Colors.black,
// size: 20.sp,
// ),
// ),
// ),
// )
// ],
// );
// }
// );
//
//
// },
// error: (err, stack) => Center(child: Text('$err')),
// loading: () =>  GridShimmer(),
//
// );
// },
// error: (err, stack) => Center(child: Text('$err')),
// loading: () =>  GridShimmer(),
// )
// ),