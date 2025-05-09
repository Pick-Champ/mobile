import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pick_champ/core/const/app_env.dart';
import 'package:pick_champ/core/const/enums/end_point.dart';
import 'package:pick_champ/generated/locale_keys.g.dart';

class NetworkManager {
  NetworkManager._() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppEnv.baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );
  }

  static late final Dio _dio;

  static final instance = NetworkManager._();

  Future<Map<String, dynamic>?> baseRequest(
    EndPointEnums endPoint, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.request<Map<String, dynamic>>(
        '${AppEnv.baseUrl}${endPoint.value}',
        data: data,
        options: Options(method: 'post'),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        debugPrint(LocaleKeys.error.tr() + response.data.toString());
        return null;
      }
    } on DioException catch (e) {
      debugPrint('Dio error: ${e.message}');
      if (e.response != null) {
        debugPrint('Dio error response data: ${e.response?.data}');
      }
      return null;
    }
  }

  Future<Map<String, dynamic>?> formDataPost(
    dynamic endPointOrUrl, {
    FormData? body,
    ResponseType responseType = ResponseType.json,
    Map<String, dynamic>? queryParameters,
    void Function(int, int)? onSendProgress,
  }) async {
    try {
      final url =
          endPointOrUrl is EndPointEnums
              ? '${AppEnv.baseUrl}${endPointOrUrl.value}'
              : endPointOrUrl.toString();

      final response = await _dio.post<Map<String, dynamic>>(
        url,
        data: body,
        queryParameters: queryParameters,
        options: Options(responseType: responseType),
        onSendProgress: onSendProgress,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        debugPrint(LocaleKeys.error.tr() + response.data.toString());
        return null;
      }
    } on DioException catch (e) {
      debugPrint('Dio error: ${e.message}');
      if (e.response != null) {
        debugPrint('Dio error response data: ${e.response?.data}');
      }
      return null;
    }
  }
}
