






import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eschool_teacher/api.dart';
import 'package:eschool_teacher/features/authentication/providers/auth_provider.dart';

import 'package:eschool_teacher/features/model/teacher_course.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/class_subject.dart';
import '../model/teacher_features.dart';




final classSecSubjectProvider = FutureProvider.family<List<ClassSecSubject>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final classSecSubjectService = ClassSecSubjectService(token.user.token, id);
  return await classSecSubjectService.getClassSubjectInfo();
});


final classWiseStudentProvider = FutureProvider.family<List<ClassWiseStudent>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final classWiseStudent = ClassWiseStudentService(token.user.token, id);
  return await classWiseStudent.getStudents();
});

final teacherClassCourseProvider = FutureProvider.family<List<TeacherClassCourse>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final classCourse = TeacherClassCourseService(token.user.token, id);
  return await classCourse.getCourses();
});

final teacherRoutineProvider = FutureProvider.family<List<TeacherRoutine>, String>((ref, day) async {
  final token = ref.watch(authProvider);
  final classCourse = TeacherRoutineService(token.user.token, day);
  return await classCourse.getRoutine();
});


final secWiseSubjectProvider = FutureProvider.family<List<ClassSubject>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final SecWiseSubject = SecWiseSubjectService(token.user.token, id);
  return await SecWiseSubject.getSecWiseSubjectInfo();
});



class ClassSecSubjectService {
  String token;
  int id;

  ClassSecSubjectService(this.token, this.id);

  final dio = Dio();

  Future<List<ClassSecSubject>> getClassSubjectInfo() async {


    print("ID IS $id");




    try {
      final response = await dio.get('${Api.classSecSubUrl}$id/',
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['data'] as List).map((e) => ClassSecSubject.fromJson(e)).toList();
      return data;
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}


class ClassWiseStudentService {
  String token;
  int id;

  ClassWiseStudentService(this.token, this.id);

  final dio = Dio();

  Future<List<ClassWiseStudent>> getStudents() async {



    try {
      final response = await dio.get('${Api.classWiseStudentUrl}$id',
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));

      if(response.statusCode == 204) {

        throw "No Students at the moment";
      }


      final data = (response.data['data'] as List).map((e) => ClassWiseStudent.fromJson(e)).toList();


      return data;
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}


class TeacherClassCourseService{
  String token;
  int id;

  TeacherClassCourseService(this.token, this.id);

  final dio = Dio();

  Future<List<TeacherClassCourse>> getCourses() async {
    try {
      final response = await dio.get('${Api.teacherCourseUrl}$id/',
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['data'] as List)
          .map((e) => TeacherClassCourse.fromJson(e))
          .toList();
      print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}


class TeacherRoutineService{
  String token;
  String day;


  TeacherRoutineService(this.token,this.day);

  final dio = Dio();

  Future<List<TeacherRoutine>> getRoutine() async {


    try {
      // final response = await dio.get('${Api.teacherRoutine}$day/', options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));

      final response = await dio.get('${Api.teacherRoutine1}', options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      


      final data = (response.data['data'] as List).map((e) => TeacherRoutine.fromJson(e)).toList();
      return data;
    } on DioException catch (err) {
      throw Exception('Unable to fetch data');
    }
  }
}

class SecWiseSubjectService {
  String token;
  int id;

  SecWiseSubjectService(this.token, this.id);

  final dio = Dio();

  Future<List<ClassSubject>> getSecWiseSubjectInfo() async {
    try {
      final response = await dio.get('${Api.sectionSubjectUrl}$id',
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => ClassSubject.fromJson(e))
          .toList();
      print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}







