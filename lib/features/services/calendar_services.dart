import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eschool_teacher/constants/snack_show.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../api.dart';
import '../model/calendar_event.dart';

final eventList = FutureProvider.family(
    (ref, String token) => CalendarService(token).getEvents());

class CalendarService {
  String token;

  CalendarService(this.token);

  final dio = Dio();

  Future<List<CalendarEvent>> getEvents() async {
    try {
      final response = await dio.get(Api.calendarEvent,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));

      final data = (response.data['navigation']['data'] as List)
          .map((e) => CalendarEvent.fromJson(e))
          .toList();
      // print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);

      throw Exception('Unable to fetch data');
    }
  }
}
