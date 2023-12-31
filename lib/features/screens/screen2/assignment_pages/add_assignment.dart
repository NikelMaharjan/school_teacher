import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:eschool_teacher/constants/colors.dart';
import 'package:eschool_teacher/features/authentication/providers/auth_provider.dart';
import 'package:eschool_teacher/features/model/class_subject.dart';
import 'package:eschool_teacher/features/providers/assignment_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../constants/snack_show.dart';
import '../../../providers/image_provider.dart';
import '../../../services/assignment_services.dart';

class Add_Assignment extends ConsumerStatefulWidget {

  final ClassSubject classSubject;


  const Add_Assignment({super.key,required this.classSubject});

  @override
  ConsumerState<Add_Assignment> createState() => _Add_AssignmentState();
}

class _Add_AssignmentState extends ConsumerState<Add_Assignment> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController dueController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final _form = GlobalKey<FormState>();
  String dropdownValue='';
  File? file;


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
    final image=ref.watch(imageProvider);
    final auth = ref.watch(authProvider);
    final assign = ref.watch(assignmentProvider);


    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        title: const Text("ADD ASSIGNMENT", style: TextStyle(color: Colors.white),) ,
      ),
      // resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Form(
        key: _form,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20,),
                Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: shimmerHighlightColor,
                        border: Border.all(color: Colors.black)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.classSubject.subject.subjectName} - ${widget.classSubject.classSection?.className.classLevel.name}${widget.classSubject.classSection?.section.sectionName}',
                          style: const TextStyle(color: Colors.black),
                        ),

                      ],
                    )),
                SizedBox(
                  height: 15.h,
                ),

                Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: shimmerHighlightColor,
                        border: Border.all(color: Colors.black)),
                    child: TextFormField(
                      controller: titleController,
                      validator: (value) {
                        if (value!.isEmpty) {
                         // return SnackShow.showFailure(context, 'Title cannot be empty');

                          return "Field cannot be empty";
                        }
                        return null;
                      },
                      style: TextStyle(
                          color: Colors.black, fontSize: 15.sp),
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          hintText: 'Assignment Name',
                          hintStyle: TextStyle(
                              color: Colors.black, fontSize: 15.sp),
                          contentPadding: EdgeInsets.only(
                              left: 8.w, bottom: 8.h)),
                    )),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: shimmerHighlightColor,
                        border: Border.all(color: Colors.black)),
                    child: TextFormField(
                      maxLines: 6,
                      controller: descController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          //return SnackShow.showFailure(context, 'Description cannot be empty');

                          return "Field cannot be empty";
                        }
                        return null;
                      },
                      style: TextStyle(
                          color: Colors.black, fontSize: 15.sp),
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          hintText: 'Assignment Description',
                          hintStyle: TextStyle(
                              color: Colors.black, fontSize: 15.sp),
                          contentPadding: EdgeInsets.only(
                              top: 8.h,
                              left: 8.w,
                              bottom: 8.h,
                              right: 8.w)),
                    )),

                SizedBox(
                  height: 15.h,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width*0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: shimmerHighlightColor,
                            border: Border.all(color: Colors.black)),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'Deadline',
                              style: TextStyle(color: Colors.black),
                            ),
                            Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
                                  activeColor: primary,
                                  value: isSwitched,
                                  onChanged: toggleSwitch),
                            )
                          ],
                        )),
                    SizedBox(width: 40.h,),
                    isSwitched== false ? SizedBox( width: MediaQuery.of(context).size.width*0.4,)
                        : Visibility(
                            visible: isSwitched,
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                width:
                                    MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: shimmerHighlightColor,
                                    border: Border.all(color: Colors.black)),
                                child: TextFormField(
                                  maxLines: 1,
                                  controller: dueController,
                                  onTap: () async {
                                    DateTime? date = DateTime(1900);
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());

                                    date = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2020),
                                        lastDate: DateTime(2030));

                                    dueController.text =
                                        "${date!.year}-${date.month}-${date.day}";

                                  },



                                  style: TextStyle(
                                      color: Colors.black, fontSize: 15.sp),
                                  validator: (value) {
                                    if (value!.isEmpty) {

                                      return "Field cannot be empty";
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(

                                      focusedBorder: InputBorder.none,
                                      border: InputBorder.none,
                                      hintText: 'Due Date',
                                      hintStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15.sp),
                                      contentPadding: EdgeInsets.only(
                                          top: 8.h,
                                          left: 8.w,
                                          bottom: 8.h,
                                          right: 8.w)),
                                )),
                          ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(

                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: shimmerHighlightColor,
                        border: Border.all(color: Colors.black)),
                    child: DropdownSearch<String>(

                      popupProps:  PopupProps.menu(
                        containerBuilder: (BuildContext context, Widget child) {
                          return Container(
                            constraints: const BoxConstraints(minHeight: 100),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: child,
                          );
                        },
                        loadingBuilder: (context, index) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        itemBuilder: (BuildContext context, dynamic item, bool isSelected) {
                          return Container(
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.grey[300] : null,
                            ),
                            child: ListTile(
                              title: Text(
                                item.toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        },


                      ),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                          textAlign: TextAlign.start,
                          baseStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w500,color: Colors.black),
                          dropdownSearchDecoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                              label: Text('Type'),
                              labelStyle: TextStyle(color: Colors.grey,fontSize: 15)
                          )
                      ),
                      items: const ['File', 'Image'],

                      onChanged: (value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      selectedItem: dropdownValue,
                    ), ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: shimmerHighlightColor,
                        border: Border.all(color: Colors.black)),
                    child: TextFormField(
                      controller: linkController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return null; // return null if value is null or empty
                        }
                        return null;
                      },
                      style: TextStyle(
                          color: Colors.black, fontSize: 15.sp),
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          border: InputBorder.none,
                          hintText: 'Assignment Link',
                          hintStyle: TextStyle(
                              color: Colors.black, fontSize: 15.sp),
                          contentPadding: EdgeInsets.only(
                              left: 8.w, bottom: 8.h)),
                    )),
                SizedBox(
                  height: 15.h,
                ),

                // InkWell(
                //   onTap: () async {
                //     FilePickerResult? result = await FilePicker.platform.pickFiles();
                //     if (result != null) {
                //       setState(() {
                //         file =File(result.files.single.path!);
                //       });
                //
                //     } else {
                //
                //       print("ASdsadsa");
                //     }
                //
                //   },
                //     child: Container(color: Colors.red, child: file == null ? Text("SAD") : Text(file!.path),)),


                image  == null ? DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(10),
                  dashPattern: const [5, 5],
                  color: primary,
                  strokeWidth: 1,
                  child: InkWell(
                    onTap: () {

                     ref.read(imageProvider.notifier).pickAnImage();

                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 20.sp,
                            backgroundColor: primary,
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Text(
                            'Reference Material',
                            style: TextStyle(
                                color: Colors.black, fontSize: 15.sp),
                          )
                        ],
                      ),
                    )

                  ),
                )
                    : Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.9,
                     decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                    child: InkWell(
                      onTap: () {
                        ref.read(imageProvider.notifier).pickAnImage();

                      },
                      child: Image.file(File(image.path),fit: BoxFit.contain,)),
                ),

                const SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 8.h, horizontal: 8.w),
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                        fixedSize: Size.fromWidth(250.w),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              color: Colors.black,
                            ))),
                    onPressed: () async {



                      _form.currentState!.save();
                      if(_form.currentState!.validate()) {


                        if(dropdownValue == ''){

                          return SnackShow.showFailure(context, 'Select the type first');
                        } else{

                          if (linkController.text.isEmpty && image == null) {
                            ref.read(assignmentProvider.notifier)
                                .addAssignment(
                                title: titleController.text.trim(),
                                description: descController.text.trim(),
                                hasDeadline: isSwitched,
                                type: dropdownValue,
                                subject: widget.classSubject.id,
                                token: auth.user.token,
                                deadline: dueController.text

                            ).then((value) => ref.invalidate(imageProvider))
                                .then((value) => ref.refresh(
                                assignmentList(auth.user.token)))
                                .then((value) => Navigator.pop(context));
                          }
                          else if (linkController.text.isEmpty) {
                            ref.read(assignmentProvider.notifier)
                                .addAssignment(
                                title: titleController.text.trim(),
                                description: descController.text.trim(),
                                hasDeadline: isSwitched,
                                type: dropdownValue,
                                subject: widget.classSubject.id,
                                token: auth.user.token,
                                deadline: dueController.text,
                                image: image

                            ).then((value) => ref.invalidate(imageProvider))
                                .then((value) => ref.refresh(
                                assignmentList(auth.user.token)))
                                .then((value) => Navigator.pop(context));
                          }
                          else if (image == null) {
                            ref.read(assignmentProvider.notifier)
                                .addAssignment(
                                title: titleController.text.trim(),
                                description: descController.text.trim(),
                                hasDeadline: isSwitched,
                                type: dropdownValue,
                                subject: widget.classSubject.id,
                                token: auth.user.token,
                                deadline: dueController.text,
                                link: linkController.text.trim()

                            ).then((value) => ref.invalidate(imageProvider))
                                .then((value) => ref.refresh(
                                assignmentList(auth.user.token)))
                                .then((value) => Navigator.pop(context));
                          }
                          else {
                            ref.read(assignmentProvider.notifier)
                                .addAssignment(
                                title: titleController.text.trim(),
                                description: descController.text.trim(),
                                hasDeadline: isSwitched,
                                type: dropdownValue,
                                subject: widget.classSubject.id,
                                token: auth.user.token,
                                deadline: dueController.text,
                                link: linkController.text.trim(),
                                image: image

                            ).then((value) => ref.invalidate(imageProvider))
                                .then((value) => ref.refresh(
                                assignmentList(auth.user.token)))
                                .then((value) => Navigator.pop(context));
                          }


                        }


                      }

                      else {
                        print("No Validation");
                      }
                      },



                    child: assign.isLoad? const CircularProgressIndicator(

                    ):Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

