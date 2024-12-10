import 'dart:convert';
import 'package:frontend/domain/services/logs.dart';
import 'package:http/http.dart' as http;

class Request{
  final String baseUrl;
  final bool useHttps;

  Request({required this.baseUrl, this.useHttps = true});

  AppLogger logger = AppLogger();

  Uri _createUri(String endpoint, [Map<String, dynamic>? queryParams]) {
    if (useHttps) {
      return Uri.https(baseUrl, endpoint, queryParams);
    } else {
      return Uri.http(baseUrl, endpoint, queryParams);
    }
  }

  Map<String, dynamic> _parseResponse(http.Response response) {
  try {
    final body = jsonDecode(response.body);
    return {
      'statusCode': response.statusCode,
      'headers': response.headers,
      'body': body,
    };
  } catch (e) {
    return {
      'statusCode': response.statusCode,
      'headers': response.headers,
      'body': response.body.isNotEmpty ? response.body : {},
    };
  }
}

  Future<Map<String, dynamic>> get(
  String endpoint, {
  Map<String, dynamic>? params,
  Map<String, String>? headers,
}) async {
  final uri = _createUri(endpoint, params);
  final response = await http.get(uri, headers: headers);

  final parsedResponse = _parseResponse(response);

  // Log response details
  
  // logger.debug("Response: ${parsedResponse['statusCode']} -> ${parsedResponse['body']}");

  return parsedResponse;
}

  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    dynamic body,
  }) async {
    final uri = _createUri(endpoint, params);
    final response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );
    return _parseResponse(response);
  }

  Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    dynamic body,
  }) async {
    final uri = _createUri(endpoint, params);
    final response = await http.put(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );
    return _parseResponse(response);
  }

  Future<Map<String, dynamic>> patch(
    String endpoint, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
    dynamic body,
  }) async {
    final uri = _createUri(endpoint, params);
    final response = await http.patch(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );
    return _parseResponse(response);
  }

  Future<Map<String, dynamic>> delete(
    String endpoint, {
    Map<String, dynamic>? params,
    Map<String, String>? headers,
  }) async {
    final uri = _createUri(endpoint, params);
    final response = await http.delete(uri, headers: headers);
    return _parseResponse(response);
  }
}
