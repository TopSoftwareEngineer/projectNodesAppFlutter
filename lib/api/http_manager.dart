import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:projectx/utils/globals.dart';
import 'package:projectx/utils/shared_preferences_utils.dart';

Map<String, dynamic> dioErrorHandle(DioError error) {
  if (kDebugMode) {
    print('DIO ERROR: $error');
  }
  switch (error.type) {
    case DioErrorType.response:
      return error.response?.data;
    case DioErrorType.sendTimeout:
    case DioErrorType.receiveTimeout:
      return {"success": false, "code": "request_time_out"};

    default:
      return {"success": false, "code": "connect_to_server_fail"};
  }
}

class HTTPManager {
  BaseOptions baseOptions = BaseOptions(
    baseUrl: Globals.urlBase,
  );

  ///Post method
  Future<dynamic> post({
    required String url,
    Map<String, dynamic>? data,
    bool authToken = false,
  }) async {
    if (kDebugMode) {
      print('POST REQUEST: $url');
      print('PARAMS: $data');
    }
    Dio dio = Dio(baseOptions);
    try {
      final response = await dio.post(url, data: data, options: generateOptions(authToken));
      if (kDebugMode) {
        print('----------- API response -----------');
        print(response);
      }
      return response.data;
    } on DioError catch (error) {
      return dioErrorHandle(error);
    }
  }

  ///Get method
  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? params,
    bool authToken = false,
  }) async {
    if (kDebugMode) {
      print('GET REQUEST: $url');
      print('PARAMS: $params');
    }
    Dio dio = Dio(baseOptions);
    try {
      final response = await dio.get(url, queryParameters: params, options: generateOptions(authToken));
      if (kDebugMode) {
        print('----------- API response -----------');
        print(response);
      }
      return response.data;
    } on DioError catch (error) {
      return dioErrorHandle(error);
    }
  }

  Options generateOptions(bool authToken) {
    Options options = Options();
    if (authToken) {
      String? token = SharedPreferencesUtil.getString("token");
      if (token != null) {
        Map<String, String> headers = {
          'Authorization': 'bearer $token',
        };
        options.headers = headers;
      }
    }
    return options;
  }

  factory HTTPManager() {
    return HTTPManager._internal();
  }

  HTTPManager._internal();
}

HTTPManager httpManager = HTTPManager();
