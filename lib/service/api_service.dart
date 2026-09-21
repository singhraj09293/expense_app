import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final _dio = Dio(
    BaseOptions(
      baseUrl: "http://10.215.29.30:3000",
      // baseUrl: "http://localhost:3000",
    ),
  );

  Future<String> login(String username, String password) async {
    final response = await _dio.post(
      "/auth/login",
      data: {"username": username, "email": username, "password": password},
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', response.data['token']);
    await prefs.setString('username', response.data['username']);
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
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    return response.data['message'];
  }

  Future<List> getExpense() async {
    final prefs = await SharedPreferences.getInstance();
    final tokens = prefs.getString('token');
    print(tokens);
    final response = await _dio.get(
      '/expense',
      options: Options(headers: {'Authorization': tokens}),
    );
    return response.data['expense'];
  }

  Future<String> addExpense(String title, int amount, DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    final tokens = prefs.getString('token');
    final response = await _dio.post(
      '/expense',
      data: {"title": title, "amount": amount, "date": date.toIso8601String()},
      options: Options(headers: {'Authorization': tokens}),
    );
    return response.data['message'];
  }
}
