import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../api.dart';
import '../authentication/providers/auth_provider.dart';
import '../model/notice.dart';

final noticeList = FutureProvider.family(
    (ref, String token) => NoticeService(token).getNotice());

final classNoticeProvider2 = FutureProvider.family<List<ClassNotice>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final classNotice = ClassNoticeService2(token.user.token, id);
  return await classNotice.getClassNotice();
});

final classNoticeList = FutureProvider.family(
    (ref, String token) => ClassNoticeService(token).getClassNotice());

final subNoticeList = FutureProvider.family(
    (ref, String token) => SubjectNoticeService(token).getSubjectNotice());


class ClassNoticeService2 {
  String token;
  int id;

  ClassNoticeService2(this.token, this.id);

  final dio = Dio();

  Future<List<ClassNotice>> getClassNotice() async {


    try {
      final response = await dio.get('${Api.classNotices}$id',
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));

      if(response.statusCode == 204){
        return [

          throw "No Class Notice at the moment"

        ];
      }


      final data = (response.data['navigation']['data'] as List).map((e) => ClassNotice.fromJson(e)).toList();
      return data;
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}


class NoticeService {
  String token;

  NoticeService(this.token);

  final dio = Dio();

  Future<Either<String, dynamic>> addNotice({
    required String title,
    required String description,
    String? image,
    required bool for_all_class,
    required bool notification,
    required int added_by,

    required int notice_type
  }) async {
    try {
      final response = await dio.post(Api.notices,
          data: {
            'title': title,
            'description': description,

            'image': image ?? null,
            'for_all_class':for_all_class,
            'send_notification':notification,
            'added_by':added_by,
            'notice_type':notice_type

          },
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      return Right(response.data);
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Network error');
    }
  }

  Future<Either<String, dynamic>> updateNotice({
    required String title,
    required String description,
    String? image,
    required bool for_all_class,
    required bool notification,
    required int added_by,
    required int id,
    required int notice_type
  }) async {
    try {
      final response = await dio.patch('${Api.editNotices}$id/',
          data: {
            'title': title,
            'description': description,

            'image': image ?? null,
            'for_all_class':for_all_class,
            'send_notification':notification,
            'added_by':added_by,
            'notice_type':notice_type

          },
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      return Right(true);
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Network error');
    }
  }


  Future<List<NoticeData>> getNotice() async {
    try {
      final box = Hive.box<String>('user');
      final response = await dio.get(Api.notices,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => NoticeData.fromJson(e))
          .toList();
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}


class ClassNoticeService {
  String token;

  ClassNoticeService(this.token);

  final dio = Dio();

  Future<Either<String, dynamic>> addClassNotice({

    required int classSection,
    required int notice
  }) async {
    try {
      final response = await dio.post(Api.classNotices,
          data: {
            'class_section': classSection,
            'notice': notice,


          },
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      return Right(response.data);
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Network error');
    }
  }



  Future<List<ClassNotice>> getClassNotice() async {
    try {

      final response = await dio.get(Api.classNotices,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => ClassNotice.fromJson(e))
          .toList();
      // print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }

  Future<Either<String, bool>> delClassNotice({
    required int id,
  }) async {
    try {
      final response = await dio.delete(
        '${Api.editClassNotices}$id/',
        options: Options(
          headers: {HttpHeaders.authorizationHeader: 'token $token'},
        ),
      );

      return Right(true);
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }


}

class SubjectNoticeService {
  String token;

  SubjectNoticeService(this.token);

  final dio = Dio();

  Future<Either<String, dynamic>> addSubNotice({
    required String title,
    required String message,

    required int class_subject,
  }) async {
    try {
      final response = await dio.post(Api.subNotices,
          data: {
            'title': title,
            'message': message,

            'class_subject': class_subject
          },
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      return Right(response.data);
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Network error');
    }
  }


  Future<List<SubjectNotice>> getSubjectNotice() async {
    try {
      final box = Hive.box<String>('user');
      final response = await dio.get(Api.subNotices,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => SubjectNotice.fromJson(e))
          .toList();
      // print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }

  Future<Either<String, bool>> delSubNotice({
    required int id,
  }) async {
    try {
      final response = await dio.delete(
        '${Api.editSubNotices}$id/',
        options: Options(
          headers: {HttpHeaders.authorizationHeader: 'token $token'},
        ),
      );

      return Right(true);
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }


  Future<Either<String, bool>> updateSubNotice({
    required String title,
    required String message,
    required int id,
    required int class_subject

  }) async {
    try {
      print('${Api.editSubNotices}$id/');
      final response =  await dio.patch('${Api.editSubNotices}$id/', data: {
        'title': title,
        'message': message,
        'class_subject': class_subject
      }, options: Options(
        headers: {HttpHeaders.authorizationHeader: 'token $token'},
      ),
      );

      print(response);
      return Right(true);
    } on DioError catch (err) {
      throw Exception(err.message);
    }
  }


}
