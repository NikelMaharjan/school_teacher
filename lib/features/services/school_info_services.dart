import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../api.dart';
import '../model/class_subject.dart';
import '../model/school.dart';

final schoolInfo = FutureProvider.family(
    (ref, String token) => SchoolService(token).getSchoolInfo());

final schoolOtherInfo = FutureProvider.family(
        (ref, String token) => SchoolInfoService(token).getSchoolOtherInfo());

final schoolContactInfo = FutureProvider.family(
        (ref, String token) => SchoolContactService(token).getSchoolOtherInfo());

final subjectInfo = FutureProvider.family(
        (ref, String token) => SubjectService(token).getSubject());



class SchoolService {
  String token;

  SchoolService(this.token);

  final dio = Dio();

  Future<List<School>> getSchoolInfo() async {
    try {
      final response = await dio.get(Api.school_college,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => School.fromJson(e))
          .toList();
      print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}

class SchoolInfoService {
  String token;

  SchoolInfoService(this.token);

  final dio = Dio();

  Future<List<SchoolOtherInfo>> getSchoolOtherInfo() async {
    try {
      final response = await dio.get(Api.school_info,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List<dynamic>)
          .map((e) => SchoolOtherInfo.fromJson(e))
          .toList();
      print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}


class SchoolContactService {
  String token;

  SchoolContactService(this.token);

  final dio = Dio();

  Future<List<SchoolContact>> getSchoolOtherInfo() async {
    try {
      final response = await dio.get(Api.school_contact,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => SchoolContact.fromJson(e))
          .toList();
      print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}


class SubjectService {
  String token;

  SubjectService(this.token);

  final dio = Dio();

  Future<List<Subject>> getSubject() async {
    try {
      final response = await dio.get(Api.subjectUrl,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => Subject.fromJson(e))
          .toList();
      print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}

