


import 'package:eschool_teacher/features/services/assignment_services.dart';
import 'package:eschool_teacher/status_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../model/crud_state.dart';

final statusProvider = StateNotifierProvider<StatusProvider, StatusState>((ref) => StatusProvider(StatusState.empty()));



class StatusProvider extends StateNotifier<StatusState>{
  StatusProvider(super.state);




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
