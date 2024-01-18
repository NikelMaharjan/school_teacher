import 'package:eschool_teacher/constants/colors.dart';
import 'package:eschool_teacher/constants/snack_show.dart';
import 'package:eschool_teacher/features/authentication/providers/auth_provider.dart';
import 'package:eschool_teacher/features/providers/notice_providers.dart';
import 'package:eschool_teacher/utils/commonWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';


import '../../../../services/notice_services.dart';

class AddNotice extends ConsumerStatefulWidget {

  final int teacher_id;

  final int class_sec_id;

  const AddNotice({super.key, required this.teacher_id, required this.class_sec_id, });

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
    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    String error = '';
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
          title: const Text('Add Class Notice' ,style: TextStyle(color: Colors.white),),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: formKey,
            child:  isTrue == true ? ListView(
              children: [
                if (error != null)
                  Text(
                    error,
                    style: const TextStyle(color: Colors.red),
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
                    controller: titleController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintText: 'Title',
                        hintStyle: TextStyle(color: Colors.black)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "title cannot be empty";
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
                    controller: descriptionController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintText: 'Description',
                        hintStyle: TextStyle(color: Colors.black)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "description cannot be empty";
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 10,),



                CommonTextButton(
                    buttonText: 'Submit',
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      final String authToken = auth.user.token;

                      setState(() {
                        isTrue = false;
                      });

                      await ref.read(noticeProvider.notifier).addNotice(
                        token: auth.user.token,
                        title: titleController.text,
                        description: descriptionController.text,
                        for_all_class: false,
                        image: null,
                        notification: true,
                        added_by: widget.teacher_id,
                        notice_type: 1,

                      ).then((value) => ref.refresh(noticeList(auth.user.token)));


                      Future.delayed(const Duration(milliseconds: 1200), () {
                        setState(() {
                          final noticeData = ref.watch(noticeList(authToken));
                          noticeData.when(
                            data: (noticeData) async {
                              final lastAdded = noticeData.first.id;

                           //   print('notice id ${lastAdded}');
                           //   print('class_Sec_id ${widget.class_sec_id}');

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
            ) : Center(child: Lottie.asset('assets/jsons/loading.json'),)
          ),
        ));
  }
}
