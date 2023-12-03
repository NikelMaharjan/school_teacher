import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../api.dart';
import '../model/student.dart';

final studentList = FutureProvider.family(
    (ref, String token) => StudentInfoService(token).getStudentInfo());

final studentClassList = FutureProvider.family(
    (ref, String token) => StudentClassService(token).getStudentClassInfo());

class StudentInfoService {
  String token;

  StudentInfoService(this.token);

  final dio = Dio();

  Future<List<Student>> getStudentInfo() async {


    try {
      final response = await dio.get(Api.studentInfo,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));

      print("Response is $response");
      final data = (response.data['navigation']['data'] as List).map((e) => Student.fromJson(e)).toList();
      return data;
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}

class StudentClassService {
  String token;

  StudentClassService(this.token);

  final dio = Dio();

  Future<List<StudentClass>> getStudentClassInfo() async {
    try {
      final response = await dio.get(Api.studentClassUrl,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => StudentClass.fromJson(e))
          .toList();
      print('student class success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      print('error');
      throw Exception('Unable to fetch data');
    }
  }
}
