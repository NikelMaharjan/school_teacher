import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eschool_teacher/constants/snack_show.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../api.dart';
import '../model/calendar_event.dart';
import '../model/routine.dart';

final routineList = FutureProvider.family(
        (ref, String token) => RoutineService(token).getRoutine());

class RoutineService {
  String token;

  RoutineService(this.token);

  final dio = Dio();

  Future<List<RoutineData>> getRoutine() async {
    try {
      final response = await dio.get(Api.routineUrl,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));

      final data = (response.data['navigation']['data'] as List)
          .map((e) => RoutineData.fromJson(e))
          .toList();
      // print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);

      throw Exception('Unable to fetch data');
    }
  }
}
