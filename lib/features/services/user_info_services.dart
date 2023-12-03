





import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../api.dart';
import '../model/user_info_model.dart';




final userInfoProvider = FutureProvider.family(
        (ref, String token) => UserInfoService(token).getUserInfo());



class UserInfoService {
  String token;

  UserInfoService(this.token);

  final dio = Dio();

  Future<UserInfo> getUserInfo() async {
    try {
      final response = await dio.get(Api.userInfoUrl,
          options: Options(
              headers: {HttpHeaders.authorizationHeader: 'token $token'}));
      print(response.data);
      // final data = (response.data['data'] as Map<String, dynamic>)
      //     .values
      //     .map((e) => UserInfo.fromJson(e))
      //     .toList();

      print('success');
      return UserInfo.fromJson(response.data['data']);
    } on DioError catch (err) {
      if (err.response?.data is String) {
        print(err.response);
        throw Exception(err.response?.data);
      } else {
        print(err.response);
        throw Exception('Unable to fetch data');
      }
    }
  }

}