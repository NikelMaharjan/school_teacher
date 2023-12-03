



import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api.dart';
import '../authentication/providers/auth_provider.dart';
import '../model/attendance_teacher.dart';

final dio = Dio();


final attendanceDateTeacher = FutureProvider.family(
        (ref, String token) => TeacherAttendanceService(token).getDateTeacher());


final teacherAttendanceProvider = FutureProvider.family<List<TeacherAttendance>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final teacherAttendance = TeacherAllAttendanceService(token.user.token, id);
  return await teacherAttendance.getAllAttendance();
});



class TeacherAttendanceService{
  String token;
  TeacherAttendanceService(this.token);


  Future<List<AttendanceDateTeacher>> getDateTeacher() async {
    try {
      final response = await dio.get(Api.teacherAttendanceUrl,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));

      final data = (response.data['data'] as List)
          .map((e) => AttendanceDateTeacher.fromJson(e))
          .toList();
      // print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);

      throw Exception('Unable to fetch data');
    }
  }

  Future<Either<String, dynamic>> addDateTeacher({
    required String date,

  }) async {
    try {
      final response = await dio.post(Api.teacherAttendanceUrl,
          data: {
            'date': date
          },
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      return Right(response.data);
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Network error');
    }
  }

  Future<List<TeacherAttendance>> getAttendanceTeacher() async {
    try {
      final response = await dio.get(Api.teacherAttendanceUrl,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));

      final data = (response.data['navigation']['data'] as List)
          .map((e) => TeacherAttendance.fromJson(e))
          .toList();
      // print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);

      throw Exception('Unable to fetch data');
    }
  }

  Future<Either<String, dynamic>> addAttendanceTeacher({
    required int attendance,
    required String ip_address,
    required int employee,
    required String status

  }) async {
    try {
      final response = await dio.post(Api.teacherAttendanceInfoUrl,
          data: {
            "attendance": attendance,
            "employee" : employee,
            "status" : status,
            "ip_address" : ip_address

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

class TeacherAllAttendanceService {
  String token;
  int id;

  TeacherAllAttendanceService(this.token, this.id);

  final dio = Dio();

  Future<List<TeacherAttendance>> getAllAttendance() async {
    try {
      final response = await dio.get('${Api.teacherAllAttendanceInfoUrl}$id',
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => TeacherAttendance.fromJson(e))
          .toList();
      print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}

class TeacherLeaveNoteService{
  String token;
  TeacherLeaveNoteService(this.token);


  Future<Either<String, dynamic>> addLeaveNote({
    required String reason,
    required String startDate,
    required String? endDate,
    required bool longLeave,
    required int employee,

  }) async {
    try {
      final response = await dio.post(Api.teacherLeaveNoteUrl,
          data: {
            "reason": reason,
            "long_leave": longLeave,
            "start_date": startDate,
            "end_date": endDate,
            "employee": employee
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