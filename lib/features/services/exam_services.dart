





import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api.dart';
import '../authentication/providers/auth_provider.dart';
import '../model/exam_model.dart';


final examList = FutureProvider.family((ref, String token) => ExamService(token).getExamInfo());
final examClassList = FutureProvider.family((ref, String token) => ExamService(token).getClassInfo());
final examRoutine = FutureProvider.family((ref, String token) => ExamService(token).getRoutineInfo());


final classWiseExamProvider = FutureProvider.family<List<ExamRoutine>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final classExam = ClassWiseExamRoutineService(token.user.token, id);
  return await classExam.getExamClassRoutine();
});


class ExamService {
  String token;

  ExamService(this.token);

  final dio = Dio();


  Future<List<ExamDetail>> getExamInfo() async {
    try {
      final response = await dio.get(Api.examDetailUrl,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => ExamDetail.fromJson(e))
          .toList();
      print('exam success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }

  Future<List<ExamClass>> getClassInfo() async {
    try {
      final response = await dio.get(Api.examClassDetailUrl,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => ExamClass.fromJson(e))
          .toList();
      print('exam success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }

  Future<List<ExamRoutine>> getRoutineInfo() async {
    try {
      final response = await dio.get(Api.examRoutineUrl,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => ExamRoutine.fromJson(e))
          .toList();
      print('exam success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }


}

class ClassWiseExamRoutineService {
  String token;
  int id;

  ClassWiseExamRoutineService(this.token, this.id);

  final dio = Dio();

  Future<List<ExamRoutine>> getExamClassRoutine() async {
    try {
      final response = await dio.get('${Api.classExamRoutineUrl}$id',
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => ExamRoutine.fromJson(e))
          .toList();
      print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}

