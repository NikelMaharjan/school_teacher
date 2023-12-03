import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../api.dart';
import '../model/employee_info.dart';
import '../model/teacher_course.dart';
import '../authentication/model/user.dart';
import '../model/teacher_features.dart';

final employeeList = FutureProvider.family(
    (ref, String token) => InfoService(token).getEmployeeInfo());

final userList = FutureProvider.family(
    (ref, String token) => UserService(token).getUserInfo());

final teacherSubList = FutureProvider.family(
        (ref, String token) => TeacherClassService(token).getTeacherSubInfo());

final teacherCourseList = FutureProvider.family(
        (ref, String token) => TeacherCourseService(token).getTeacherCourse());


class InfoService {
  String token;

  InfoService(this.token);

  final dio = Dio();

  Future<List<EmployeeData>> getEmployeeInfo() async {



    try {
      final response = await dio.get(Api.employeeInfo,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));




      if (response.data['data'] is List) {
        final data = (response.data['data'] as List)
            .map((e) => EmployeeData.fromJson(e))
            .toList();
        print('teacher success');
        return data;
      } else if (response.data['data'] is Map) {
        final data = [EmployeeData.fromJson(response.data['data'])];
        print('teacher success');
        return data;
      } else {
        throw Exception('Invalid response format');
      }
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }


}

class UserService {
  String token;

  UserService(this.token);

  final dio = Dio();

  Future<List<UserInfo>> getUserInfo() async {
    try {
      final response = await dio.get(Api.usersAll,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => UserInfo.fromJson(e))
          .toList();
      print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}


class TeacherClassService {
  String token;

  TeacherClassService(this.token);

  final dio = Dio();

  Future<List<TeacherClass>> getTeacherSubInfo() async {
    

    try {
      final response = await dio.get(Api.teacherClass,
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));


      final data = (response.data['data'] as List).map((e) => TeacherClass.fromJson(e)).toList();






      return data;
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}


class TeacherCourseService {
  String token;

  TeacherCourseService(this.token);

  final dio = Dio();

  Future<List<TeacherCourse>> getTeacherCourse() async {
    try {
      final response = await dio.get(Api.teacherCourseClassUrl,
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['data'] as List)
          .map((e) => TeacherCourse.fromJson(e))
          .toList();
      print('course success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}





