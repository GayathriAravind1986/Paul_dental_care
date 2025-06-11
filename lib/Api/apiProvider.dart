import 'dart:convert';
// import 'package:simple/ModelClass/Home/getHomeModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:simple/Bloc/Response/errorResponse.dart';
import 'package:simple/ModelClass/Awareness/getAwarenessModel.dart';
import 'package:simple/ModelClass/Contact/getContactModel.dart';
import 'package:simple/ModelClass/Events/getEventModel.dart';
import 'package:simple/ModelClass/Home/getHomeModel.dart';
import 'package:simple/Reusable/constant.dart';


/// All API Integration in ApiProvider
class ApiProvider {
  late Dio _dio;

  /// dio use ApiProvider
  ApiProvider() {
    final options = BaseOptions(
        connectTimeout: const Duration(milliseconds: 150000),
        receiveTimeout: const Duration(milliseconds: 100000));
    _dio = Dio(options);
  }

  /// Contact page API Integration
  Future<GetContactModel> getContactAPI() async {
    try {
      var dio = Dio();
      var response = await dio.request(
        '${Constants.baseUrl}contact',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        debugPrint("API Response: ${json.encode(response.data)}");
        GetContactModel getContactResponse =
            GetContactModel.fromJson(response.data);
        return getContactResponse;
      } else {
        debugPrint(
            "ErrorAPIResponse: ${response.statusCode} - ${response.statusMessage}");
        return GetContactModel()
          ..errorResponse =
              ErrorResponse(message: "Error: ${response.statusCode}");
      }
    } catch (error) {
      debugPrint("ErrorCatch: $error");
      GetContactModel getContactResponse = GetContactModel();
      getContactResponse.errorResponse = handleError(error);
      return getContactResponse;
    }
  }

  /// Awareness page API Integration
  Future<GetAwarenessModel> getAwarenessAPI() async {
    try {
      var dio = Dio();
      var response = await dio.request(
        '${Constants.baseUrl}awareness',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        debugPrint("API Response: ${json.encode(response.data)}");
        GetAwarenessModel getAwarenessModel =
        GetAwarenessModel.fromJson(response.data);
        return getAwarenessModel;
      } else {
        debugPrint(
            "ErrorAPIResponse: ${response.statusCode} - ${response.statusMessage}");
        return GetAwarenessModel()
          ..errorResponse =
          ErrorResponse(message: "Error: ${response.statusCode}");
      }
    } catch (error) {
      debugPrint("ErrorCatch: $error");
      GetAwarenessModel getAwarenessResponse = GetAwarenessModel();
      getAwarenessResponse.errorResponse = handleError(error);
      return getAwarenessResponse;
    }
  }

  /// Home page API Integration
  Future<GetHomeModel> getHomeAPI() async {
    try {
      var dio = Dio();
      var response = await dio.request(
        '${Constants.baseUrl}home',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        debugPrint("API Response: ${json.encode(response.data)}");
        GetHomeModel getHomeModel = GetHomeModel.fromJson(response.data);
        return getHomeModel;
      } else {
        debugPrint(
            "ErrorAPIResponse: ${response.statusCode} - ${response.statusMessage}");
        return GetHomeModel()
          ..errorResponse =
          ErrorResponse(message: "Error: ${response.statusCode}");
      }
    } catch (error) {
      debugPrint("ErrorCatch: $error");
      GetHomeModel getHomeResponse = GetHomeModel();
      getHomeResponse.errorResponse = handleError(error);
      return getHomeResponse;
    }
  }

  /// Event page API Integration
  Future<GetEventModel> getEventAPI() async {
    try {
      var dio = Dio();
      var response = await dio.request(
        '${Constants.baseUrl}events',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        debugPrint("API Response: ${json.encode(response.data)}");
        GetEventModel getEventResponse = GetEventModel.fromJson(response.data);
        return getEventResponse;
      } else {
        return GetEventModel()
          ..errorResponse =
              ErrorResponse(message: "Error: ${response.statusCode}");
      }
    } catch (error) {
      debugPrint("ErrorCatch: $error");
      GetEventModel getEventResponse = GetEventModel();
      getEventResponse.errorResponse = handleError(error);
      return getEventResponse;
    }
  }



  /// handle Error Response
  ErrorResponse handleError(Object error) {
    ErrorResponse errorResponse = ErrorResponse();
    Errors errorDescription = Errors();

    if (error is DioException) {
      DioException dioException = error;

      switch (dioException.type) {
        case DioExceptionType.cancel:
          errorDescription.code = "0";
          errorDescription.message = "Request Cancelled";
          break;
        case DioExceptionType.connectionTimeout:
          errorDescription.code = "522";
          errorDescription.message = "Connection Timeout";
          break;
        case DioExceptionType.sendTimeout:
          errorDescription.code = "408";
          errorDescription.message = "Send Timeout";
          break;
        case DioExceptionType.receiveTimeout:
          errorDescription.code = "408";
          errorDescription.message = "Receive Timeout";
          break;
        case DioExceptionType.badResponse:
          if (error.response != null) {
            errorDescription.code = error.response!.statusCode!.toString();
            errorDescription.message = error.response!.statusCode == 500
                ? "Internet Server Error"
                : error.response!.data["errors"][0]["message"];
          } else {
            errorDescription.code = "500";
            errorDescription.message = "Internet Server Error";
          }
          break;
        case DioExceptionType.unknown:
          errorDescription.code = "500";
          errorDescription.message = "Internet Server Error";
          break;
        case DioExceptionType.badCertificate:
          errorDescription.code = "495";
          errorDescription.message = "Bad Request";
          break;
        case DioExceptionType.connectionError:
          errorDescription.code = "500";
          errorDescription.message = "Internet Server Error";
          break;
      }
    }
    errorResponse.errors = [];
    errorResponse.errors!.add(errorDescription);
    return errorResponse;
  }
}

