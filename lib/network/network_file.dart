//TODO: file for making Api requests

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:practical_task/models/homepage_list_model.dart';
import 'package:practical_task/resources/url_resources.dart';

import '../models/status_model.dart';
import '../resources/string_resources.dart';

class NetworkController {
  static final NetworkController _networkController = NetworkController._internal();
  late Dio _dio;

  factory NetworkController({bool delay = false}) {
    _networkController.prepareRequest();
    return _networkController;
  }

  ///TODO: Instance for NetworkController Class
  static NetworkController get instance => _networkController;

  NetworkController._internal();

  void prepareRequest() {
    BaseOptions dioOptions = BaseOptions(
      baseUrl: URLConstants.baseUrl,
      responseType: ResponseType.json,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
    );

    _dio = Dio(dioOptions);
    String tag = "API call :";
    final mInterceptorsWrapper = InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint("$tag headers ${options.headers.toString()}",
            wrapWidth: 1024);
        debugPrint("$tag ${options.baseUrl.toString() + options.path}",
            wrapWidth: 1024);
        debugPrint("$tag queryParameters ${options.queryParameters.toString()}",
            wrapWidth: 1024);
        debugPrint("$tag ${options.data.toString()}", wrapWidth: 1024);
        return handler.next(options);
      },
      onResponse: (e, handler) {
        debugPrint("Code  ${e.statusCode.toString()}", wrapWidth: 1024);
        debugPrint("Response ${e.toString()}", wrapWidth: 1024);
        return handler.next(e);
      },
      onError: (e, handler) {
        debugPrint("$tag ${e.error.toString()}", wrapWidth: 1024);
        debugPrint("$tag ${e.response.toString()}", wrapWidth: 1024);
        return handler.next(e);
      },
    );
    _dio.interceptors.add(mInterceptorsWrapper);
  }

  ///TODO: Status model for handling errors
  Status _handleError(DioError error) {
    if (error.type == DioErrorType.other &&
        error.error != null &&
        error.error is SocketException) {}

    late Status errorResponse;

    switch (error.type) {
      case DioErrorType.cancel:
        return Status(
          success: false,
          errorCode: 401,
          errorDescription: Strings.somethingWentWrong,
        );
      case DioErrorType.response:
        if (error.response != null && error.response!.data != null) {
          try {
            if (error.response!.data!['error'] != null) {
              if (error.response!.data!['error']['data']['message'] != null) {
                errorResponse = Status(
                  success: false,
                  errorCode: 401,
                  errorDescription: Strings.somethingWentWrong,
                );
              } else {
                errorResponse = Status(
                  success: false,
                  errorCode: 401,
                  errorDescription: Strings.somethingWentWrong,
                );
              }
            } else {
              errorResponse = Status(
                success: false,
                errorCode: 401,
                errorDescription: Strings.somethingWentWrong,
              );
            }
          } catch (e) {
            errorResponse = Status(
              success: false,
              errorCode: 401,
              errorDescription: Strings.somethingWentWrong,
            );
          }
        } else {
          errorResponse = Status(
            success: false,
            errorCode: 401,
            errorDescription: Strings.somethingWentWrong,
          );
        }

        break;
      case DioErrorType.connectTimeout:
        errorResponse = Status(
          success: false,
          errorCode: 401,
          errorDescription: Strings.connectionTimeout,
        );
        break;
      case DioErrorType.receiveTimeout:
        errorResponse = Status(
          success: false,
          errorCode: 401,
          errorDescription: Strings.receiveTimeout,
        );
        break;
      case DioErrorType.sendTimeout:
        errorResponse = Status(
          success: false,
          errorCode: 401,
          errorDescription: Strings.sendTimeout,
        );
        break;
      case DioErrorType.other:
        errorResponse = Status(
          success: false,
          errorCode: 401,
          errorDescription: Strings.somethingWentWrong,
        );
        break;
    }
    return errorResponse;
  }

  Future<HomePageListResponse> getHomeData(
      {required Map<String, dynamic> param}) async {
    try {
      Response response = await _dio.get(
        URLConstants.apiEndpoint,
      );
      if (response.statusCode == 200) {
        return HomePageListResponse.fromJson(response.data);
      } else {
        throw Exception();
      }
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }
}
