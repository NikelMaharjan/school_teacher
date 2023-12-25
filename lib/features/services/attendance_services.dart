import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eschool_teacher/constants/snack_show.dart';
import 'package:eschool_teacher/features/model/attendance_student.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../api.dart';
import '../authentication/providers/auth_provider.dart';
import '../model/attendance_teacher.dart';
import '../model/calendar_event.dart';



final attendanceDateStudent = FutureProvider.family(
        (ref, String token) => AttendanceService(token).getDate());

final attendanceStudentList = FutureProvider.family(
        (ref, String token) => AttendanceService(token).getStudentAttendance());


final studentAttendanceProvider = FutureProvider.family.autoDispose <List<StudentAttendance>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final studentStatus = StudentAttendanceService(token.user!.token, id);
  return await studentStatus.getStudentAttendance();
});


final studentClassAttendanceProvider = FutureProvider.family<List<StudentAttendance>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final studentStatus = StudentClassAttendanceService(token.user!.token, id);
  return await studentStatus.getStudentAttendance();
});



final studentLeaveNoteProvider = FutureProvider.family<List<StudentLeaveNote>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final studentStatus = StudentLeaveNoteService(token.user!.token, id);
  return await studentStatus.getStudentLeaveNote();
});




class AttendanceService {
  String token;

  AttendanceService(this.token);

  final dio = Dio();


  //for students...

  Future<List<Attendance>> getDate() async {
    try {
      final response = await dio.get(Api.attendanceUrl,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));


      if(response.statusCode == 204) {
        return [

        ];
      }

      final data = (response.data['navigation']['data'] as List)
          .map((e) => Attendance.fromJson(e))
          .toList();
      return data;
    } on DioException catch (err) {
      print(err.response);

      throw Exception('Unable to fetch data');
    }
  }

  Future<Either<String, dynamic>> addDate({
    required String date,
    required bool bachelorClass,
    required int classSection,
    required int teacher_id

  }) async {
    try {
      final response = await dio.post(Api.attendanceUrl,
          data: {
            "date": date,
            "for_bachelors_class": bachelorClass,
            "class_section": classSection,
            "added_by": teacher_id
          },
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      return Right(response.data);
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Network error');
    }
  }

  Future<List<StudentAttendance>> getStudentAttendance() async {
    try {
      final response = await dio.get(Api.studentAttendanceUrl,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));

      final data = (response.data['navigation']['data'] as List)
          .map((e) => StudentAttendance.fromJson(e))
          .toList();
      // print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);

      throw Exception('Unable to fetch data');
    }
  }

  Future<Either<String, dynamic>> addStudentAttendance({
    required int attendance,
    required int student,
    required String status

  }) async {
    try {
      final response = await dio.post(Api.studentAttendanceUrl,
          data: {
            "attendance": attendance,
            "student": student,
            "status": status

          },
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      return Right(response.data);
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Network error');
    }
  }


  Future<Either<String, dynamic>> editStudentAttendance({
    required int id,
    required int attendance,
    required int student,
    required String status

  }) async {
    try {
      final response = await dio.patch('${Api.editStudentAttendanceUrl}$id/',
          data: {
            "attendance": attendance,
            "student": student,
            "status": status

          },
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      return Right(response.data);
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Network error');
    }
  }


}


class StudentAttendanceService {
  String token;
  int id;

  StudentAttendanceService(this.token, this.id);

  final dio = Dio();

  Future<List<StudentAttendance>> getStudentAttendance() async {


    try {
      final response = await dio.get('${Api.studentAttendanceInfo}$id',
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));

      if(response.statusCode == 204){
       return[

       ];
      }


      final data = (response.data['navigation']['data'] as List).map((e) => StudentAttendance.fromJson(e)).toList();
      return data;
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}



class StudentClassAttendanceService {
  String token;
  int id;

  StudentClassAttendanceService(this.token, this.id);

  final dio = Dio();

  Future<List<StudentAttendance>> getStudentAttendance() async {
    try {
      final response = await dio.get('${Api.studentClassAttendanceUrl}$id',
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));

      if(response.statusCode == 204){
        return [

        ];
      }

      final data = (response.data['navigation']['data'] as List).map((e) => StudentAttendance.fromJson(e)).toList();
      return data;
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}


class StudentLeaveNoteService {
  String token;
  int id;

  StudentLeaveNoteService(this.token, this.id);

  final dio = Dio();

  Future<List<StudentLeaveNote>> getStudentLeaveNote() async {
    try {
      final response = await dio.get('${Api.studentLeaveNoteUrl}$id',
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => StudentLeaveNote.fromJson(e))
          .toList();
      print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}