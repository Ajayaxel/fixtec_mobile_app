import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../data/repositories/auth_repository.dart';
import '../storage/storage_service.dart';

/// Helper class for handling API responses and authentication errors
class ApiHelper {
  /// Checks if the response status code indicates unauthenticated (401)
  /// and throws UnauthenticatedException if so
  static Future<void> checkAuthentication(http.Response response) async {
    if (response.statusCode == 401) {
      // Clear token when unauthenticated
      await StorageService.clearToken();
      throw UnauthenticatedException('Session expired. Please login again.');
    }
  }

  /// Helper method to handle API errors consistently
  /// Returns the decoded response data or throws appropriate exception
  static Future<Map<String, dynamic>> handleResponse(http.Response response) async {
    // Check for authentication errors first
    await checkAuthentication(response);

    final responseData = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return responseData;
    } else {
      final errorMessage = responseData['message'] as String? ?? 
                         'Request failed. Please try again.';
      throw Exception(errorMessage);
    }
  }
}

