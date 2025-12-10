class ApiConfig {
  static const String baseUrl = 'https://valiant-nourishment-fixtech.up.railway.app/api';
  
  // Endpoints
  static const String loginEndpoint = '/v1/customer/login';
  static const String registerEndpoint = '/v1/customer/register';
  static const String logoutEndpoint = '/v1/customer/logout';
  static const String walletDepositEndpoint = '/v1/customer/wallet/deposit';
  static const String walletBalanceEndpoint = '/v1/customer/wallet/balance';
  static const String profileEndpoint = '/v1/customer/profile';
  
  // Helper method to get full URL
  static String getFullUrl(String endpoint) {
    return '$baseUrl$endpoint';
  }
}

