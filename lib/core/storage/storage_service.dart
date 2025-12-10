import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/customer_model.dart';

class StorageService {
  static const String _tokenKey = 'auth_token';
  static const String _tokenTypeKey = 'token_type';
  static const String _customerKey = 'customer_data';
  static const String _onboardingCompletedKey = 'onboarding_completed';

  static Future<void> saveToken(String token, String tokenType) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_tokenTypeKey, tokenType);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<String?> getTokenType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenTypeKey);
  }

  static Future<String?> getAuthHeader() async {
    final token = await getToken();
    final tokenType = await getTokenType();
    if (token != null && tokenType != null) {
      return '$tokenType $token';
    }
    return null;
  }

  static Future<void> saveCustomer(CustomerModel customer) async {
    final prefs = await SharedPreferences.getInstance();
    final customerJson = jsonEncode(customer.toJson());
    await prefs.setString(_customerKey, customerJson);
  }

  static Future<CustomerModel?> getCustomer() async {
    final prefs = await SharedPreferences.getInstance();
    final customerJson = prefs.getString(_customerKey);
    if (customerJson != null) {
      try {
        final customerMap = jsonDecode(customerJson) as Map<String, dynamic>;
        return CustomerModel.fromJson(customerMap);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_tokenTypeKey);
    await prefs.remove(_customerKey);
  }

  static Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  static Future<void> setOnboardingCompleted(bool completed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompletedKey, completed);
  }

  static Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingCompletedKey) ?? false;
  }
}

