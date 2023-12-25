import 'package:dio/dio.dart';
import 'package:eschool_teacher/constants/colors.dart';
import 'package:eschool_teacher/features/authentication/providers/auth_provider.dart';
import 'package:eschool_teacher/features/model/notice.dart';
import 'package:eschool_teacher/features/providers/notice_providers.dart';
import 'package:eschool_teacher/utils/commonWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../api.dart';
import '../../../../../../constants/snack_show.dart';

import '../../../../../services/notice_services.dart';
import '../../../../../services/school_info_services.dart';

class EditSubNotice extends ConsumerStatefulWidget {

  final SubjectNotice subjectNotice;

  final int class_sec_id;
  final int sub_id;
  final int class_sub_id;


  EditSubNotice({required this.class_sec_id,required this.sub_id,required this.subjectNotice,required this.class_sub_id});

  @override
  ConsumerState<EditSubNotice> createState() =>
      _SubjectNoticeFormState(class_sec_id: class_sec_id, sub_id: sub_id,subjectNotice: subjectNotice,class_sub_id: class_sub_id);
}

class _SubjectNoticeFormState extends ConsumerState<EditSubNotice> {
  final int class_sec_id;
  final int sub_id;
  final SubjectNotice subjectNotice;
  final int class_sub_id;

  _SubjectNoticeFormState({required this.class_sec_id,required this.sub_id,required this.subjectNotice,required this.class_sub_id});

  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _messageController = TextEditingController();
  final _dio = Dio();
  String _error = '';


  @override
  void initState() {
    _titleController..text = widget.subjectNotice.title;
    _messageController..text = widget.subjectNotice.message;
    super.initState();
  }

  // Future<void> _submitForm({
  //   required String token,
  // }) async {
  //   try {
  //     final response = await _dio.post(
  //       Api.subNotices,
  //       data: {
  //         'title': _titleController.text,
  //         'message': _messageController.text,
  //         'subject_name': classSub_id,
  //         'school_college': school_id
  //       },
  //       options: Options(
  //         headers: {'Authorization': 'token $token'},
  //       ),
  //     );
  //     if (response.statusCode == 200) {
  //       Get.back();
  //     } else {
  //       setState(() {
  //         _error = 'Server error';
  //       });
  //     }
  //   } on DioError catch (e) {
  //     setState(() {
  //       _error = 'Network error';
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
   // print('${class_sec_id}');

    final loadData = ref.watch(subNoticeProvider);

    
    ref.listen(subNoticeProvider, (previous, next) {
      if(next.errorMessage.isNotEmpty){
        SnackShow.showFailure(context, next.errorMessage);
      }else if(next.isSuccess){
        SnackShow.showSuccess(context, 'succesfully updated');
       // ref.invalidate(subNoticeProvider);
        ref.invalidate(subNoticeList(auth.user.token));

        Get.back();
      }
    });
    
    

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: primary,
          title: Text('Edit Notice', style: TextStyle(color: Colors.white),),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
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
                    controller: _messageController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintText: 'Message',
                        hintStyle: TextStyle(color: Colors.black)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return SnackShow.showFailure(context, 'Message cannot be empty');
                      }
                      return null;
                    },
                  ),
                ),

                SizedBox(height: 20,),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: bgColor
                  ),
                  onPressed:  loadData.isLoad ?  null : ()  async {

                //    print('${widget.subjectNotice.id} token : ${auth.user.token} class SUB id : ${class_sub_id}');

                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final String auth_token = auth.user.token;


                      await ref.read(subNoticeProvider.notifier).updateSubNotice(
                           token: auth.user.token,
                           title: _titleController.text,
                           message: _messageController.text,
                           id: widget.subjectNotice.id,
                           class_subject: class_sub_id

                      );
                    }








                  }, child:  Text("Edit", style: TextStyle(color: Colors.white),),
                )



              ],
            ),
          ),
        ));
  }
}
