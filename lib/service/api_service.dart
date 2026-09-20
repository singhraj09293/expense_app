import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final _dio = Dio(
    BaseOptions(
      // baseUrl: "http://10.215.29.30:3000"
      baseUrl: "http://localhost:3000",
    ),
  );

  Future<String> login(String username, String password) async {
    final response = await _dio.post(
      "/auth/login",
      data: {"username": username, "password": password},
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', response.data['token']);
    return response.data['token'];
  }

  Future<String> register(
    String username,
    String pas,
    String name,
    String email,
  ) async {
    final response = await _dio.post(
      "/auth/register",
      data: {
        "username": username,
        "password": pas,
        "email": email,
        "name": name,
      },
    );
    return response.data['message'];
  }
}
