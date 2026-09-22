import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';
import 'token_storage.dart';

class ApiException implements Exception {
  final int statusCode;
  final String message;
  ApiException(this.statusCode, this.message);

  @override
  String toString() => message;
}

class ApiClient {
  static Future<Map<String, String>> _headers({bool auth = true}) async {
    final headers = {"Content-Type": "application/json"};
    if (auth) {
      final token = await TokenStorage.read();
      if (token != null) headers["Authorization"] = "Bearer $token";
    }
    return headers;
  }

  static dynamic _handle(http.Response res) {
    if (res.statusCode >= 200 && res.statusCode < 300) {
      if (res.body.isEmpty) return null;
      return jsonDecode(res.body);
    }
    String detail = "Something went wrong";
    try {
      detail = jsonDecode(res.body)["detail"]?.toString() ?? detail;
    } catch (_) {}
    throw ApiException(res.statusCode, detail);
  }

  static Future<dynamic> get(String path, {bool auth = true}) async {
    final res = await http.get(
      Uri.parse("${ApiConfig.baseUrl}$path"),
      headers: await _headers(auth: auth),
    );
    return _handle(res);
  }

  static Future<dynamic> post(String path, {Map<String, dynamic>? body, bool auth = true}) async {
    final res = await http.post(
      Uri.parse("${ApiConfig.baseUrl}$path"),
      headers: await _headers(auth: auth),
      body: body != null ? jsonEncode(body) : null,
    );
    return _handle(res);
  }
}