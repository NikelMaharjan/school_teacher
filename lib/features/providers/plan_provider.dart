



import 'package:eschool_teacher/features/services/subject_class_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/crud_state.dart';
import '../services/course_class_service.dart';


final planProvider = StateNotifierProvider<PlanNotifier, CrudState>((ref) => PlanNotifier(CrudState.empty()));

final coursePlanProvider = StateNotifierProvider<CoursePlanNotifier, CrudState>((ref) => CoursePlanNotifier(CrudState.empty()));


class PlanNotifier extends StateNotifier<CrudState>{
  PlanNotifier(super.state);

  Future<void> addPlan({
    required String token,
    required String duration,
    required String description,
    required String outcome,
    required int subject,

  }) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await SubjectPlanService(token).addPlan(
        duration: duration,
        description: description,
        outcome: outcome,
        subject: subject
    );
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
    }, (r) {
      state = state.copyWith(
          isLoad: false, errorMessage: '', isSuccess: true);

    });
  }

  Future<void> editPlan({
    required String token,
    required String duration,
    required String description,
    required String outcome,
    required int subject,
    required int id

  }) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await SubjectPlanService(token).editPlan(
        duration: duration, description: description, outcome: outcome, id: id, subject: subject
    );
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
    }, (r) {
      state = state.copyWith(isLoad: false, errorMessage: '', isSuccess: true);
    });
  }


}

class CoursePlanNotifier extends StateNotifier<CrudState>{
  CoursePlanNotifier(super.state);

  Future<void> addPlan({
    required String token,
    required String duration,
    required String description,
    required String outcome,
    required int course,

  }) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await CoursePlanService(token).addPlan(
        duration: duration,
        description: description,
        outcome: outcome,
        course: course
    );
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
    }, (r) {
      state = state.copyWith(
          isLoad: false, errorMessage: '', isSuccess: true);

    });
  }

  Future<void> editPlan({
    required String token,
    required String duration,
    required String description,
    required String outcome,
    required int course,
    required int id

  }) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await CoursePlanService(token).editPlan(
        duration: duration, description: description, outcome: outcome, id: id, course: course
    );
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
    }, (r) {
      state = state.copyWith(isLoad: false, errorMessage: '', isSuccess: true);
    });
  }


}