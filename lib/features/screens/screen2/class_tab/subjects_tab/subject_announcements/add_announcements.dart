import 'package:dio/dio.dart';
import 'package:eschool_teacher/constants/colors.dart';
import 'package:eschool_teacher/features/authentication/providers/auth_provider.dart';
import 'package:eschool_teacher/features/providers/notice_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../../constants/snack_show.dart';

import '../../../../../services/notice_services.dart';
import '../../../../../services/school_info_services.dart';
import '../../../../../services/subject_class_service.dart';

class SubjectNoticeForm extends ConsumerStatefulWidget {
  final int class_sec_id;
  final int sub_id;


  const SubjectNoticeForm({super.key, required this.class_sec_id,required this.sub_id});

  @override
  ConsumerState<SubjectNoticeForm> createState() =>
      _SubjectNoticeFormState(class_sec_id: class_sec_id, sub_id: sub_id);
}

class _SubjectNoticeFormState extends ConsumerState<SubjectNoticeForm> {
  final int class_sec_id;

  final int sub_id;

  _SubjectNoticeFormState({required this.class_sec_id,required this.sub_id});

  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();
  final _subjectNameController = TextEditingController();
  final _schoolCollegeController = TextEditingController();
  final _dio = Dio();
  String _error = '';



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
    final _schoolData = ref.watch(schoolInfo(auth.user.token));
    final classSubList = ref.watch(classSubInfo2(auth.user.token));
    final subNotice = ref.watch(subNoticeProvider);


    ref.listen(subNoticeProvider, (previous, next) {
      if(next.errorMessage.isNotEmpty){
        SnackShow.showFailure(context, next.errorMessage);
      }else if(next.isSuccess){
        SnackShow.showSuccess(context, 'successfully added');
        // ref.invalidate(subNoticeProvider);
        ref.invalidate(subNoticeList(auth.user.token));

        Get.back();
      }
    });
    // print('${class_sec_id}');
    // print('class subject ${sub_id}');

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: primary,
          title: const Text('Add Subject Notice', style: TextStyle(color: Colors.white),),
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
                    style: const TextStyle(color: Colors.red),
                  ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: shimmerHighlightColor,
                      border: Border.all(color: Colors.black)),
                  child: TextFormField(
                    controller: _titleController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
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
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
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

                const SizedBox(height: 10 ,),

                classSubList.when(
                    data: (data){
                      final classSub_data = data.firstWhere((element) => element.id==sub_id);
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: bgColor
                        ),

                        onPressed: subNotice.isLoad ? null : () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            final String authToken = auth.user.token;


                            await ref.read(subNoticeProvider.notifier)
                                .addSubNotice(
                                token: authToken,
                                title: _titleController.text,
                                message: _messageController.text,
                                class_subject: classSub_data.id,

                            );
                          }








                        }, child: const Text("Add Notice", style: TextStyle(color: Colors.white),),
                      );
                    },
                  error: (err, stack) => Center(child: Text('$err')),
                  loading: () => Container(),
                ),



              ],
            ),
          ),
        ));
  }
}
