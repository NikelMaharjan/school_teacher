



import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eschool_teacher/features/model/subject_class.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api.dart';

import '../model/class_subject.dart';


final classSubInfo2 = FutureProvider.family(
        (ref, String token) => ClassSubService2(token).getClassSubInfo());


final subPlanList = FutureProvider.family(
        (ref, String token) => SubjectPlanService(token).getSubjectPlan());

class SubjectPlanService{

  String token;

  SubjectPlanService(this.token);

  final dio = Dio();

  Future<List<SubjectPlan>> getSubjectPlan() async {


    try {
      final response = await dio.get(Api.subjectPlanUrl,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));

      final data = (response.data['navigation']['data'] as List).map((e) => SubjectPlan.fromJson(e)).toList();
      return data;
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }

  Future<Either<String, dynamic>> addPlan({
    required String duration,
    required String description,
    required String outcome,
    required int subject,
  }) async {
    try {
      final response = await dio.post(Api.subjectPlanUrl,
          data: {
            "teaching_duration": duration,
            "description": description,
            "expected_outcome": outcome,
            "class_subject": subject

          },
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      return Right(response.data);
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Network error');
    }
  }

  Future<Either<String, dynamic>> editPlan({
    required String duration,
    required String description,
    required String outcome,
    required int id,
    required int subject,
  }) async {
    try {
      final response = await dio.patch('${Api.editSubjectPlanUrl}$id/',
          data: {
            "teaching_duration": duration,
            "description": description,
            "expected_outcome": outcome,
            "class_subject": subject

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


class ClassSubService2 {
  String token;

  ClassSubService2(this.token);

  final dio = Dio();

  Future<List<ClassSubject>> getClassSubInfo() async {
    try {
      final response = await dio.get(Api.classSubjectUrl,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
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



