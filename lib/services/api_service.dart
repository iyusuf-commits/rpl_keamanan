import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../config/app_config.dart';
import '../models/user.dart';
import '../models/post.dart';
import '../utils/logger.dart';

class ApiService {
  // Singleton pattern (Latihan 2)
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  final http.Client _client;
  late final String _baseUrl;

  ApiService._internal() : _client = http.Client() {
    _baseUrl = AppConfig.baseUrl;
  }

  Future<List<User>> getUsers() async {
    try {
      Logger.info('GET /users');
      final response = await _client
          .get(Uri.parse('$_baseUrl/users'), headers: _buildHeaders())
          .timeout(const Duration(seconds: AppConfig.timeoutSeconds));
      Logger.info('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => User.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat data. Status: ${response.statusCode}');
      }
    } on TimeoutException {
      Logger.error('Request timeout /users');
      throw Exception('Request timeout. Periksa koneksi internet Anda.');
    } catch (e) {
      Logger.error('Terjadi kesalahan: $e');
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  Future<User> getUserById(int id) async {
    try {
      Logger.info('GET /users/$id');
      final response = await _client
          .get(Uri.parse('$_baseUrl/users/$id'), headers: _buildHeaders())
          .timeout(const Duration(seconds: AppConfig.timeoutSeconds));
      Logger.info('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return User.fromJson(data);
      } else {
        throw Exception('Gagal memuat data. Status: ${response.statusCode}');
      }
    } catch (e) {
      Logger.error('Terjadi kesalahan: $e');
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  // LATIHAN 1: getPosts
  Future<List<Post>> getPosts() async {
    try {
      Logger.info('GET /posts');
      final response = await _client
          .get(Uri.parse('$_baseUrl/posts'), headers: _buildHeaders())
          .timeout(const Duration(seconds: AppConfig.timeoutSeconds));
      Logger.info('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat data. Status: ${response.statusCode}');
      }
    } catch (e) {
      Logger.error('Terjadi kesalahan: $e');
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  Map<String, String> _buildHeaders() {
    return {
      'Content-Type': 'application/json',
      'X-API-Key': AppConfig.apiKey,
    };
  }

  void dispose() {
    _client.close();
  }
}