import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../constants/colors.dart';
import 'exam_tab.dart';

class ExamTabs extends StatefulWidget {
  const ExamTabs({Key? key}) : super(key: key);

  @override
  State<ExamTabs> createState() => _ExamTabsState();
}

class _ExamTabsState extends State<ExamTabs> with TickerProviderStateMixin {
  var _scrollViewController;
  var _tabController;

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController();
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(

      floatHeaderSlivers: false,
      controller: _scrollViewController,
      headerSliverBuilder: (context, bool) => [
        SliverAppBar(
          automaticallyImplyLeading: false,

          backgroundColor: Colors.white,
          // pinned: true,
          primary: false,
          centerTitle: false,
          titleSpacing: 0.w,

          title: TabBar(
              padding: EdgeInsets.only(top: 10.h),
              labelStyle: TextStyle(fontSize: 15.sp),
              controller: _tabController,
              isScrollable: true,
              labelPadding: EdgeInsets.only(left: 20.w, right: 20.w),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              // indicatorColor: primary,
              indicator: BoxDecoration(
                  color: primary, borderRadius: BorderRadius.circular(10)),
              tabs: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Tab(
                    text: 'All Exams',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Tab(text: 'Upcoming'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Tab(text: 'Ongoing'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Tab(text: 'Completed'),
                ),
              ]),
        ),
      ],
      body: TabBarView(
        controller: _tabController,
        children: const [
          TestExam(tabType: '',),
          TestExam(tabType: 'Upcoming',),
          TestExam(tabType: 'Ongoing',),
          TestExam(tabType: 'Completed',),

        ],
      ),
    );
  }
}
