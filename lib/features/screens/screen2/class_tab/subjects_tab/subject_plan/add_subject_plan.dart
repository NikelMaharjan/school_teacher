





import 'package:eschool_teacher/features/providers/plan_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../constants/colors.dart';
import '../../../../../authentication/providers/auth_provider.dart';
import '../../../../../model/class_subject.dart';
import '../../../../../services/subject_class_service.dart';


class AddPlan extends ConsumerStatefulWidget {

  final ClassSecSubject class_id;
  AddPlan({required this.class_id});

  @override
  _AddPlanState createState() => _AddPlanState();
}

class _AddPlanState extends ConsumerState<AddPlan> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _teachingDurationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _expectedOutcomeController = TextEditingController();

  @override
  void dispose() {
    _teachingDurationController.dispose();
    _descriptionController.dispose();
    _expectedOutcomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primary,
        title: Text('Add a plan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black
                  )
                ),
                child: TextFormField(
                  controller: _teachingDurationController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                    border: InputBorder.none,
                    hintText: 'Teaching Duration',
                      hintStyle: TextStyle(color: Colors.black)
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the teaching duration';
                    }else if (value.length > 20){
                      return 'Words exceeded the limit';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 10.h,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.black
                    )
                ),
                child: TextFormField(
                  controller: _expectedOutcomeController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                      border: InputBorder.none,
                      hintText: 'Expected Outcome',
                      hintStyle: TextStyle(color: Colors.black)
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the expected outcome';
                    } else if (value.length > 30){
                      return 'Words exceeded the limit';
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(height: 10.h,),
              Container(
                height: 150.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Colors.black
                    )
                ),
                child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  controller: _descriptionController,
                  maxLines: null,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                      border: InputBorder.none,
                      hintText: 'Description',
                      hintStyle: TextStyle(color: Colors.black)
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Form is valid, do something with the data
                    final teachingDuration = _teachingDurationController.text;
                    final description = _descriptionController.text;
                    final expectedOutcome = _expectedOutcomeController.text;
                    ref.read(planProvider.notifier).addPlan(
                        token: auth.user.token,
                        duration: teachingDuration,
                        description: description,
                        outcome: expectedOutcome,
                        subject: widget.class_id.id
                    ).then((value) => ref.refresh(subPlanList(auth.user.token))).then((value) => Navigator.pop(context));
                  }
                },
                child: auth.isLoad?CircularProgressIndicator(): Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
