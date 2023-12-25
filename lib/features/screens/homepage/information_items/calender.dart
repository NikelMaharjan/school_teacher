
import 'package:eschool_teacher/features/authentication/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../exceptions/internet_exceptions.dart';
import '../../../model/calendar_event.dart';
import '../../../services/calendar_services.dart';


class Calender extends ConsumerStatefulWidget {
  @override
  ConsumerState<Calender> createState() => _CalenderState();
}

class _CalenderState extends ConsumerState<Calender> {
  Map<String, List<CalendarEvent>> mySelectedEvents = {};

  DateTime _focusedDay = DateTime.now();

  DateTime? _selectedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedDate = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    final eventData = ref.watch(eventList(auth.user.token));

    return ConnectivityChecker(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: 200.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(40),
                  ),
                  color: Color(0xff205578)),
            ),
            Center(
              child: Column(

                children: [
                  SizedBox(height: 70.h),
                  Text('School Calendar',
                      style: TextStyle(fontSize: 20.sp, color: Colors.white)),
                  SizedBox(height: 40.h),
                  Container(
                    // color:Colors.red,
                      width: 350.w,
                      height: 380.h,
                      child: Stack(children: [
                        Positioned(
                          top: 5.h,
                          child: Column(
                            children: [
                              Container(
                                // color: Colors.white,
                                child: Center(
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                    child: SizedBox(
                                      width: 340.w,
                                      height: 60.h,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                // color: Colors.white,
                                child: Center(
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)),
                                    child: SizedBox(
                                      width: 340.w,
                                      height: 280.h,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        TableCalendar(
                          daysOfWeekHeight: 20.h,
                          // shouldFillViewport: true,
                          rowHeight: 40.h,
                          // eventLoader: eventDate,
                          onDaySelected: (selectedDay, focusedDay) {
                            if (!isSameDay(_selectedDate, selectedDay)) {
                              // Call `setState()` when updating the selected day
                              setState(() {
                                _selectedDate = selectedDay;
                                _focusedDay = focusedDay;
                              });
                            }
                          },
                          selectedDayPredicate: (day) {
                            return isSameDay(_selectedDate, day);
                          },
                          onPageChanged: (focusedDay) {
                            _focusedDay = focusedDay;
                          },
                          daysOfWeekStyle: DaysOfWeekStyle(
                              weekdayStyle: TextStyle(
                                  color: Colors.blueAccent, fontSize: 15.sp),
                              weekendStyle: TextStyle(
                                  color: Colors.blueAccent, fontSize: 15.sp)),
                          focusedDay: _focusedDay,
                          firstDay: DateTime.utc(2021, 01, 01),
                          lastDay: DateTime.utc(2024, 12, 12),
                          headerStyle: HeaderStyle(
                              formatButtonVisible: false,
                              headerMargin: EdgeInsets.only(
                                  left: 10.w,
                                  right: 10.w,
                                  top: 10.h,
                                  bottom: 20.h),
                              titleCentered: true,
                              titleTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              leftChevronIcon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black,
                              ),
                              rightChevronIcon: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                              )),

                          calendarStyle: CalendarStyle(
                            defaultTextStyle: TextStyle(color: Colors.black),
                            markerSize: 25.sp,
                            markerDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.green.withOpacity(0.7)),
                            markersAutoAligned: false,
                            markersAlignment: Alignment.center,
                            // cellMargin: EdgeInsets.all(10),

                            outsideDaysVisible: false,
                            // tablePadding: EdgeInsets.symmetric(horizontal:10),
                          ),
                        ),
                      ])),

                  SizedBox(height: 10.h),

                  eventData.when(
                      data: (event_data) {
                        final data = event_data.where((element) => DateTime.parse(element.dateEng).isAfter(DateTime.now())).toList();
                        final DateTime now = DateTime.now();
                        final String _formatted =
                        DateFormat('yyyy-MM-dd').format(_selectedDate!);
                        final String _events =
                        DateFormat('yyyy-MM-dd').format(now);
                        final eventWall = event_data.firstWhereOrNull((element) => element.dateEng == _formatted);

                        if (eventWall != null) {
                          final eventDate = DateTime.parse(eventWall.dateEng);
                          String startTime = eventWall.startTime;
                          String endTime = eventWall.endTime;
                          DateTime dt =
                          DateTime.parse(_formatted + "T" + startTime).toLocal();
                          DateTime dt2 =
                          DateTime.parse(_formatted + "T" + endTime).toLocal();
                          String eventStart = DateFormat('HH:mm').format(dt);
                          String eventEnd = DateFormat('HH:mm').format(dt2);

                          print(_selectedDate);


                          return InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(12.0))),
                                      title:   DataTable(
                                        columns:  [

                                          DataColumn(
                                            label: Text(
                                              'Date',
                                              style: TextStyle(),
                                            ),
                                          ),
                                          DataColumn(
                                            label: Text(
                                                eventWall.dateEng
                                            ),
                                          ),

                                        ],
                                        rows: [

                                          DataRow(cells: [
                                            DataCell(Text('Title')),
                                            DataCell(Text(eventWall.title)),
                                          ]),




                                          DataRow(cells: [
                                            DataCell(Text('Location')),
                                            DataCell(Text(eventWall.location)),
                                          ]),

                                          DataRow(cells: [
                                            DataCell(Text('Start Time')),
                                            DataCell(Text(eventWall.startTime)),
                                          ]),


                                          DataRow(cells: [
                                            DataCell(Text('End Time')),
                                            DataCell(Text(eventWall.endTime)),
                                          ]),









                                        ],
                                      ),

                                    );
                                  });
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [


                                Container(
                                  width:200.w,
                                  child: Text(
                                    eventWall.event_type.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  eventWall.description,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.sp),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Text(
                                  '$eventStart \- $eventEnd',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12.sp),
                                ),
                              ],
                            ),
                          );



                          return Container(
                            height: MediaQuery.of(context).size.height * 1.1 / 3,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                      height: 130.h,
                                      width: double.infinity,
                                      decoration: BoxDecoration(border:
                                      Border.all(color: Colors.blueGrey)),
                                      child: Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                DateFormat('MMMM yyyy').format(eventDate),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                DateFormat('E').format(eventDate),
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 25.sp,
                                                    fontWeight: FontWeight.bold),
                                              )
                                            ],
                                          ),
                                          VerticalDivider(
                                            width: 20.w,
                                            thickness: 2.w,
                                            color: Colors.grey,
                                            indent: 15.h,
                                            endIndent: 15.h,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              print('tapped');
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      backgroundColor:
                                                      Colors.white,
                                                      title: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              Flexible(
                                                                child: Text(
                                                                  eventWall.title,
                                                                  overflow: TextOverflow.visible,
                                                                  style: TextStyle(
                                                                      color: Colors.black,
                                                                      fontSize:
                                                                      20.sp,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                                ),
                                                              ),
                                                              Text(
                                                                '${DateFormat('yy-MM-dd').format(eventDate)}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                    12.sp),
                                                              ),

                                                            ],
                                                          ),
                                                          Divider(
                                                            height: 15.h,
                                                            color:
                                                            Colors.black,
                                                          ),
                                                          Text(
                                                            'Detail: ${eventWall.description}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                15.sp),
                                                          ),

                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Text(
                                                            'Location: ${eventWall.location}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                12.sp),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width:200.w,
                                                  child: Text(
                                                    eventWall.title,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20.sp,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                                Text(
                                                  eventWall.description,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15.sp),
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Text(
                                                  '$eventStart \- $eventEnd',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12.sp),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Container(
                                    width: 360.w,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black)),
                                    child: Column(
                                      children: [
                                        Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15.w,
                                                  vertical: 8.h),
                                              child: Text(
                                                'Upcoming Events',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20.sp,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            )),
                                        ListView.builder(
                                            padding: EdgeInsets.zero,
                                            physics: BouncingScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: data.length,
                                            itemBuilder: (context, index) {
                                              DateTime dt = DateTime.parse(
                                                  data[index].dateEng);
                                              var eventDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(dt);

                                              return ListTile(
                                                contentPadding: EdgeInsets.zero,
                                                onTap: () {
                                                  print('tapped');
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          backgroundColor:
                                                          Colors.white,
                                                          title: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    data[index]
                                                                        .title,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                        20.sp,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                  ),
                                                                  Text(
                                                                    eventDate
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                        12.sp),
                                                                  ),
                                                                ],
                                                              ),
                                                              Divider(
                                                                height: 15.h,
                                                                color:
                                                                Colors.black,
                                                              ),
                                                              Text(
                                                                'Detail: ${data[index].description}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                    15.sp),
                                                              ),
                                                              SizedBox(
                                                                height: 5.h,
                                                              ),
                                                              Text(
                                                                'Location: ${data[index].location}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                    12.sp),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                },
                                                title: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Divider(
                                                      color: Colors.black,
                                                    ),
                                                    Padding(
                                                      padding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 12.w),
                                                      child: Text(
                                                        '${1 + index}\. ${data[index].title}',
                                                        style: TextStyle(
                                                            color: Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                subtitle: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 24.w),
                                                  child: Text(
                                                    '${eventDate.toString()}',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12.sp),
                                                  ),
                                                ),
                                              );
                                            }),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50.h,
                                  )
                                ],
                              ),
                            ),
                          );
                        } else {



                          return Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Row(
                                  //   children: [
                                  //     Text(
                                  //       DateFormat('MMMM yyyy').format(_selectedDate!), style: TextStyle(
                                  //         fontWeight: FontWeight.bold,
                                  //        fontSize: 18
                                  //     ),),
                                  //
                                  //     SizedBox(width: 8,),
                                  //     Text(
                                  //       DateFormat('E').format(_selectedDate!), style: TextStyle(
                                  //         fontWeight: FontWeight.bold,
                                  //         fontSize: 18
                                  //     ),
                                  //     ),
                                  //
                                  //
                                  //
                                  //   ],
                                  // ),




                                  SizedBox(height: 10,),
                                  Text("No Event Today", style: TextStyle(fontSize: 20, letterSpacing: 2),),

                                  SizedBox(height: 30,),


                                  Container(
                                    width: 360.w,

                                    child: Column(
                                      children: [
                                        ListView.builder(
                                            padding: EdgeInsets.zero,
                                            physics: BouncingScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: data.length,
                                            itemBuilder: (context, index) {
                                              DateTime dt = DateTime.parse(data[index].dateEng);
                                              var eventDate = DateFormat('yyyy-MM-dd').format(dt);

                                              return Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,

                                                children: [

                                                  Text("Upcoming Events", style: TextStyle(fontSize: 20, letterSpacing: 2),),

                                                  ListTile(

                                                    title: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(data[index].event_type.name, style: TextStyle(fontWeight: FontWeight.bold),),
                                                        Text(eventDate, style: TextStyle(fontSize: 14),)
                                                      ],
                                                    ),
                                                    subtitle: Text(data[index].description),

                                                  ),
                                                ],
                                              );



                                            }),
                                      ],
                                    ),
                                  ),






                                ],
                              )
                          );
                        }
                      },
                      error: (err, stack) => Center(child: Text('$err')),
                      loading: () => Center(child: CircularProgressIndicator())),

                  // InkWell(
                  //   onTap: () async {
                  //     _showDialogEvent();
                  //   },
                  //   child: Container(
                  //     width: 50.w,
                  //     height: 50.h,
                  //     child: Center(
                  //       child: Card(
                  //           elevation: 10,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(100.sp),
                  //           ),
                  //           child: Center(
                  //               child: Icon(Icons.add,color: Colors.black,)
                  //           )
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
            Positioned(
              left: 15.w,
              top: 40.h,
              child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 25.sp)),
            ),
          ],
        ),
      ),
    );
  }
}