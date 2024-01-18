import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:eschool_teacher/features/authentication/providers/auth_provider.dart';
import 'package:eschool_teacher/features/model/notification_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart';
import 'api.dart';


final notificationProvider2 = FutureProvider.family.autoDispose<List<NotificationModel>, String>((ref, id) async {
  final token = ref.watch(authProvider);
  final notifyService = NotificationService2(token.user.token, id);
  return await notifyService.getNotificationInfo();
});




class LocalNotificationService{



  static void createanddisplaynotification(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          "High_importance_channel",
          "High_importance_channel",
          importance: Importance.max,
          channelShowBadge: true,
          priority: Priority.high,
        ),
      );

      await flutterLocalNotificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}

final notificationProvider = FutureProvider.family(
        (ref, String token) => NotificationService(token).getNotificationInfo());

class NotificationService {
  String token;

  NotificationService(this.token);

  final dio = Dio();


  Future<Either<String, dynamic>> updateNotification({

    required int id,
  }) async {
    try {
      final response = await dio.patch('${Api.updateNotificationUrl}$id/',
          data: {
            'seen': true,
          },
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      return Right(response.data);
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Network error');
    }
  }



  Future<List<NotificationModel>> getNotificationInfo() async {
    try {
      final response = await dio.get(Api.notificationUrl,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      final data = (response.data['navigation']['data'] as List)
          .map((e) => NotificationModel.fromJson(e))
          .toList();
      // print('success');
      return data;
    } on DioError catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}

class NotificationService2 {
  String token;
  String notification_token;

  NotificationService2(this.token, this.notification_token);

  final dio = Dio();

  Future<List<NotificationModel>> getNotificationInfo() async {


    try {
      final response = await dio.get('${Api.notificationUrl}$notification_token',
          options: Options(headers: {HttpHeaders.authorizationHeader: 'token $token'}));

      if(response.statusCode == 204){
        throw "Nothing at the moment";
      }

      final data = (response.data['navigation']['data'] as List)
          .map((e) => NotificationModel.fromJson(e))
          .toList();
      return data;
    } on DioException catch (err) {
      print(err.response);
      throw Exception('Unable to fetch data');
    }
  }
}