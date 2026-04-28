import 'dart:async';

import 'package:dio/dio.dart';

import '../auth/token_store.dart';
import '../feedback/appMessenger.dart';
import 'apiException.dart';
import 'apiResult.dart';

typedef JsonMap = Map<String, dynamic>;
typedef JsonParser<T> = T Function(dynamic data);

class ApiClient {
  ApiClient({required this.tokenStore, Dio? dio})
    : dioClient =
          dio ??
          Dio(
            BaseOptions(
              connectTimeout: const Duration(seconds: 15),
              receiveTimeout: const Duration(seconds: 15),
              sendTimeout: const Duration(seconds: 15),
              responseType: ResponseType.json,
            ),
          ) {
    dioClient.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = tokenStore.readToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) {
          handler.next(error);
        },
      ),
    );
  }

  final Dio dioClient;
  final TokenStore tokenStore;

  Future<ApiResult<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    JsonParser<T>? parser,
    Options? options,
    bool showError = true,
  }) {
    return sendRequest(
      () => dioClient.get<dynamic>(path, queryParameters: queryParameters, options: options),
      parser: parser,
      showError: showError,
    );
  }

  Future<ApiResult<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    JsonParser<T>? parser,
    Options? options,
    bool showError = true,
  }) {
    return sendRequest(
      () => dioClient.post<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
      parser: parser,
      showError: showError,
    );
  }

  Future<ApiResult<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    JsonParser<T>? parser,
    Options? options,
    bool showError = true,
  }) {
    return sendRequest(
      () => dioClient.put<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
      parser: parser,
      showError: showError,
    );
  }

  Future<ApiResult<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    JsonParser<T>? parser,
    Options? options,
    bool showError = true,
  }) {
    return sendRequest(
      () => dioClient.delete<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
      parser: parser,
      showError: showError,
    );
  }

  Future<ApiResult<T>> sendRequest<T>(
    Future<Response<dynamic>> Function() caller, {
    JsonParser<T>? parser,
    required bool showError,
  }) async {
    try {
      final response = await caller();
      return normalizeResponse<T>(response.data, parser: parser);
    } on DioException catch (error) {
      final message = resolveDioErrorMessage(error);
      if (showError) {
        AppMessenger.showError(message);
      }
      return ApiResult<T>(
        success: false,
        message: message,
        code: error.response?.statusCode,
        raw: error.response?.data,
      );
    } on ApiException catch (error) {
      if (showError) {
        AppMessenger.showError(error.message);
      }
      return ApiResult<T>(success: false, code: error.code, message: error.message);
    } catch (error) {
      const message = '请求失败，请稍后重试';
      if (showError) {
        AppMessenger.showError(message);
      }
      return ApiResult<T>(success: false, message: message);
    }
  }

  ApiResult<T> normalizeResponse<T>(dynamic body, {JsonParser<T>? parser}) {
    if (body is! JsonMap) {
      final parsed = parser != null ? parser(body) : body as T?;
      return ApiResult<T>(success: true, message: 'success', data: parsed, raw: body);
    }

    final code = readIntValue(body, ['code', 'status', 'statusCode']);
    final success = readSuccessFlag(body, code);
    final message =
        readStringValue(body, ['message', 'msg', 'errorMessage']) ?? (success ? 'success' : '请求失败');
    final payload = body.containsKey('data') ? body['data'] : body;

    if (!success) {
      throw ApiException(code: code, message: message);
    }

    final parsed = parser != null ? parser(payload) : payload as T?;
    return ApiResult<T>(success: true, code: code, message: message, data: parsed, raw: body);
  }

  bool readSuccessFlag(JsonMap body, int? code) {
    final successValue = body['success'];
    if (successValue is bool) {
      return successValue;
    }
    if (code != null) {
      return code == 0 || code == 200;
    }
    return true;
  }

  int? readIntValue(JsonMap body, List<String> keys) {
    for (final key in keys) {
      final value = body[key];
      if (value is int) {
        return value;
      }
      if (value is String) {
        return int.tryParse(value);
      }
    }
    return null;
  }

  String? readStringValue(JsonMap body, List<String> keys) {
    for (final key in keys) {
      final value = body[key];
      if (value is String && value.trim().isNotEmpty) {
        return value;
      }
    }
    return null;
  }

  String resolveDioErrorMessage(DioException error) {
    final responseData = error.response?.data;
    if (responseData is JsonMap) {
      final message = readStringValue(responseData, ['message', 'msg', 'errorMessage']);
      if (message != null) {
        return message;
      }
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return '网络连接超时，请稍后重试';
      case DioExceptionType.badCertificate:
        return '证书校验失败';
      case DioExceptionType.connectionError:
        return '网络连接失败，请检查网络';
      case DioExceptionType.cancel:
        return '请求已取消';
      case DioExceptionType.badResponse:
        return '服务器开小差了，请稍后重试';
      case DioExceptionType.unknown:
        return '请求失败，请稍后重试';
    }
  }
}
