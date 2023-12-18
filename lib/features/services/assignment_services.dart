

import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eschool_teacher/features/model/assignment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../api.dart';
import '../authentication/providers/auth_provider.dart';

final assignmentList = FutureProvider.family(
        (ref, String token) => AssignmentService(token).getAssignment());
final assignmentStatusList = FutureProvider.family(
        (ref, String token) => AssignmentService(token).getAssignmentStatus());
final studentAssignmentProvider = FutureProvider.family(
        (ref, String token) => StudentAssignmentService(token).getStudents());

final assignmentDetailProvider = FutureProvider.family.autoDispose<List<Assignment>, int>((ref, id) async {
  final token = ref.watch(authProvider);
  final assignmentDetail = AssignmentDetail(token.user.token, id);
  return await assignmentDetail.getAssignmentDetail();
});




class AssignmentService {
  String token;

  AssignmentService(this.token);

  final dio = Dio();


  Future<Either<String, dynamic>> addAssignment({

    required String title,
    required String description,
    required bool hasDeadline,
    String? deadline,
    String? link,
    XFile? image,
    required String type,
    required int subject
  }) async {
    try {
      final formData = FormData.fromMap({
        'title': title,
        'description': description,
        'image_file': image != null ? await MultipartFile.fromFile(image.path):null,
        'class_subject':subject,
        'assignment_type':type,
        'link':link,
        'has_deadline':hasDeadline,
        'deadline':deadline
      });
      final response = await dio.post(
          Api.assignmentUrl,
          data: formData,options: Options(
          headers: {HttpHeaders.authorizationHeader: 'token $token'}));

      return Right(response.data);
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Dio error: ${err.message}');
    } on SocketException catch (err) {
      print(err);
      throw Exception('Socket error: ${err.message}');
    } on TimeoutException catch (err) {
      print(err);
      throw Exception('Request timed out: ${err.message}');
    } catch (err) {
      print(err);
      throw Exception('Unknown error occurred');
    }}




  Future<Either<String, dynamic>> editAssignment({
    required int id,
    required String title,
    required String description,
    required bool hasDeadline,
    String? deadline,
    String? link,
    XFile? image,
    required String type,
    required int subject
  }) async {
    try {

      if(image == null) {
        final formData = FormData.fromMap({
          'title': title,
          'description': description,
          'class_subject':subject,
          'assignment_type':type,
          'link':link,
          'has_deadline':hasDeadline,
          'deadline':deadline
        });
        final response = await dio.patch(
            '${Api.editAssignmentUrl}$id/',
            data: formData,options: Options(
            headers: {HttpHeaders.authorizationHeader: 'token $token'}));
          return Right(response.data);


      }

      else{
        final formData = FormData.fromMap({
          'title': title,
          'description': description,
          'image_file': await MultipartFile.fromFile(image.path),
          'class_subject':subject,
          'assignment_type':type,
          'link':link,
          'has_deadline':hasDeadline,
          'deadline':deadline
        });
        final response = await dio.patch(
            '${Api.editAssignmentUrl}$id/',
            data: formData,options: Options(
            headers: {HttpHeaders.authorizationHeader: 'token $token'}));
        return Right(response.data);


      }


    } on DioException catch (err) {
      print(err.response);
      throw Exception('Dio error: ${err.message}');
    } on SocketException catch (err) {
      print(err);
      throw Exception('Socket error: ${err.message}');
    } on TimeoutException catch (err) {
      print(err);
      throw Exception('Request timed out: ${err.message}');
    } catch (err) {
      print(err);
      throw Exception('Unknown error occurred');
    }}



  Future<List<Assignment>> getAssignment() async {
    try {
      final response = await dio.get(Api.assignmentUrl,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => Assignment.fromJson(e))
          .toList();
      // print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }


  Future<Either<String, bool>> delAssignment({
    required int id,
  }) async {
    try {
      final response = await dio.delete(
        '${Api.editAssignmentUrl}$id/',
        options: Options(
          headers: {HttpHeaders.authorizationHeader: 'token $token'},
        ),
      );

      return Right(true);
    } on DioError catch (err) {
      // print(err.response);
      throw Exception('Unable to fetch data');
    }
  }

  Future<List<StudentAssignmentStatus>> getAssignmentStatus() async {
    try {
      final response = await dio.get(Api.assignmentStatus,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));

      if(response.statusCode == 204) {
        return [

        ];
      }
      final data = (response.data['navigation']['data'] as List)
          .map((e) => StudentAssignmentStatus.fromJson(e))
          .toList();
      return data;
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }

  Future<Either<String, dynamic>> addStatus({

    required String remarks,
    required String status,
    required bool notifications,
    required int studentAssignment
  }) async {
    try {
      final response = await dio.post(Api.assignmentStatus,
          data: {
            'status':status,
            'remarks':remarks,
            'send_notification':notifications,
            'student_assignment':studentAssignment

          },
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      return Right(response.data);
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Network error');
    }
  }

  Future<Either<String, dynamic>> editStatus({
    required int id,
    required String remarks,
    required String status,
    required bool notifications,
    required int studentAssignment
  }) async {
    try {
      final response = await dio.patch('${Api.editAssignmentStatus}$id/',
          data: {
            'status':status,
            'remarks':remarks,
            'send_notification':notifications,
            'student_assignment':studentAssignment

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

class StudentAssignmentService {
  String token;


  StudentAssignmentService(this.token);

  final dio = Dio();

  Future<List<StudentAssignment>> getStudents() async {
    try {
      final response = await dio.get('${Api.studentAssignmentUrl}',
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => StudentAssignment.fromJson(e))
          .toList();
      print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }





}



class AssignmentDetail {
  String token;
  int id;

  AssignmentDetail(this.token, this.id);

  final dio = Dio();

  Future<List<Assignment>> getAssignmentDetail() async {
    try {
      final response = await dio.get('${Api.assignmentDetailUrl}$id',
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => Assignment.fromJson(e))
          .toList();
      print('success');
      return data;
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}

