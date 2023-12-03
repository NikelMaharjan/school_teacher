



import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api.dart';
import '../model/course_class.dart';


final coursePlanList = FutureProvider.family(
        (ref, String token) => CoursePlanService(token).getCoursePlan());

class CoursePlanService{
  String token;

  CoursePlanService(this.token);

  final dio = Dio();

  Future<List<CoursePlan>> getCoursePlan() async {
    try {
      final response = await dio.get(Api.coursePlanUrl,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => CoursePlan.fromJson(e))
          .toList();
      print('plan success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }

  Future<Either<String, dynamic>> addPlan({
    required String duration,
    required String description,
    required String outcome,
    required int course,
  }) async {
    try {
      final response = await dio.post(Api.coursePlanUrl,
          data: {
            "teaching_duration": duration,
            "description": description,
            "expected_outcome": outcome,
            "course": course

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
    required int course,
  }) async {
    try {
      final response = await dio.patch('${Api.editCoursePlanUrl}$id/',
          data: {
            "teaching_duration": duration,
            "description": description,
            "expected_outcome": outcome,
            "course": course

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