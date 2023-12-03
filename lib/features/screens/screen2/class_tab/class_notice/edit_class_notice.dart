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
import '../../../../model/notice.dart';

import '../../../../services/notice_services.dart';
import '../../../../services/school_info_services.dart';

class EditNotice extends ConsumerStatefulWidget {

  final NoticeData noticeData;

  EditNotice({required this.noticeData});

  @override
  ConsumerState<EditNotice> createState() => _EditNoticeState(noticeData: noticeData);
}

class _EditNoticeState extends ConsumerState<EditNotice> {


  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  final NoticeData noticeData;


  _EditNoticeState({required this.noticeData});
  late bool isSwitched; // Declare the variable as late

  @override
  void initState() {
    super.initState();
    isSwitched = widget.noticeData.sendNotification;
    _titleController..text = widget.noticeData.title;
    _descriptionController..text = widget.noticeData.description;// Initialize the variable here
  }

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

    String _error = '';
    final auth = ref.watch(authProvider);
    final noticeLoad = ref.watch(noticeList(auth.user.token));




    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: primary,
          title: Text('Edit Class Notice'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: _formKey,
            child: ListView(
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
                CommonTextButton(
                  buttonText: 'Submit',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final String auth_token = auth.user.token;

                      print(auth_token);

                      await ref.read(noticeProvider.notifier).updateNotice(
                          token: auth_token,
                          title: _titleController.text,
                          description: _descriptionController.text,
                          for_all_class: false,
                          notification: isSwitched,
                          added_by: widget.noticeData.addedBy!.id,
                          notice_type: widget.noticeData.noticeType!.id,
                          id: widget.noticeData.id
                      ).then((value) => ref.refresh(noticeList(auth.user.token))).then((value) => ref.refresh(classNoticeList(auth.user.token))).then((value) => Navigator.pop(context));
                      

                    }






                  },
                ),

              ],
            ),
          ),
        ));
  }
}
