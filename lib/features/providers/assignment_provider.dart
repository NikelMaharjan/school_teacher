


import 'package:eschool_teacher/features/services/assignment_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../model/crud_state.dart';

final assignmentProvider = StateNotifierProvider<AssignmentNotifier, CrudState>((ref) => AssignmentNotifier(CrudState.empty()));



class AssignmentNotifier extends StateNotifier<CrudState>{
  AssignmentNotifier(super.state);


  Future<void> addAssignment({
    required String title,
    required String description,
    required bool hasDeadline,
    String? deadline,
    String? link,
    XFile? image,
    required String type,
    required int subject,
    required String token

  }) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await AssignmentService(token).addAssignment(
        title: title,
        description: description,
        hasDeadline: hasDeadline,
        type: type,
        deadline: deadline,
        link: link,
        image: image,
        subject: subject);
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
    }, (r) {
      state = state.copyWith(
          isLoad: false, errorMessage: '', isSuccess: true);

    });
  }

  Future<void> editAssignment({
    required int id,
    required String title,
    required String description,
    required bool hasDeadline,
    String? deadline,
    String? link,
    XFile? image,
    required String type,
    required int subject,
    required String token

  }) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await AssignmentService(token).editAssignment(
        id: id,
        title: title,
        description: description,
        hasDeadline: hasDeadline,
        type: type,
        subject: subject,
      deadline: deadline,
      link: link,
      image: image
    );
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
    }, (r) {
      state = state.copyWith(
          isLoad: false, errorMessage: '', isSuccess: true);

    });
  }

  Future<void> delAssignment(
      int id, String token,
      ) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await AssignmentService(token).delAssignment(id: id);

    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
    }, (r) {
      state = state.copyWith(
          isLoad: false, errorMessage: '', isSuccess: true);
    });
  }

  Future<void> addStatus({
    required String remarks,
    required String status,
    required bool notifications,
    required int studentAssignment,
    required String token

  }) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await AssignmentService(token).addStatus(
        remarks: remarks,
        status: status,
        notifications: notifications,
        studentAssignment: studentAssignment);
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
    }, (r) {
      state = state.copyWith(
          isLoad: false, errorMessage: '', isSuccess: true);

    });
  }

  Future<void> editStatus({
    required int id,
    required String remarks,
    required String status,
    required bool notifications,
    required int studentAssignment,
    required String token

  }) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await AssignmentService(token).editStatus(
      id: id,
        remarks: remarks,
        status: status,
        notifications: notifications,
        studentAssignment: studentAssignment);
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
    }, (r) {
      state = state.copyWith(
          isLoad: false, errorMessage: '', isSuccess: true);

    });
  }

}
