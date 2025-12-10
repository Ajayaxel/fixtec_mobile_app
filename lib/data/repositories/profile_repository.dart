import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/profile_response_model.dart';
import '../../core/config/api_config.dart';
import '../../core/storage/storage_service.dart';
import 'auth_repository.dart';

class ProfileRepository {
  Future<ProfileResponseModel> getProfile() async {
    try {
      final url = Uri.parse(ApiConfig.getFullUrl(ApiConfig.profileEndpoint));
      
      final authHeader = await StorageService.getAuthHeader();
      if (authHeader == null) {
        throw Exception('No authentication token found. Please login again.');
      }

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': authHeader,
        },
      );

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final profileResponse = ProfileResponseModel.fromJson(responseData);
        
        // Save customer data to storage
        await StorageService.saveCustomer(profileResponse.data.customer);
        
        return profileResponse;
      } else if (response.statusCode == 401) {
        await StorageService.clearToken();
        throw UnauthenticatedException('Session expired. Please login again.');
      } else {
        final errorMessage = responseData['message'] as String? ?? 
                           'Failed to fetch profile. Please try again.';
        throw Exception(errorMessage);
      }
    } on http.ClientException {
      throw Exception('Network error. Please check your internet connection.');
    } on UnauthenticatedException {
      rethrow;
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('An unexpected error occurred. Please try again.');
    }
  }
}

