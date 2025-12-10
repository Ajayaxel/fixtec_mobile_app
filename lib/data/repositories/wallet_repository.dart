import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/wallet_deposit_request_model.dart';
import '../models/wallet_deposit_response_model.dart';
import '../models/wallet_balance_response_model.dart';
import '../../core/config/api_config.dart';
import '../../core/storage/storage_service.dart';
import 'auth_repository.dart';

class WalletRepository {
  Future<WalletDepositResponseModel> deposit(WalletDepositRequestModel request) async {
    try {
      print('🔵 [WalletRepository] Starting wallet deposit request');
      print('🔵 [WalletRepository] Amount: ${request.amount}');
      
      final url = Uri.parse(ApiConfig.getFullUrl(ApiConfig.walletDepositEndpoint));
      print('🔵 [WalletRepository] URL: $url');
      
      final authHeader = await StorageService.getAuthHeader();
      if (authHeader == null) {
        print('🔴 [WalletRepository] No authentication token found');
        throw Exception('No authentication token found. Please login again.');
      }
      
      print('🔵 [WalletRepository] Request body: ${jsonEncode(request.toJson())}');
      
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': authHeader,
        },
        body: jsonEncode(request.toJson()),
      );

      print('🔵 [WalletRepository] Response status code: ${response.statusCode}');
      print('🔵 [WalletRepository] Response body: ${response.body}');

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200 || response.statusCode == 201) {
        final depositResponse = WalletDepositResponseModel.fromJson(responseData);
        print('✅ [WalletRepository] Deposit request successful');
        print('✅ [WalletRepository] Payment URL: ${depositResponse.data.paymentUrl}');
        return depositResponse;
      } else if (response.statusCode == 401) {
        print('🔴 [WalletRepository] Unauthenticated - clearing token');
        await StorageService.clearToken();
        throw UnauthenticatedException('Session expired. Please login again.');
      } else {
        final errorMessage = responseData['message'] as String? ?? 
                           'Deposit failed. Please try again.';
        print('🔴 [WalletRepository] Deposit failed: $errorMessage');
        throw Exception(errorMessage);
      }
    } on http.ClientException catch (e) {
      print('🔴 [WalletRepository] Network error: $e');
      throw Exception('Network error. Please check your internet connection.');
    } on UnauthenticatedException {
      rethrow;
    } catch (e) {
      print('🔴 [WalletRepository] Unexpected error: $e');
      if (e is Exception) {
        rethrow;
      }
      throw Exception('An unexpected error occurred. Please try again.');
    }
  }

  Future<WalletBalanceResponseModel> getBalance() async {
    try {
      print('🔵 [WalletRepository] Starting wallet balance fetch');
      
      final url = Uri.parse(ApiConfig.getFullUrl(ApiConfig.walletBalanceEndpoint));
      print('🔵 [WalletRepository] URL: $url');
      
      final authHeader = await StorageService.getAuthHeader();
      if (authHeader == null) {
        print('🔴 [WalletRepository] No authentication token found');
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

      print('🔵 [WalletRepository] Response status code: ${response.statusCode}');
      print('🔵 [WalletRepository] Response body: ${response.body}');

      final responseData = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        final balanceResponse = WalletBalanceResponseModel.fromJson(responseData);
        print('✅ [WalletRepository] Balance fetch successful');
        print('✅ [WalletRepository] Balance: ${balanceResponse.data.balance} ${balanceResponse.data.currency}');
        print('✅ [WalletRepository] Available Balance: ${balanceResponse.data.availableBalance}');
        return balanceResponse;
      } else if (response.statusCode == 401) {
        print('🔴 [WalletRepository] Unauthenticated - clearing token');
        await StorageService.clearToken();
        throw UnauthenticatedException('Session expired. Please login again.');
      } else {
        final errorMessage = responseData['message'] as String? ?? 
                           'Failed to fetch wallet balance. Please try again.';
        print('🔴 [WalletRepository] Balance fetch failed: $errorMessage');
        throw Exception(errorMessage);
      }
    } on http.ClientException catch (e) {
      print('🔴 [WalletRepository] Network error: $e');
      throw Exception('Network error. Please check your internet connection.');
    } on UnauthenticatedException {
      rethrow;
    } catch (e) {
      print('🔴 [WalletRepository] Unexpected error: $e');
      if (e is Exception) {
        rethrow;
      }
      throw Exception('An unexpected error occurred. Please try again.');
    }
  }
}

