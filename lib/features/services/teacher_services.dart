// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../../api.dart';
// import '../model/school.dart';
//
// final teacherSubjects = FutureProvider.family(
//     (ref, String token) => TeacherSubService(token).getTeacherInfo());
//
// class TeacherSubService {
//   String token;
//
//   TeacherSubService(this.token);
//
//   final dio = Dio();
//
//   Future<List<TeacherSubject>> getTeacherInfo() async {
//     try {
//       final response = await dio.get(Api.teacherSubjectUrl,
//           options: Options(
//               headers: {HttpHeaders.authorizationHeader: 'token $token'}));
//       final data = (response.data['navigation']['data'] as List)
//           .map((e) => TeacherSubject.fromJson(e))
//           .toList();
//       print('success');
//       return data;
//     } on DioError catch (err) {
//       print(err.response);
//       throw Exception('Unable to fetch data');
//     }
//   }
// }
