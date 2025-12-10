import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';
import '../models/register_request_model.dart';
import '../models/register_response_model.dart';
import '../models/logout_response_model.dart';
import '../../core/config/api_config.dart';
import '../../core/storage/storage_service.dart';

class UnauthenticatedException implements Exception {
  final String message;
  UnauthenticatedException(this.message);
  
  @override
  String toString() => message;
}

class AuthRepository {
  Future<LoginResponseModel> login(LoginRequestModel request) async {
    try {
      final url = Uri.parse(ApiConfig.getFullUrl(ApiConfig.loginEndpoint));
      
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return LoginResponseModel.fromJson(responseData);
      } else {
        final errorMessage = responseData['message'] as String? ?? 
                           'Login failed. Please try again.';
        throw Exception(errorMessage);
      }
    } on http.ClientException {
      throw Exception('Network error. Please check your internet connection.');
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('An unexpected error occurred. Please try again.');
    }
  }

  Future<RegisterResponseModel> register(RegisterRequestModel request) async {
    try {
      final url = Uri.parse(ApiConfig.getFullUrl(ApiConfig.registerEndpoint));
      
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(request.toJson()),
      );

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {
        return RegisterResponseModel.fromJson(responseData);
      } else {
        final errorMessage = responseData['message'] as String? ?? 
                           'Registration failed. Please try again.';
        throw Exception(errorMessage);
      }
    } on http.ClientException {
      throw Exception('Network error. Please check your internet connection.');
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('An unexpected error occurred. Please try again.');
    }
  }

  Future<LogoutResponseModel> logout() async {
    try {
      final url = Uri.parse(ApiConfig.getFullUrl(ApiConfig.logoutEndpoint));
      final authHeader = await StorageService.getAuthHeader();
      
      if (authHeader == null) {
        throw Exception('No authentication token found.');
      }

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': authHeader,
        },
      );

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return LogoutResponseModel.fromJson(responseData);
      } else if (response.statusCode == 401) {
        // Unauthenticated - clear token and throw specific exception
        await StorageService.clearToken();
        throw UnauthenticatedException('Session expired. Please login again.');
      } else {
        final errorMessage = responseData['message'] as String? ?? 
                           'Logout failed. Please try again.';
        throw Exception(errorMessage);
      }
    } on http.ClientException {
      throw Exception('Network error. Please check your internet connection.');
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('An unexpected error occurred. Please try again.');
    }
  }
}

