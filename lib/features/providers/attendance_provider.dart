



import 'package:eschool_teacher/attendance_state.dart';
import 'package:eschool_teacher/attendance_state.dart';
import 'package:eschool_teacher/attendance_state.dart';
import 'package:eschool_teacher/features/services/attendance_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/crud_state.dart';
import '../services/teacher_attendance_service.dart';




final attendanceProvider = StateNotifierProvider<AttendanceNotifier, AttendanceState>((ref) => AttendanceNotifier(AttendanceState.empty()));

class AttendanceNotifier extends StateNotifier<AttendanceState>{
  AttendanceNotifier(super.state);


  Future<void> addAttendanceTeacher({
    required int attendance,
    required String ip_address,
    required int employee,
    required String status,
    required String token,
    required double long,
    required double lat,


  }) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false, isAttendanceSuccess: false);
    final response = await TeacherAttendanceService(token).addAttendanceTeacher(
        attendance: attendance,
        ip_address: ip_address,
        employee: employee,
        status: status,
        long: long,
        lat:  lat
    );
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, attendanceErrorMessage: l, isSuccess: false, isAttendanceSuccess: false);
    }, (r) {
      state = state.copyWith(isLoad: false, errorMessage: '', attendanceErrorMessage: '', isSuccess: true, isAttendanceSuccess: true);
    });
  }

  Future<void> addDate({
    required String token,
    required String date,
    required bool bachelorClass,
    required int classSection,
    required int teacher_id

  }) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await AttendanceService(token).addDate(
        date: date,
        bachelorClass: bachelorClass,
        classSection: classSection,
        teacher_id: teacher_id
    );
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
    }, (r) {
      state = state.copyWith(
          isLoad: false, errorMessage: '', isSuccess: true);

    });
  }

  Future<void> addAttendanceStudent({
    required String token,
    required int attendance,
    required int student,
    required String status

  }) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await AttendanceService(token).addStudentAttendance(
        attendance: attendance,
        student: student, status: status
    );
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
    }, (r) {
      state = state.copyWith(
          isLoad: false, errorMessage: '', isSuccess: true);

    });
  }

  Future<void> editAttendanceStudent({
    required String token,
    required int attendance,
    required int student,
    required String status,
    required int id

  }) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await AttendanceService(token).editStudentAttendance(
        id: id,
        attendance: attendance,
        student: student,
        status: status
    );
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false);
    }, (r) {
      state = state.copyWith(
          isLoad: false, errorMessage: '', isSuccess: true);

    });
  }


  Future<void> addTeacherLeaveNote({
    required String token,
    required String reason,
    required String startDate,
    required String? endDate,
    required bool longLeave,
    required int employee,

  }) async {
    state = state.copyWith(isLoad: true, errorMessage: '', isSuccess: false);
    final response = await TeacherLeaveNoteService(token).addLeaveNote(
        reason: reason,
        startDate: startDate,
        endDate: endDate,
        longLeave: longLeave,
        employee: employee);
    response.fold((l) {
      state = state.copyWith(isLoad: false, errorMessage: l, isSuccess: false, isLeaveSuccess: false);
    }, (r) {
      state = state.copyWith(
          isLoad: false, errorMessage: '', isSuccess: true, isLeaveSuccess: true);

    });
  }




}