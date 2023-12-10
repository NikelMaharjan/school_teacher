import 'package:dio/dio.dart';
import 'package:eschool_teacher/constants/colors.dart';
import 'package:eschool_teacher/constants/snack_show.dart';
import 'package:eschool_teacher/features/authentication/providers/auth_provider.dart';
import 'package:eschool_teacher/features/providers/notice_providers.dart';
import 'package:eschool_teacher/features/screens/screen2/class_tab/class_notice/class_notice.dart';
import 'package:eschool_teacher/utils/commonWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../api.dart';

import '../../../../services/notice_services.dart';
import '../../../../services/school_info_services.dart';

class AddNotice extends ConsumerStatefulWidget {

  final int teacher_id;

  final int class_sec_id;

  AddNotice({required this.teacher_id, required this.class_sec_id, });

  @override
  ConsumerState<AddNotice> createState() => _AddNoticeState(teacher_id: teacher_id, class_sec_id: class_sec_id,);
}

class _AddNoticeState extends ConsumerState<AddNotice> {

  final int teacher_id;

  final int class_sec_id;


  bool isTrue = true;

  _AddNoticeState({required this.teacher_id, required this.class_sec_id,});
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
    final _formKey = GlobalKey<FormState>();
    final _titleController = TextEditingController();
    final _descriptionController = TextEditingController();
    String _error = '';
    final auth = ref.watch(authProvider);
    final noticeLoad = ref.watch(noticeList(auth.user.token));


    ref.listen(classNoticeProvider, (previous, next) {
      if(next.errorMessage.isNotEmpty){
        SnackShow.showFailure(context, next.errorMessage);
      }else if(next.isSuccess){
        ref.invalidate(classNoticeProvider2(class_sec_id));
        SnackShow.showSuccess(context, 'Successfully Added');
        Get.back();

      }
    });






    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: primary,
          title: Text('Add Class Notice' ,style: TextStyle(color: Colors.white),),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: _formKey,
            child:  isTrue == true ? ListView(
              children: [
                if (_error != null)
                  Text(
                    _error,
                    style: TextStyle(color: Colors.red),
                  ),
                Container(
                    // height: MediaQuery.of(context).size.height * 0.07,

                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.end,
                      children: [
                        Text(
                          'Send Notifications',
                          style: TextStyle(color: Colors.black),
                        ),
                        Transform.scale(
                          scale: 0.8,
                          child: CupertinoSwitch(
                              activeColor: primary,
                              value: isSwitched,
                              onChanged: toggleSwitch
                          ),
                        )
                      ],
                    )),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: shimmerHighlightColor,
                      border: Border.all(color: Colors.black)),
                  child: TextFormField(
                    controller: _titleController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintText: 'Title',
                        hintStyle: TextStyle(color: Colors.black)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return SnackShow.showFailure(context, 'Title cannot be empty');
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: shimmerHighlightColor,
                      border: Border.all(color: Colors.black)),
                  child: TextFormField(
                    controller: _descriptionController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintText: 'Description',
                        hintStyle: TextStyle(color: Colors.black)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return SnackShow.showFailure(context, 'Description cannot be empty');
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 10,),



                CommonTextButton(
                    buttonText: 'Submit',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final String auth_token = auth.user.token;

                      setState(() {
                        isTrue = false;
                      });

                      await ref.read(noticeProvider.notifier).addNotice(
                        token: auth.user.token,
                        title: _titleController.text,
                        description: _descriptionController.text,
                        for_all_class: false,
                        image: null,
                        notification: isSwitched,
                        added_by: widget.teacher_id,
                        notice_type: 1,

                      ).then((value) => ref.refresh(noticeList(auth.user.token)));


                      Future.delayed(const Duration(milliseconds: 1200), () {
                        setState(() {
                          final noticeData = ref.watch(noticeList(auth_token));
                          noticeData.when(
                            data: (notice_data) async {
                              final lastAdded = notice_data.first.id;

                              print('notice id ${lastAdded}');
                              print('class_Sec_id ${widget.class_sec_id}');

                              ref.read(classNoticeProvider.notifier).addClassNotice(
                                token: auth.user.token,
                                notice: lastAdded,
                                classSection: widget.class_sec_id,
                              );
                            },
                            error: (err, stack) => Center(child: Text('$err')),
                            loading: () => null,
                          );
                        });
                      });


                      //
                      // setState(() {
                      //   final noticeData = ref.watch(noticeList(auth_token));
                      //   noticeData.when(
                      //     data: (notice_data) async {
                      //       final lastAdded = notice_data.first.id;
                      //
                      //       print('notice id ${lastAdded}');
                      //       print('class_Sec_id ${widget.class_sec_id}');
                      //
                      //       ref.read(classNoticeProvider.notifier).addClassNotice(
                      //         token: auth.user.token,
                      //         notice: lastAdded,
                      //         classSection: widget.class_sec_id,
                      //       );
                      //     },
                      //     error: (err, stack) => Center(child: Text('$err')),
                      //     loading: () => null,
                      //   );
                      // });




                    }






                  },
                ),

              ],
            ) : Center(child: Text("Wait a moment......."),),
          ),
        ));
  }
}
