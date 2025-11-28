import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HttpClient {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://devnology.local:3333", // padrão
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ),
  );

  static final _storage = FlutterSecureStorage();

  static Future<void> setupHeaders() async {
    final token = await _storage.read(key: 'token');
    print( token );
    dio.options.headers = {
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static void changeBaseUrl(String domain) {
    dio.options.baseUrl = "http://$domain:3333";
  }
}