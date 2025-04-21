import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../app/data/core/utils/logging/logger.dart';
import '../app/data/models/response_data_model.dart';

import 'auth_service.dart';

class NetworkCaller {
  final int timeoutDuration = 10;

  Future<ResponseData> getRequest(String endpoint, {String? token}) async {
    AppLoggerHelper.info('GET Request: $endpoint');
    try {
      final Response response = await get(
        Uri.parse(endpoint),
        headers: {
          'Authorization': token ?? AuthService.token.toString(),
          'Content-type': 'application/json',
        },
      ).timeout(Duration(seconds: timeoutDuration));
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ResponseData> postRequest(String endpoint,
      {Map<String, dynamic>? body, String? token}) async {
    AppLoggerHelper.info('POST Request: $endpoint');
    AppLoggerHelper.info('Request Body: ${jsonEncode(body)}');

    try {
      final Response response = await post(
        Uri.parse(endpoint),
        headers: {
          'Authorization': token ?? AuthService.token.toString(),
          'Content-type': 'application/json',
        },
        body: jsonEncode(body),
      ).timeout(Duration(seconds: timeoutDuration));
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ResponseData> putRequest(String endpoint,
      {Map<String, dynamic>? body, String? token}) async {
    AppLoggerHelper.info('PUT Request: $endpoint');
    AppLoggerHelper.info('Request Body: ${jsonEncode(body)}');

    try {
      final Response response = await put(
        Uri.parse(endpoint),
        headers: {
          'Authorization': token ?? AuthService.token.toString(),
          'Content-type': 'application/json',
        },
        body: jsonEncode(body),
      ).timeout(Duration(seconds: timeoutDuration));
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ResponseData> deleteRequest(String endpoint, String? token) async {
    AppLoggerHelper.info('DELETE Request: $endpoint');
    try {
      final Response response = await delete(
        Uri.parse(endpoint),
        headers: {
          'Authorization': token ?? AuthService.token.toString(),
          'Content-type': 'application/json',
        },
      ).timeout(Duration(seconds: timeoutDuration));
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  // Handle the response from the server
  Future<ResponseData> _handleResponse(http.Response response) async {
    AppLoggerHelper.info('Response Status: ${response.statusCode}');
    AppLoggerHelper.info('Response Body: ${response.body}');

    try {
      final decodedResponse = jsonDecode(response.body);
      switch (response.statusCode) {
        case 200:
        case 201:
          return ResponseData(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: decodedResponse,
            errorMessage: '',
          );
        case 204:
          return ResponseData(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: null,
            errorMessage: '',
          );
        case 400:
          return ResponseData(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: decodedResponse['error'] ??
                'There was an issue with your request. Please try again.',
            responseData: null,
          );
        case 401:
          await AuthService.logoutUser();
          return ResponseData(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: 'You are not authorized. Please log in to continue.',
            responseData: null,
          );
        case 403:
          return ResponseData(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: 'You do not have permission to access this resource.',
            responseData: null,
          );
        case 404:
          return ResponseData(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: 'The resource you are looking for was not found.',
            responseData: null,
          );
        case 500:
          return ResponseData(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: 'Internal server error. Please try again later.',
            responseData: null,
          );
        default:
          return ResponseData(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: decodedResponse['error'] ??
                'Something went wrong. Please try again.',
            responseData: null,
          );
      }
    } catch (e) {
      return ResponseData(
        isSuccess: false,
        statusCode: response.statusCode,
        errorMessage: 'Failed to process the response. Please try again later.',
        responseData: null,
      );
    }
  }

  // Handle errors during the request process
  ResponseData _handleError(dynamic error) {
    log('Request Error: $error');

    if (error is TimeoutException) {
      return ResponseData(
        isSuccess: false,
        statusCode: 408,
        errorMessage:
        'Request timed out. Please check your internet connection and try again.',
        responseData: null,
      );
    } else if (error is http.ClientException) {
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        errorMessage:
        'Network error occurred. Please check your connection and try again.',
        responseData: null,
      );
    } else {
      return ResponseData(
        isSuccess: false,
        statusCode: 500,
        errorMessage: 'Unexpected error occurred. Please try again later.',
        responseData: null,
      );
    }
  }
}