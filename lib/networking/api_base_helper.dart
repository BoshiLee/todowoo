import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:todowoo/model/config.dart';

import 'app_exception.dart';

class ApiBaseHelper {
  DefaultHttpClientAdapter get client {
    final DefaultHttpClientAdapter client = DefaultHttpClientAdapter();
    return client;
  }

  static get baseUrl => Config.host;

  Dio get _dio {
    final dio = Dio(
      BaseOptions(
        connectTimeout: 15000,
        receiveTimeout: 15000,
        baseUrl: baseUrl,
      ),
    )
      ..interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 130,
          logPrint: (obj) => debugPrint(obj.toString()),
        ),
      )
      ..httpClientAdapter = client;

    return dio;
  }

  Map<String, dynamic> get _headers {
    Map<String, dynamic> map = {
      HttpHeaders.acceptHeader: ContentType.json.toString(),
      HttpHeaders.contentTypeHeader: ContentType.json.toString(),
    };
    return map;
  }

  Future<dynamic> get(
    String url, {
    Map<String, dynamic> queryParameters = const {},
    ResponseType responseType = ResponseType.json,
  }) async {
    final Options requestOptions = Options(headers: _headers);
    requestOptions.responseType = responseType;
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: requestOptions,
      );
      return _returnResponse(response);
    } on SocketException {
      throw const FetchDataException(
        message: 'No Internet connection',
      );
    } on DioError catch (e) {
      throw dioErrorHandler(
        e,
      );
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> post(
    String url, {
    Map<String, dynamic>? queryParameters,
    dynamic data,
  }) async {
    Map<String, dynamic> headers = _headers;
    try {
      final Response response = await _dio.post(
        url,
        queryParameters: queryParameters,
        data: data,
        options: Options(headers: headers),
      );
      return _returnResponse(response);
    } on SocketException {
      throw const FetchDataException(message: 'No Internet connection');
    } on DioError catch (e) {
      throw dioErrorHandler(
        e,
      );
    } catch (error) {
      rethrow;
    }
  }

  AppException dioErrorHandler(DioError e) {
    switch (e.type) {
      case DioErrorType.connectTimeout:
        return const RequestTimeOutException(
          message: '請求逾時，請至網路穩定的環境中使用',
        );
      case DioErrorType.receiveTimeout:
        return const RequestTimeOutException(
          message: '請求逾時，請至網路穩定的環境中使用',
        );
      case DioErrorType.sendTimeout:
        return const RequestTimeOutException(
          message: '請求逾時，請至網路穩定的環境中使用',
        );
      case DioErrorType.cancel:
        return const FetchDataException(message: '請求取消');
      case DioErrorType.response:
        final response = e.response;
        if (response == null) {
          return BadRequestException(
            message: e.error.toString(),
          );
        }
        return FetchDataException(message: e.error.toString());
      default:
        if (e.response == null) {
          return BadRequestException(message: e.error.toString());
        }
        return FetchDataException(
          message:
              'Error occured while Communication with Server with StatusCode : ${e.response!.statusCode}',
        );
    }
  }

  dynamic _returnResponse(Response response) {
    final dynamic responseJson = response.data;
    return responseJson;
  }
}
