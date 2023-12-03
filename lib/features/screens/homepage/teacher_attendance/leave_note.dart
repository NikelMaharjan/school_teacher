import 'package:dio/dio.dart';
import 'package:eschool_teacher/features/providers/attendance_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../constants/colors.dart';
import '../../../../../utils/commonWidgets.dart';
import '../../../../constants/snack_show.dart';
import '../../../authentication/providers/auth_provider.dart';

class AddNote extends ConsumerStatefulWidget {

  final int teacher_id;

  AddNote({required this.teacher_id });

  @override
  ConsumerState<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends ConsumerState<AddNote> {

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  // Controllers for the text fields
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();

  // Function to show the date picker dialog
  Future<void> _showDatePicker(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.text.isEmpty ? DateTime.now() : DateTime.parse(controller.text),
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.toString().substring(0, 10);
      });
    }
  }


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
    final reasonController = TextEditingController();

    final auth = ref.watch(authProvider);

    final leave = ref.watch(attendanceProvider);




    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primary,
        title: Text('Add Leave Note'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Form(
          key: _formKey,
          child: ListView(
              children: [

                Container(
                  // height: MediaQuery.of(context).size.height * 0.07,

                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.end,
                      children: [
                        Text(
                          'Long leave?',
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


                SizedBox(height: 10.h,),

                Row(
                  children: [
                    Expanded(
                      child: Container(

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: shimmerHighlightColor,
                            border: Border.all(color: Colors.black)),
                        child: TextFormField(
                          controller: _startDateController,
                          onTap: () {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            _showDatePicker(context, _startDateController);
                          },
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Date is  required';
                            }
                            return null;
                          },


                          style:TextStyle(color:Colors.black) ,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                              hintText: 'Start Date',
                              hintStyle: TextStyle(color:Colors.black)
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),

                    Expanded(
                      child: isSwitched == true?  Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: shimmerHighlightColor,
                            border: Border.all(color: Colors.black)),
                        child: TextFormField(
                          controller: _endDateController,
                          onTap: () {
                            _showDatePicker(context, _endDateController);
                          },
                          style:TextStyle(color:Colors.black) ,
                          onEditingComplete: () {},
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                              hintText: 'End Date',
                              hintStyle: TextStyle(color:Colors.black)
                          ),
                        ),
                      ):SizedBox(),
                    ),
                  ],
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
                    controller: reasonController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintText: 'Reason',
                        hintStyle: TextStyle(color: Colors.black)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return SnackShow.showFailure(context, 'Reason cannot be empty');
                      }
                      return null;
                    },
                    onEditingComplete: (){},
                  ),
                ),





                CommonTextButton(
                  buttonText: 'Submit',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      final String auth_token = auth.user.token;

                      print(auth_token);



                      print(reasonController.text.trim());

                      if(isSwitched == false) {
                        if(DateTime.parse(_startDateController.text).isBefore(DateTime.now())){

                          return SnackShow.showFailure(context, 'Date is before current date');

                        }
                        else {
                          ref.read(attendanceProvider.notifier).addTeacherLeaveNote(
                              reason: reasonController.text.trim(),
                              employee: widget.teacher_id,
                              longLeave: false,
                              token: auth.user.token,
                              startDate: _startDateController.text,
                              endDate: null
                          ).then((value) => Navigator.pop(context));
                        }
                      }

                      else if(isSwitched == true) {
                        if(DateTime.parse(_startDateController.text).isBefore(DateTime.now()) || DateTime.parse(_endDateController.text).isBefore(DateTime.now())){
                          return SnackShow.showFailure(context, 'Date is before current date');

                        }
                        else {

                          ref.read(attendanceProvider.notifier).addTeacherLeaveNote(
                              reason: reasonController.text.trim(),
                              employee: widget.teacher_id,
                              longLeave: true,
                              token: auth.user.token,
                              startDate: _startDateController.text,
                              endDate: _endDateController.text
                          ).then((value) => Navigator.pop(context));
                        }
                      }


                    }






                  },
                ),

              ]),
        ),
      ),
    );
  }
}