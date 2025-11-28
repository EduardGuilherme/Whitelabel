import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/http/http_client.dart';

class AuthService extends ChangeNotifier {
  final _storage = FlutterSecureStorage();
  String? currentDomain;

  Future<bool> login(String email, String password, String domain) async {
    try {
      currentDomain = domain;

      final response = await HttpClient.dio.post("/auth/login", data: {
        "email": email,
        "password": password,
      });

      final token = response.data["token"];
      await _storage.write(key: 'token', value: token);

      await HttpClient.setupHeaders();

      notifyListeners();
      return true;

    } catch (e) {
      debugPrint("Login error: $e");
      return false;
    }
  }
}