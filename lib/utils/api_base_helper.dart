import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mts_website_admin_panel/utils/routes.dart';
import 'package:mts_website_admin_panel/utils/url_paths.dart';

import '../models/api_response.dart';
import 'errors.dart';
import 'global_variables.dart';

class ApiBaseHelper {

  static final int _timeLimit = 30;
  static final int _timeLimitForMultipart = 40;

  /// Function for HTTP GET method
  static Future<ApiResponse> getMethod({
    required String url,
    bool withBearer = true,
    bool withAuthorization = true,
    Object? body,
    bool redirectToLogin = true,
  }) async {
    try {

      Map<String, String> header = {
        'Content-Type': 'application/json',
        // 'Cookie': 'XSRF-token=${GlobalVariables.token}'
      };
      if (withAuthorization) {
        header.addAll({'Authorization': withBearer
            ? 'Bearer ${GlobalVariables.token}'
            : GlobalVariables.token.toString()});
      }
      Uri urlValue = Uri.parse(Urls.baseURL + url);
      if (kDebugMode) {
        print('*********************** Request ********************************');
        print(urlValue);
        print(header);
      }

      http.Response response = await http.get(
          urlValue,
          headers: header,

      ).timeout(Duration(seconds: _timeLimit), onTimeout: () {
        return Future.error(TimeoutException('Request timed out'));
      });

      if(kDebugMode){
        print(
            '*********************** Response ********************************');
        print(urlValue);
        print(response.body);
      }

      Map<String, dynamic> parsedJSON = jsonDecode(response.body);
      final apiResponse = ApiResponse.fromJson(parsedJSON);

      if(response.statusCode == 401 && redirectToLogin) {

        await GlobalVariables.prefs?.clear();
        Get.offAllNamed(Routes.login, arguments: {'check': false});
        return Errors().showExpiredTokenError();
      } else {
        return apiResponse;
      }
    } on SocketException {
      return Errors().showSocketExceptionError();
    } on TimeoutException {
      return Errors().showTimeOutExceptionError();
    } on http.ClientException {
      return Errors().showClientExceptionError();
    } on FormatException {
      return Errors().showFormatExceptionError();
    } catch (e) {
      return Errors().showGeneralApiError();
    }
  }

  /// Function for HTTP POST method
  static Future<ApiResponse> postMethod({
    required String url,
    required Object body,
    bool withBearer = true,
    bool withAuthorization = true,
    bool redirectToLogin = true,
  }) async {
    try {
      Map<String, String> header = {'Content-Type': 'application/json'};
      if (withAuthorization) {
        header.addAll({'Authorization': withBearer
            ? 'Bearer ${GlobalVariables.token}'
            : GlobalVariables.token.toString()});
      }
      body = jsonEncode(body);

      Uri urlValue = Uri.parse(Urls.baseURL + url);
      if(kDebugMode) {
        print(
            '*********************** Request ********************************');
        print(urlValue);
        print(body);
      }

      http.Response response = await http
          .post(urlValue, headers: header, body: body)
          .timeout(Duration(seconds: _timeLimit), onTimeout: () {
        return Future.error(TimeoutException('Request timed out'));
      });

      if(kDebugMode){
        print(
            '*********************** Response ********************************');
        print(urlValue);
        print(response.body);
      }

      Map<String, dynamic> parsedJSON = jsonDecode(response.body);

      final apiResponse = ApiResponse.fromJson(parsedJSON);

      if(response.statusCode == 401 && redirectToLogin) {
        await GlobalVariables.prefs?.clear();
        Get.offAllNamed(Routes.login, arguments: {'check': false});
        return Errors().showExpiredTokenError();
      } else {
        return apiResponse;
      }
    } on SocketException catch (_) {
      return Errors().showSocketExceptionError();
    } on FormatException catch (_) {
      return Errors().showFormatExceptionError();
    } catch (e) {
      return Errors().showGeneralApiError();
    }
  }

  /// Function for HTTP PUT method
  static Future<ApiResponse> putMethod({
    required String url,
    Object? body,
    bool withBearer = true,
    bool withAuthorization = true,
    bool redirectToLogin = true,
  }) async {
    try {
      Map<String, String> header = {'Content-Type': 'application/json'};
      if (withAuthorization) {
        header.addAll({'Authorization': withBearer
            ? 'Bearer ${GlobalVariables.token}'
            : GlobalVariables.token.toString()});
      }
      if (body != null) {
        body = jsonEncode(body);
      }
      Uri urlValue = Uri.parse(Urls.baseURL + url);
      if(kDebugMode) {
        print(
            '*********************** Request ********************************');
        print(urlValue);
        print(body);
      }

      http.Response response = await http
          .put(urlValue, headers: header, body: body)
          .timeout(Duration(seconds: _timeLimit), onTimeout: () {
        return Future.error(TimeoutException('Request timed out'));
      });

      if(kDebugMode) {
        print(
            '*********************** Response ********************************');
        print(urlValue);
        print(response.body);
      }

      Map<String, dynamic> parsedJSON = jsonDecode(response.body);
      final apiResponse = ApiResponse.fromJson(parsedJSON);

      if(response.statusCode == 401 && redirectToLogin) {
        await GlobalVariables.prefs?.clear();
        Get.offAllNamed(Routes.login, arguments: {'check': false});
        return Errors().showExpiredTokenError();
      } else {
        return apiResponse;
      }
    } on SocketException catch (_) {
      return Errors().showSocketExceptionError();
    } on TimeoutException catch (_) {
      return Errors().showTimeOutExceptionError();
    } on FormatException catch (_) {
      return Errors().showFormatExceptionError();
    } catch (e) {
      return Errors().showGeneralApiError();
    }
  }

  /// Function for HTTP PATCH method
  static Future<ApiResponse> patchMethod({
    required String url,
    Object? body,
    bool withBearer = true,
    bool withAuthorization = true,
  }) async {
    try {
      Map<String, String> header = {'Content-Type': 'application/json'};
      if (withAuthorization) {
        header.addAll({'Authorization': withBearer
            ? 'Bearer ${GlobalVariables.token}'
            : GlobalVariables.token.toString()});
      }
      if (body != null) {
        body = jsonEncode(body);
      }
      Uri urlValue = Uri.parse(Urls.baseURL + url);
      if(kDebugMode){
        print(
            '*********************** Request ********************************');
        print(urlValue);
        print(body);
      }

      http.Response response = await http
          .patch(urlValue, headers: header, body: body)
          .timeout(Duration(seconds: _timeLimit), onTimeout: () {
        return Future.error(TimeoutException('Request timed out'));
      });

      if(kDebugMode){
        print(
            '*********************** Response ********************************');
        print(urlValue);
        print(response.body);
      }

      Map<String, dynamic> parsedJSON = jsonDecode(response.body);
      final apiResponse = ApiResponse.fromJson(parsedJSON);

      if(response.statusCode == 401) {
        await GlobalVariables.prefs?.clear();
        Get.offAllNamed(Routes.login, arguments: {'check': false});
        return Errors().showExpiredTokenError();
      } else {
        return apiResponse;
      }
    } on SocketException catch (_) {
      return Errors().showSocketExceptionError();
    } on TimeoutException catch (_) {
      return Errors().showTimeOutExceptionError();
    } on FormatException catch (_) {
      return Errors().showFormatExceptionError();
    } catch (e) {
      return Errors().showGeneralApiError();
    }
  }

  /// Function for HTTP DELETE method
  static Future<ApiResponse> deleteMethod({
    required String url,
    bool withBearer = true,
    bool withAuthorization = true,
  }) async {
    try {
      Map<String, String> header = {'Content-Type': 'application/json'};
      if (withAuthorization) {
        header.addAll({'Authorization': withBearer
            ? 'Bearer ${GlobalVariables.token}'
            : GlobalVariables.token.toString()});
      }
      Uri urlValue = Uri.parse(Urls.baseURL + url);
      if(kDebugMode){
        print(
            '*********************** Request ********************************');
        print(urlValue);
      }

      http.Response response = await http
          .delete(urlValue, headers: header)
          .timeout(Duration(seconds: _timeLimit), onTimeout: () {
        return Future.error(TimeoutException('Request timed out'));
      });

      if(kDebugMode){
        print(
            '*********************** Response ********************************');
        print(urlValue);
        print(response.body);
      }

      Map<String, dynamic> parsedJSON = jsonDecode(response.body);
      final apiResponse = ApiResponse.fromJson(parsedJSON);

      if(response.statusCode == 401) {
        await GlobalVariables.prefs?.clear();
        Get.offAllNamed(Routes.login, arguments: {'check': false});
        return Errors().showExpiredTokenError();
      } else {
        return apiResponse;
      }
    } on SocketException {
      return Errors().showSocketExceptionError();
    } on TimeoutException {
      return Errors().showGeneralApiError();
    }
  }

  /// Function for HTTP POST method which includes images
  static Future<ApiResponse> postMethodForImage({
    required String url,
    required List<http.MultipartFile> files,
    required Map<String, String> fields,
    bool withBearer = true,
    bool withAuthorization = true,
  }) async {
    try {
      Map<String, String> header = {'Content-Type': 'multipart/form-data'};
      if (withAuthorization) {
        header.addAll({'Authorization': withBearer
            ? 'Bearer ${GlobalVariables.token}'
            : GlobalVariables.token.toString()});
      }
      Uri urlValue = Uri.parse(Urls.baseURL + url);
      if(kDebugMode){
        print(
            '*********************** Request ********************************');
        print(urlValue);
      }

      http.MultipartRequest request = http.MultipartRequest('POST', urlValue);
      request.headers.addAll(header);
      request.fields.addAll(fields);
      request.files.addAll(files);
      http.StreamedResponse response = await request.send().timeout(Duration(seconds: _timeLimitForMultipart), onTimeout: () {
        return Future.error(TimeoutException('Request timed out'));
      });
      Map<String, dynamic> parsedJSON = await jsonDecode(await response.stream.bytesToString());

      if(kDebugMode){
        print(
            '*********************** Response ********************************');
        print(urlValue);
        print(parsedJSON.toString());
      }
      final apiResponse = ApiResponse.fromJson(parsedJSON);

      if(response.statusCode == 401) {
        await GlobalVariables.prefs?.clear();
        Get.offAllNamed(Routes.login, arguments: {'check': false});
        return Errors().showExpiredTokenError();
      } else {
        return apiResponse;
      }
    } on SocketException catch (_) {
      return Errors().showSocketExceptionError();
    } on TimeoutException catch (_) {
      return Errors().showTimeOutExceptionError();
    } on FormatException catch (_) {
      return Errors().showFormatExceptionError();
    } catch (e) {
      return Errors().showGeneralApiError();
    }
  }

  /// Function for HTTP PATCH method which includes images
  static Future<ApiResponse> patchMethodForImage({
    required String url,
    required List<http.MultipartFile> files,
    required Map<String, dynamic> fields,
    bool withBearer = true,
    bool withAuthorization = true,
  }) async {
    try {
      Map<String, String> header = {'Content-Type': 'multipart/form-data'};

      if (withAuthorization) {
        header.addAll({'Authorization': withBearer
            ? 'Bearer ${GlobalVariables.token}'
            : GlobalVariables.token.toString()});
      }
      Uri urlValue = Uri.parse(Urls.baseURL + url);
      if(kDebugMode){
        print(
            '*********************** Request ********************************');
        print(urlValue);
        print(fields);
      }

      http.MultipartRequest request = http.MultipartRequest('PATCH', urlValue);

      request.headers.addAll(header);
      for(var field in fields.entries) {
        request.fields.addAll({field.key: jsonEncode(field.value)});
      }
      request.files.addAll(files);

      http.StreamedResponse response = await request.send().timeout(Duration(seconds: _timeLimitForMultipart), onTimeout: () {
        return Future.error(TimeoutException('Request timed out'));
      });
      Map<String, dynamic> parsedJSON = await jsonDecode(await response.stream.bytesToString());

      if(kDebugMode){
        print(
            '*********************** Response ********************************');
        print(urlValue);
        print(parsedJSON.toString());
      }
      final apiResponse = ApiResponse.fromJson(parsedJSON);

      if(response.statusCode == 401) {
        await GlobalVariables.prefs?.clear();
        Get.offAllNamed(Routes.login, arguments: {'check': false});
        return Errors().showExpiredTokenError();
      } else {
        return apiResponse;
      }
    } on SocketException catch (_) {
      return Errors().showSocketExceptionError();
    } on TimeoutException catch (_) {
      return Errors().showTimeOutExceptionError();
    } on FormatException catch (_) {
      return Errors().showFormatExceptionError();
    } catch (e) {
      return Errors().showGeneralApiError();
    }
  }
}