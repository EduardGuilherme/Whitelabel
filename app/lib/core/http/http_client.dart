import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HttpClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://localhost:3333",
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ),
  );

  static final _storage = FlutterSecureStorage();

  static Future<void> setupHeaders() async {
    final token = await _storage.read(key: 'token');

    dio.options.headers = {
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
}
